#!/bin/sh
if [ "$(id -u yacoob)" != "${UID}" -o "$(id -g yacoob)" != "${GID}" ]; then
  echo "Adjusting ~ ownership to be ${UID}:${GID}."
  # change group's id, its users are updated, files in ~ are unaffected
  groupmod --gid ${GID} yacoob
  # change user's id, files in ~ are updated, but their group stays the same
  # because at this point yacoob's group is already updated...
  usermod --uid ${UID} --gid ${GID} yacoob
  # ...so we chgrp those manually
  chgrp -R ${GID} /home/yacoob
fi
exec sudo -u yacoob -i
