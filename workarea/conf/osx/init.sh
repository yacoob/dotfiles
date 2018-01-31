#!/usr/bin/env bash
#set -x
source ~/.yacoob-conf
BASEDIR=${CONFDIR}/osx

# Main screen turn on!
if [[ "$1" == "-n" ]]; then
    DEBUG="echo "
fi

# Install homebrew packages.
BREW_PREFIX=~/brew
BREW_LIST_FILE=${BASEDIR}/brew.list
CASK_LIST_FILE=${BASEDIR}/cask.list
BREW=${BREW_PREFIX}/bin/brew
if [[ ! -x "${BREW}" ]]; then
  ${DEBUG} mkdir -p ${BREW_PREFIX}
  ${DEBUG} curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ${BREW_PREFIX}
fi
export HOMEBREW_NO_ANALYTICS=1
${DEBUG} ${BREW} update
${DEBUG} ${BREW} analytics off
${DEBUG} ${BREW} install $(cat ${BREW_LIST_FILE}) $(cat ${BREW_LIST_FILE}.${LOCATION} 2>/dev/null )
${DEBUG} ${BREW} tap caskroom/cask
${DEBUG} ${BREW} tap caskroom/fonts
${DEBUG} ${BREW} cask install $(cat ${CASK_LIST_FILE} ${CASK_LIST_FILE}.${LOCATION} 2>/dev/null )
${DEBUG} ${BREW} cleanup -s
ZSH=${BREW_PREFIX}/bin/zsh
grep -q "${ZSH}" /etc/shells
if [[ $? -ne 0 ]]; then
    echo "${ZSH}" | sudo tee -a /etc/shells
fi

# Apply OSX tweaks.
while read line; do
  ${DEBUG} defaults write ${line}
done < ${BASEDIR}/tweaks

# Make sure ~/.yacoob-conf is available for gui apps (ie. MacVim)
grep -q '.yacoob-conf' /etc/zshenv
if [[ $? -ne 0 ]]; then
  echo 'source ~/.yacoob-conf' | sudo tee -a /etc/zshenv
  ${DEBUG} chmod a+r /etc/zshenv
fi

# Link iTerm's remotes
d="${HOME}/Library/Application Support/iTerm2/DynamicProfiles"
[[ -d "$d" ]] || mkdir -p "${d}"
${DEBUG} ln -sf "${BASEDIR}/iterm.remotes" "${HOME}/Library/Application Support/iTerm2/DynamicProfiles/remotes"

# Drop in plists.
for file in ${BASEDIR}/plists/*.plist; do
  ${DEBUG} cp -f ${file} ${HOME}/Library/Preferences/${file##*/}
done
