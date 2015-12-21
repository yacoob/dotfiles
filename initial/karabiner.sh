#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set repeat.wait 23
/bin/echo -n .
$cli set repeat.initial_wait 300
/bin/echo -n .
$cli set remap.pointing_leftrightclick2expose 1
/bin/echo -n .
$cli set remap.iso_swap_tilda_section 1
/bin/echo -n .
/bin/echo
