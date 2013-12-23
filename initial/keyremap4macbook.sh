#!/bin/sh

cli=/Applications/KeyRemap4MacBook.app/Contents/Applications/KeyRemap4MacBook_cli.app/Contents/MacOS/KeyRemap4MacBook_cli

$cli set remap.pointing_relative_mousebutton4_to_scroll 1
/bin/echo -n .
$cli set remap.simultaneouskeypresses_expose_kl 1
/bin/echo -n .
$cli set remap.pointing_leftrightclick2expose 1
/bin/echo -n .
$cli set remap.controlL2controlL_escape 1
/bin/echo -n .
$cli set remap.vimode_toggle_commandLR 1
/bin/echo -n .
$cli set remap.iso_swap_tilda_section 1
/bin/echo -n .
/bin/echo
