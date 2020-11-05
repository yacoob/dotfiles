#!/usr/bin/env bash
OS=${OS:-linux}
LOCATION=${LOCATION:-home}
TARGET=${HOME}/.dotrepo
DEFAULT_PULL_URL="https://github.com/yacoob/conf"
REPO_PULL_URL=${REPO_PULL_URL:-${DEFAULT_PULL_URL}}
REPO_PUSH_URL=${REPO_PUSH_URL:-git@github.com:yacoob/conf.git}
BRANCH=${BRANCH:-master}
METAFILE=${HOME}/.yacoob-conf
CONFDIR=${HOME}/workarea/conf

# helper function to operate on conf repository
confgit() {
  git --git-dir=${TARGET} --work-tree=${HOME} $@
}

# pull in the repo
#
# Look, I know `set -e` is not the best idea as the shell will pout and exit on
# any non-zero exit status. This entire section is all single command git calls
# though, and if any of them fails it leaves the target dir in possibly weird
# state. In a docker build process this also results in *next* build steps
# failing in a weird manner. So I want this block below to succed fsvo
# 'success' but sure as hell I'm not going to write error checking for every
# single command.
set -e
echo "Trying to clone branch: ${BRANCH}"
git clone --depth 1 --bare -b ${BRANCH} ${REPO_PULL_URL} ${TARGET}
confgit config status.showUntrackedFiles no
confgit config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
confgit fetch
confgit checkout -f ${BRANCH}
confgit branch --set-upstream-to=origin/${BRANCH} ${BRANCH}
# Normalize the remote URLs regardless of where we've cloned from:
# - we should always pull from Github over https
# - we should always push to Github over ssh
confgit remote set-url origin --push ${REPO_PUSH_URL}
confgit remote set-url origin ${DEFAULT_PULL_URL}
set +e

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
if [[ -x $s ]]; then
  echo "Now run $s by hand."
fi
