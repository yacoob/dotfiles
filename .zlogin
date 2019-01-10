if [[ -z "${TMUX}" && ! -f tmux-inhibit ]]; then
  if [[ "${LOCATION}" == "office" && "${OS}" == "linux" ]]; then
    TMUX_CMD=tmx
  else
    TMUX_CMD=tmux
  fi
  if [[ "${OS}" == "osx" ]]; then
    # Start a session for fs iterm.
    ${TMUX_CMD} has-session -t fs || ${TMUX_CMD} new-session -d -s fs
  fi
  if [[ -n "${SSH_CONNECTION}" ]]; then
    SESSION_FILE=${HOME}/.tmux-attach-session-ssh
    FALLBACK_SESSION_NAME='tmp-ssh'
  else
    SESSION_FILE=${HOME}/.tmux-attach-session
    FALLBACK_SESSION_NAME='tmp'
  fi
  if [[ -r ${SESSION_FILE} ]]; then
    sname=$(<${SESSION_FILE})
  else
    sname=${FALLBACK_SESSION_NAME}
  fi
  ( ${TMUX_CMD} has-session -t ${sname} && ${TMUX_CMD} attach-session -t ${sname} ) || ( ${TMUX_CMD} new-session -s ${sname} )
fi
