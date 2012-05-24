;; frame maximizer

;; - biggest width to maximize to (needed with >1 display)
(setq mf-max-width 1920)
;; - maximize on startup
(add-hook 'window-setup-hook 'maximize-frame t)
;; - keybind to maximize Emacs
;(global-set-key [(meta return)] 'mf)
