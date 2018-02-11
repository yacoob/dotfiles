#!/usr/bin/env bash
#set -x
source ~/.yacoob-conf
BASEDIR=${CONFDIR}/linux

# Main screen turn on!
if [[ "$1" == "-n" ]]; then
    DEBUG="echo "
fi

# Install homebrew packages.
BREW_PREFIX=~/.linuxbrew
BREW=${BREW_PREFIX}/bin/brew
BREW_LIST_FILE=${BASEDIR}/brew.list
if [[ ! -x "${BREW}" ]]; then
  ${DEBUG} sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
fi
${DEBUG} ${BREW} analytics off
${DEBUG} ${BREW} install $(cat ${BREW_LIST_FILE}) $(cat ${BREW_LIST_FILE}.${LOCATION} 2>/dev/null )
${DEBUG} ${BREW} cleanup -s
