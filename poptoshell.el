;; Handy-dandy function for getting to (the right place in) a
;; shell-interaction buffer.
;;
;; I bind to meta-<space>, via eg: (global-set-key "\M- " 'pop-to-shell)
;;
;; klm, 02/09/1999.

(defvar non-interactive-process-buffers '("*compilation*" "*grep*"))
(defun pop-to-shell (&optional arg)

  "Like 'shell' command, but:

 - goes to the process mark in current buffer, if it is associated
   with a process \(and not among those named on
   `non-interactive-process-buffers'), or 
 - goes to a window that is already showing a shell buffer, if any
   \(leaving the cursor in the current position - repeating the
    invocation will then go to the process mark)
 - pops open a new shell buffer, if necessary
 - A repeat count prompts for the buffer name to use \(which will be
   bracketed by asterisks - a regrettable comint requirement\).

Thus you can use this command from within the shell buffer to get to
the shell input point, or from outside the shell buffer to pop to a
shell buffer, without displacing the current buffer."

  (interactive "P")

  (require 'comint)
  (require 'shell)

  (if (not (boundp 'shell-buffer-name))
      (setq shell-buffer-name "*shell*"))

  (let* ((from (current-buffer))
         (temp (if arg
                   (read-from-minibuffer
                    (format "Shell buffer name [%s]: " shell-buffer-name))
                 shell-buffer-name))
         ;; Make sure it is bracketed with asterisks; silly.
         (target-shell-buffer-name (if (string= temp "")
                                       shell-buffer-name
                                     (bracket-asterisks temp)))
         (curr-buff-proc (get-buffer-process from))
         (buff (if (and curr-buff-proc
                        (not (member (buffer-name from)
                                     non-interactive-process-buffers)))
                   from
                 (get-buffer target-shell-buffer-name)))
         (inwin nil)
         (num 0)
         already-there)
    (if (and curr-buff-proc
             (not arg)
             (eq from buff)
             (not (eq target-shell-buffer-name (buffer-name from))))
        ;; We're in a buffer with a shell process, but not named shell
        ;; - stick with it, but go to end:
        (setq already-there t)
      (cond
       ;;;                                     ; Force other:
       ;;;(arg (switch-to-buffer shell-buffer-name))
                                        ; Already in the shell buffer:
       ((string= (buffer-name) target-shell-buffer-name)
        (setq already-there t))
       ((or (not buff)
            (not (catch 'got-a-vis
                   (walk-windows
                    (function (lambda (win) (if (eq (window-buffer win) buff)
                                                (progn
                                                  (setq inwin win)
                                                  (throw 'got-a-vis t))
                                              (setq num (1+ num)))))
                    nil)
                   nil)))
        ;; No preexisting shell buffer, or not in a visible window:
        (pop-to-buffer target-shell-buffer-name pop-up-windows))
       ;; Buffer exists and already has a window - jump to it:
       (t (if (and inwin (not (equal (window-frame (selected-window))
                                     (window-frame inwin))))
              (progn
                (select-frame (window-frame inwin))
                (raise-frame)
                (set-mouse-position (selected-window) (1- (frame-width)) 0)))
          (if (not (string= (buffer-name (current-buffer))
                            target-shell-buffer-name))
              (pop-to-buffer target-shell-buffer-name t))))
      (condition-case err
          (if (not (comint-check-proc (current-buffer)))
              (start-shell-in-buffer (buffer-name (current-buffer))))
        (file-error
         ;; Whoops - can't get to the default directory, keep trying
         ;; superior ones till we get somewhere that's acceptable:
         (while (and (not (string= default-directory ""))
                     (not (condition-case err (progn (shell) t)
                            (file-error nil))))
           (setq default-directory
                 (file-name-directory
                  (substring default-directory
                             0
                             (1- (length default-directory)))))))
        ))
    (if (and (not already-there)
             (not (equal (current-buffer) from)))
        t
      (goto-char (point-max))
      (goto-char (process-mark (get-buffer-process from))))))
(defun bracket-asterisks (name)
  "Return a copy of name, ensuring it has an asterisk at the beginning and end."
  (if (not (string= (substring name 0 1) "*"))
      (setq name (concat "*" name)))
  (if (not (string= (substring name -1) "*"))
      (setq name (concat name "*")))
  name)
(defun unbracket-asterisks (name)
  "Return a copy of name, removing asterisks at beg and end, if any."
  (if (string= (substring name 0 1) "*")
      (setq name (substring name 1)))
  (if (string= (substring name -1) "*")
      (setq name (substring name 0 -1)))
  name)
(defun start-shell-in-buffer (buffer-name)
  ;; Damn comint requires buffer name be bracketed by "*" asterisks.
  (require 'comint)
  (require 'shell)

  (let* ((buffer buffer-name)
         (prog (or explicit-shell-file-name
                   (getenv "ESHELL")
                   (getenv "SHELL")
                   "/bin/sh"))              
         (name (file-name-nondirectory prog))
         (startfile (concat "~/.emacs_" name))
         (xargs-name (intern-soft (concat "explicit-" name "-args"))))
    (setq buffer (set-buffer (apply 'make-comint
                                    (unbracket-asterisks buffer-name)
                                    prog
                                    (if (file-exists-p startfile)
                                        startfile)
                                    (if (and xargs-name
                                             (boundp xargs-name))
                                        (symbol-value xargs-name)
                                      '("--login")))))
    (set-buffer buffer-name)
    (shell-mode)))
