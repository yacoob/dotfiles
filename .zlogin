# Maybe attach tmux session.
if [[ -z "${TMUX}" && ! -f ~/tmux-inhibit ]]; then
  if (( $+commands[tmux] )); then
    if [[ -n "${SSH_CONNECTION}" ]]; then
      SESSION_FILE=${HOME}/.tmux-attach-session-ssh
      FALLBACK_SESSION_NAME='ssh'
    else
      SESSION_FILE=${HOME}/.tmux-attach-session
      FALLBACK_SESSION_NAME='local'
    fi
    if [[ -r ${SESSION_FILE} ]]; then
      sname=$(<${SESSION_FILE})
    else
      sname=${FALLBACK_SESSION_NAME}
    fi
      tmux has-session -t ${sname} && tmux attach-session -t ${sname} || tmux new-session -s ${sname}
  fi
fi
