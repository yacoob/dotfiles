#!/bin/sh
podman run -it --rm \
  --userns=keep-id --security-opt label=disable \
  -v /home/yacoob/.ssh:/home/yacoob/.ssh:ro \
  yacoob/interactive:base
