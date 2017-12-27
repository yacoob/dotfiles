#!/usr/bin/env bash
OS=${OS:-linux}
LOCATION=${LOCATION:-home}
TARGET=${HOME}/.dotrepo
BRANCH=new-layout
METAFILE=${HOME}/.yacoob-conf
CONFDIR=${HOME}/workarea/conf

# helper function to operate on conf repository
confgit() {
  git --git-dir=${TARGET} --work-tree=${HOME} $@
}

# pull in the repo
git clone --bare -b ${BRANCH} https://github.com/yacoob/conf ${TARGET}
confgit config status.showUntrackedFiles no
confgit config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
confgit fetch
confgit checkout -f ${BRANCH}
confgit branch --set-upstream-to=origin/${BRANCH} ${BRANCH}

# set up meta config
rm -f ${METAFILE}
echo "export OS=${OS}" > ${METAFILE}
echo "export LOCATION=${LOCATION}" >> ${METAFILE}
echo "export CONFDIR=${CONFDIR}" >> ${METAFILE}
echo "export CONFREPODIR=${TARGET}" >> ${METAFILE}
echo "export CONFBRANCH=${BRANCH}" >> ${METAFILE}
chmod u=r,go= ${METAFILE}
echo "${METAFILE} now contains:"
cat ${METAFILE}

# run OS-specific script if there is one
s=${CONFDIR}/${OS}/init.sh
[[ -x $s ]] && echo "Now run $s by hand."
