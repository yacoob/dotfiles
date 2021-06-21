#!/usr/bin/env bash
TARGET=${HOME}/.dotrepo
DEFAULT_PULL_URL="https://github.com/yacoob/conf"
REPO_PULL_URL=${REPO_PULL_URL:-${DEFAULT_PULL_URL}}
REPO_PUSH_URL=${REPO_PUSH_URL:-git@github.com:yacoob/conf.git}
BRANCH=${BRANCH:-master}
REPO_IS_DETACHED_HEAD=${REPO_IS_DETACHED_HEAD:-false}
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
echo "Trying to clone the config files."
echo "  from: ${REPO_PULL_URL}"
echo "  branch: ${BRANCH}"
# Are we cloning from a normal repository or a detached HEAD one?
# The latter shows up in Github's CI during pull requests.
if [[ "${REPO_IS_DETACHED}" = "false" ]]; then
  # Normal repository.
  set -e
  echo "I'm assuming the repo contains the branch I'd like to pull."
  # Fetch latest revision of specified branch.
  git clone --depth 1 --bare -b ${BRANCH} ${REPO_PULL_URL} ${TARGET}
  # Populate the work tree.
  confgit checkout
 else
  set -e
  echo "I'm assuming the remote repo has a detached HEAD and not the branch I'd like to pull."
  # Fetch latest revision; there's no information about which branch is it
  # though.
  git clone --depth 1 --bare ${REPO_PULL_URL} ${TARGET}
  # ...so we can create a matching branch locally.
  confgit checkout -B ${BRANCH}
fi
# Don't complain about other files in ~ that are not part of this repo.
confgit config status.showUntrackedFiles no
# Normalize the remote URLs regardless of where we've cloned from:
# - we should always pull from Github over https
# - we should always push to Github over ssh
confgit remote set-url origin --push ${REPO_PUSH_URL}
confgit remote set-url origin ${DEFAULT_PULL_URL}
set +e

# set up meta config
rm -f ${METAFILE}
echo "export CONFDIR=${CONFDIR}" >> ${METAFILE}
echo "export CONFREPODIR=${TARGET}" >> ${METAFILE}
echo "export CONFBRANCH=${BRANCH}" >> ${METAFILE}
chmod u=r,go= ${METAFILE}
echo "${METAFILE} now contains:"
cat ${METAFILE}
