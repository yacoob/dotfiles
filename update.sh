#!/bin/bash

source ~/.yacoob-conf
branch=master
remote=origin

cd ${CONFDIR}
git remote update ${remote} > /dev/null 2>&1 || exit 1
reslog=$(git log ${branch}..origin/${branch} --oneline)
if [[ "${reslog}" != "" ]] ; then
  touch ~/.conf-update-available
fi
