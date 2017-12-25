#!/bin/bash
source ~/.yacoob-conf
branch=master
remote=origin
dotrepo remote update ${remote} > /dev/null 2>&1 || exit 1
reslog=$(dotrepo diff ${remote}/${branch})
if [[ "${reslog}" != "" ]] ; then
  touch ~/.conf-update-available
fi
