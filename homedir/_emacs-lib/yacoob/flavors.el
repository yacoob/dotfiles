;; settings for different versions of Emacs

;; text mode Emacs:
(unless window-system
  ;; - remove menu bar
  (menu-bar-mode 0))

;; any graphical Emacs:
(when window-system
  ;; - make right Meta a system modifier
  (setq ns-right-alternate-modifier nil)
  ;; - use system clipboard for cut/paste
  (setq x-select-enable-clipboard t))

;; OSX Emacs:
(when (eq window-system 'ns)
  ;; - set default font
  (set-face-attribute 'default nil :font
                      "-apple-Menlo-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1")
  ;; - set server socket path
  (setq server-socket-dir (concat user-emacs-directory "server/server"))
  ;; - map M-RET to fullscreen
  (global-set-key [(meta return)] 'ns-toggle-fullscreen)
  ;; - map <del> key to expected action
  (global-set-key (kbd "<kp-delete>") 'delete-char)
  ;; - add useful things to PATH
  (setenv "PATH" (concat "/opt/local/bin:" (getenv "PATH")))
  (push "/opt/local/bin" exec-path))

(report-startup-time nil "OS-specific settings done")
