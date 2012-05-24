;; functions

;; easy loading of third party code
(defun vendor (library &rest autoload-functions)
  "Load a library plus its settings, setup autoloads"
  (let* ((file (symbol-name library))
         (normal (concat "~/.emacs-lib/vendor/" file))
         (suffix (concat normal ".el"))
         (personal (concat "~/.emacs-lib/yacoob/" file))
         (found nil))
    (cond
     ((file-directory-p normal) (add-to-list 'load-path normal) (set 'found t))
     ((file-directory-p suffix) (add-to-list 'load-path suffix) (set 'found t))
     ((file-exists-p suffix)  (set 'found t)))
    (when found
      (if autoload-functions
          (dolist (autoload-function autoload-functions)
            (autoload autoload-function (symbol-name library) nil t))
        (require library)))
    (when (file-exists-p (concat personal ".el"))
      (load personal))
    (report-startup-time nil (concat file " loaded and configured"))))

;; James's functions to measure startup time.
(defun timelist-to-epoch-time (time)
  "Convert time from the format current-time returns it to a useful form."
  (let ((result))
    (setq result (nth 0 time))
    (setq result (* 65536.0 result))
    (setq result (+ (nth 1 time) result))
    (setq result (* 1000000.0 result))
    (setq result (+ (nth 2 time) result))
    result))

(defun time-now ()
  (timelist-to-epoch-time (current-time)))
(setq init-time-start (time-now))

(defun report-startup-time (&optional done label)
  "Report how long startup has taken, so far"
  (let ((microsec-elapsed (- (time-now) init-time-start))
        (labeltext (if label
                       (format " (%s)" label)
                     ""))
        (qualification (if done "" " so far")))
    (message "Startup took %g seconds%s%s."
             (/ microsec-elapsed 1000000.0) qualification labeltext)))

(report-startup-time nil "defuns done")
