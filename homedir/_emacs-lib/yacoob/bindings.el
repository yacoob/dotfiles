;; keybindings

;; easy resizing of windows
(global-set-key (kbd "C-M->") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-<") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-+") 'enlarge-window)
(global-set-key (kbd "C-M-_") 'shrink-window)

;; map the window manipulation keys to meta-{0,1,2,o}
(global-set-key (kbd "M-3") 'split-window-horizontally) ; was digit-argument
(global-set-key (kbd "M-2") 'split-window-vertically) ; was digit-argument
(global-set-key (kbd "M-1") 'delete-other-windows) ; was digit-argument
(global-set-key (kbd "M-0") 'delete-window) ; was digit-argument
(global-set-key (kbd "M-o") 'other-window) ; was facemenu-keymap
(global-unset-key (kbd "C-x 3")) ; was split-window-horizontally
(global-unset-key (kbd "C-x 2")) ; was split-window-vertically
(global-unset-key (kbd "C-x 1")) ; was delete-other-windows
(global-unset-key (kbd "C-x 0")) ; was delete-window
(global-unset-key (kbd "C-x o")) ; was other-window

;; easy killing of the buffer
(global-set-key (kbd "M-k") 'kill-this-buffer)

;; automatically indent new lines
(define-key global-map (kbd "RET") 'newline-and-indent)

;; better buffer selector
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; easy navigation between windows
(windmove-default-keybindings 'meta)
