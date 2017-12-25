#!/usr/bin/env zsh
shopt -s extglob

# check usage
if  [[ $# -ne 2 ]]; then
  echo "  Usage: $0 <OS> <LOCATION>"
  echo "example: $0 osx home"
  exit 1
fi

# helper function to operate on conf repository
dotrepo() { git --git-dir=${TARGET} --work-tree=${HOME} $@}

# pull in the repo
TARGET=${HOME}/.dotrepo
BRANCH=new-layout
git clone --bare -b ${BRANCH} https://github.com/yacoob/conf ${TARGET}
dotrepo config status.showUntrackedFiles no
dotrepo config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
dotrepo fetch
dotrepo checkout ${BRANCH}
if [ $? != 0 ]; then
  BKP=~/dotrepo-backup
  mkdir ${BKP}
  files=($(dotrepo checkout 2>&1 | egrep '\s+\.'))
  foreach f ($files) { mv ${f} ${BKP}/ }
  dotrepo checkout -b host-$(hostname) --track origin/${BRANCH}
fi

# create local meta config
FILE=${HOME}/.yacoob-conf
CONFDIR=${TARGET}
rm -f ${FILE}
echo "export OS=$1" > ${FILE}
echo "export LOCATION=$2" >> ${FILE}
echo "export CONFDIR=${CONFDIR}" >> ${FILE}
chmod u=r,go= ${FILE}

echo "${FILE} now contains:"
cat ${FILE}
