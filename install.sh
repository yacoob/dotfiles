#!/usr/bin/env bash
shopt -s extglob


# Helper function to complain about a problem and die.
# (wait, is that Perl? :)
croak() {
    echo "Error: $1"
    exit $2
}


# Check if dst already links to src. If not, fix that.
relink() {
    src=${BASEDIR}/$1
    dst=${TARGETDIR}/$(mangle_filename "$1")

    # Is $dst already a link and pointing to $src?
    if [[ -L "${dst}" ]]; then
        actual_src=$(readlink "${dst}")
        if [[ "${actual_src}" == "${src}" ]]; then
            return
        fi
    fi

    # If it isn't, we should make it so.
    ${DEBUG} rm -fR "${dst}"
    ${DEBUG} ln -sfn "${src}" "${dst}"
}


# Unconditionally copy src to dst.
update() {
    src=${BASEDIR}/$1
    dst=${TARGETDIR}/$(mangle_filename "$1")

    # Special actions per file type.
    case "${dst}" in
      *.plist)
        d=${dst##*/}
        d=${d%.*}
        ${DEBUG} defaults delete ${d} ;;
    esac
    ${DEBUG} cp -fR "${src}" "${dst}"
}


# Create a directory, if it doesn't exist yet.
makedir() {
    dst=${TARGETDIR}/$(mangle_filename "$*")

    # Does directory already exist?
    if [[ -d "${dst}" ]]; then
        return
    fi

    # If dst is a link, remove it.
    if [[ -L "${dst}" ]]; then
        ${DEBUG} rm -f "${dst}"
    fi

    # Actually make a directory.
    ${DEBUG} mkdir -p "${dst}"
}

# Helper function to work out proper destination path.
# Underscores at the beginning of the filename get translated to dots.
mangle_filename() {
    input=$1
    input=$(echo ${input} | sed 's#^_#.#')
    input=$(echo ${input} | sed 's#/_#/.#g')
    echo ${input}
}


# Process a single manifest line.
process_manifest_line() {
    line=$*
    if [[ "${line}" != *([>=#])+([[:word:]\\ ./_-]) ]]; then
        croak "Malformed line in manifest: ${line}" 6
        return
    fi
    char=${line:0:1}
    case "${char}" in
        "#") return ;;
        "=") op="makedir"; file=${line:1} ;;
        ">") op="update";  file=${line:1} ;;
          *) op="relink";  file=${line} ;;
    esac
    if [[ ! -r "${file}" ]]; then
        croak "Couldn't read file specified in manifest: ${file}" 3
    fi
    ${op} "${file}"
}


# Main screen turn on!
if [[ "$1" == "-n" ]]; then
    DEBUG="echo "
fi

# Set up environment.
. ${HOME}/.yacoob-conf
if [[ -z "${OS}" ]] || [[ -z "${LOCATION}" ]] || [[ -z "${CONFDIR}" ]]; then
    croak "Please fix your config file: ${CONFIGFILE}" 5
fi
BASEDIR=${CONFDIR}/homedir
TARGETDIR=${HOME}
cd ${BASEDIR}

# Grab a manifest.
MANIFEST=${CONFDIR}/manifests/${OS}-${LOCATION}
if [[ ! -r ${MANIFEST} ]]; then
    croak "Manifest file not found: ${MANIFEST}" 2
fi

# Walk through list of files.
while read line; do
    process_manifest_line ${line}
done < ${MANIFEST}
