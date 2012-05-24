;; assorted settings

;; start server
(add-hook 'after-init-hook 'server-start)
(report-startup-time nil "server started")

;; set color theme (Emacs 24)
(load-theme 'tango-dark t)

;; blink the cursor
(blink-cursor-mode 1)
;; set thick cursor
(set-default 'cursor-type 'box)
;; display column number
(column-number-mode 1)
;; always show line numbers
(global-linum-mode 1)
;; act on visual lines, not logical lines
(global-visual-line-mode 1)
;; highlight current line
(global-hl-line-mode 1)
;; more familiar cut/copy/paste shortcuts
(cua-mode 1)
;; save minibuffer history
(savehist-mode 1)
;; highlight matching parenths
(show-paren-mode 1)
;; no toolbar
(tool-bar-mode 0)
;; visual bell
(setq visible-bell t)
;; allow narrowing
(put 'narrow-to-region 'disabled nil)
;; calendars start on Monday
(setq calendar-week-start-day 1)
;; use system facility for removing files
(setq delete-by-moving-to-trash t)

;; better tab-completion in selected places
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-enable-prefix t
      ido-use-filename-at-point 'guess
      ido-create-new-buffer 'always)
;; automatic filling of paragraphs
(setq-default auto-fill-function 'do-auto-fill)
(set-default 'fill-column 80)
;; wrapping of displayed text
(setq truncate-lines t)
(setq truncate-partial-width-windows nil)
;; don't show informative splash screen
(setq initial-buffer-choice t)
(setq inhibit-startup-message t)
;; be less elaborate while asking about things
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)

;; highlight stray whitespace
(setq whitespace-style
  '(face trailing tabs indentation space-after-tab space-before-tab tab-mark))
(setq whitespace-display-mappings
 '((tab-mark 9 [9655 9] [2192 9] [92 9])))
(global-whitespace-mode 1)
;; clean trailing whitespace before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(report-startup-time nil "general settings done")
