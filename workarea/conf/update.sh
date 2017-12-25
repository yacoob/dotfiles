#!/usr/bin/env zsh
source ~/.yacoob-conf
confgit remote update origin > /dev/null 2>&1 || exit 1
reslog=$(confgit log ${CONFBRANCH}..origin/${CONFBRANCH} --oneline)
if [[ "${reslog}" != "" ]] ; then
  touch ~/.conf-update-available
fi
