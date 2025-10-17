#!/bin/sh
set -eux

# trust the existing config files
mise trust ~/.config/mise/conf.d/settings.toml
mise trust ~/.config/mise/conf.d/initial.toml

# create an empty config file that will serve as the default destination of `mise use -g`
touch ~/.config/mise/config.toml
mise trust ~/.config/mise/config.toml

# display trusted configs for verification
mise config
