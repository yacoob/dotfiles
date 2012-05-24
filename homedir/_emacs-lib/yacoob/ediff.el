;; ediff config

(setq
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 ediff-make-buffers-readonly-at-startup 't
 ediff-keep-variants nil)

(report-startup-time nil "ediff configured")
