#!/usr/bin/env bash
#set -x
source ~/.yacoob-conf
BASEDIR=${CONFDIR}/linux

# Main screen turn on!
if [[ "$1" == "-n" ]]; then
    DEBUG="echo "
fi

# Install homebrew packages.
BREW_PREFIX=~/brew
BREW_LIST_FILE=${BASEDIR}/brew.list
BREW=${BREW_PREFIX}/bin/brew
if [[ ! -x "${BREW}" ]]; then
  ${DEBUG} git clone https://github.com/Linuxbrew/brew.git ${BREW_PREFIX}
fi
${DEBUG} ${BREW} analytics off
${DEBUG} ${BREW} install $(cat ${BREW_LIST_FILE}) $(cat ${BREW_LIST_FILE}.${LOCATION} 2>/dev/null )
${DEBUG} ${BREW} cleanup -s
