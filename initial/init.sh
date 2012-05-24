#!/usr/bin/env bash
#set -x

# Helper function to complain about a problem and die.
# (wait, is that Perl? :)
croak() {
    echo "Error: $1"
    exit $2
}

# Install homebrew packages.
install_brew() {
  if [[ "${OS}" == "osx" ]]; then
    if [[ "${LOCATION}" == "office" ]]; then
      BREW_PREFIX=/usr/brew
    else
      BREW_PREFIX=/usr/local
    fi
    BREW=${BREW_PREFIX}/bin/brew
    if [[ ! -x "${BREW}" ]]; then
      ${DEBUG} mkdir -p ${BREW_PREFIX}
      cd ${BREW_PREFIX}
      ${DEBUG} curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C homebrew
    fi
    ${DEBUG} cd -
    ${DEBUG} ${BREW} install $(cat ${BREW_LIST_FILE})
    ${DEBUG} ${BREW} cleanup -s
    ${DEBUG} grep -q '$(BREW_PREFIX)/bin/zsh' /etc/shells || sudo sh -c 'echo "$(BREW_PREFIX)/bin/zsh" >> /etc/shells'
  fi
}

# Apply OSX tweaks.
apply_tweaks() {
  if [[ "${OS}" == "osx" ]]; then
    while read line; do
      ${DEBUG} defaults write ${line}
    done < ${TWEAKS_FILE}
  fi
}


# Set up environment.
. ${HOME}/.yacoob-conf
if [[ -z "${OS}" ]] || [[ -z "${LOCATION}" ]] || [[ -z "${CONFDIR}" ]]; then
    croak "Please fix your config file: ${CONFIGFILE}" 5
fi
BREW_LIST_FILE="./brew.list"
TWEAKS_FILE="./tweaks"

# Main screen turn on!
if [[ "$1" == "-n" ]]; then
    DEBUG="echo "
fi

install_brew
apply_tweaks
