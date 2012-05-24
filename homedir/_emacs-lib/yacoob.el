(add-to-list 'load-path "~/.emacs-lib/vendor")

(load "yacoob/defuns")
(load "yacoob/tabs")
(load "yacoob/flavors")
(load "yacoob/bindings")
(load "yacoob/settings")
(load "yacoob/ediff")

(vendor 'maxframe)
(vendor 'magit 'magit-status)
(vendor 'yasnippet)

(report-startup-time 't "all done")
