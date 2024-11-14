#!/bin/sh
podman run -it --rm \
  -v /home/yacoob/.ssh:/home/yacoob/.ssh:ro \
  yacoob/interactive
