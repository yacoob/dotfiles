# Maybe update the conf files.
if [[ ! -z ${CONF_AUTO_UPDATE} ]]; then
  zstat -H update_stat ~/.conf-last-update
  local last_update_age=$(( $(strftime +%s) - ${update_stat[mtime]} ))
  if [[ ${last_update_age} > ${CONF_STALE_IF_OLDER_THAN} ]]; then
    echo "Attempting conf files update, as it's been $(humanize-seconds ${last_update_age}) since the last update:"
    conf-dir-update
  fi
fi

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
