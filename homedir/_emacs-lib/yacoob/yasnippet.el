;; yasnippet config

;; use yasnippet everywhere
(yas/global-mode 1)

;; load custom snippets
;(yas/load-directory "~/.emacs-lib/yacoob/yasnippets")

;; function to use for presenting choice of snippets to use
(setq yas/prompt-functions
    '(yas/x-prompt
      yas/dropdown-prompt
      yas/ido-prompt
      yas/completing-prompt))

;; replace yasnippets's TAB
(add-hook 'yas/minor-mode-hook
          (lambda () (define-key yas/minor-mode-map
                       (kbd "TAB") 'smart-tab))) ; was yas/expand

