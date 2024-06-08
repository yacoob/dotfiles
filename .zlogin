# Maybe update the conf files.
local mf=~/.conf-last-update
if [[ ! -z ${CONF_AUTO_UPDATE} && -r ${mf} ]]; then
  set -x
  zstat -H update_stat ${mf}
  local last_update_age=$(( $(strftime +%s) - ${update_stat[mtime]} ))
  if [[ ${last_update_age} -gt ${CONF_STALE_IF_OLDER_THAN} ]]; then
    echo "Attempting conf files update, as it's been $(humanize-seconds ${last_update_age}) since the last update:"
    conf-dir-update
    read
  fi
  set +x
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
