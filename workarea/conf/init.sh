#!/usr/bin/env zsh
TARGET=${HOME}/.dotrepo
BRANCH=new-layout
METAFILE=${HOME}/.yacoob-conf
CONFDIR=${HOME}/workarea/conf

# check usage
if  [[ $# -ne 2 ]]; then
  echo "  Usage: $0 <OS> <LOCATION>"
  echo "example: $0 osx home"
  exit 1
fi

# helper function to operate on conf repository
dotrepo() { git --git-dir=${TARGET} --work-tree=${HOME} $@}

# pull in the repo
git clone --bare -b ${BRANCH} https://github.com/yacoob/conf ${TARGET}
dotrepo config status.showUntrackedFiles no
dotrepo config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
dotrepo fetch
dotrepo checkout ${BRANCH}
if [ $? != 0 ]; then
  # bkp any files that are conflicting with the ones from repo
  BKP=~/dotrepo-backup
  mkdir ${BKP}
  files=($(dotrepo checkout 2>&1 | egrep '\s+\.'))
  foreach f ($files) { mv ${f} ${BKP}/ }
  dotrepo checkout ${BRANCH}
fi

# set up meta config
rm -f ${METAFILE}
echo "export OS=$1" > ${METAFILE}
echo "export LOCATION=$2" >> ${METAFILE}
echo "export CONFDIR=${CONFDIR}" >> ${METAFILE}
echo "export DOTREPODIR=${TARGET}" >> ${METAFILE}
chmod u=r,go= ${METAFILE}
echo "${METAFILE} now contains:"
cat ${METAFILE}
