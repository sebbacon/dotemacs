(setq inhibit-splash-screen t)
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/mode-compile"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/coffee-mode"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/eproject"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/eproject/lang"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/mo-git-blame"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-flymake"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/haml-mode"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/flymake-haml"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/rspec-mode"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/rdebug"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/smartparens"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-pry"))

;;(setenv "PATH" (concat (getenv "PATH") "/home/seb/.rvm/gems/ruby-1.9.3-p385/bin/"))
;;(setq exec-path (append exec-path '("/home/seb/.rvm/gems/ruby-1.9.3-p385/bin/")))

;;/usr/share/emacs/22.2/lisp/progmodes/
;;(add-to-list 'load-path "/usr/share/emacs/site-lisp/python-mode/")
(autoload 'pop-to-shell "poptoshell")
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(autoload 'grep-buffers "grep-buffers" "Grep in open buffers." t)
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(load-library "rdebug")
(autoload 'kill-ring-search "kill-ring-search"
  "Search the kill ring in the minibuffer."
  (interactive))


(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)
(global-set-key "\M-\C-y" 'kill-ring-search)

;;(add-hook 'python-mode-hook
;;                '(lambda ()
;;             (load "py-mode-ext")
;;             (load "pyp")
;;             (require 'pycomplete)
;;             (define-key py-mode-map [f12] 'pyp)
;;             (define-key py-mode-map "\C-c\C-c" 'py-execute-prog)
;;             (define-key py-mode-map "\C-c\C-g" 'py-call-pdb)
;;             (define-key py-mode-map "\C-c\C-w" 'pychecker)))
;;; for ruby mode
(setq ruby-indent-level 2)
(setq ruby-deep-indent-paren nil)
(setq js-indent-level 2)
(add-hook 'comint-mode-hook 'turn-on-rdebug-track-mode)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; for rspec output
;;(add-hook 'compilation-minor-mode-hook
;;          (lambda ()
;;             (set 'compilation-error-regexp-alist-alist
;;               '((rspec "^\\([# ]+\\s)\\([0-9A-Za-z_./\:-]+\\.rb\\):\\([0-9]+\\)" 2 3)))
;;             (set 'compilation-error-regexp-alist '(rspec))))
;; (require 'compile)

;;; For Python mode
(setq fill-column 79)
(setq python-mode-hook 'turn-on-auto-fill)
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python hacking mode." t)

(setq auto-mode-alist
      (append (list
               '("\\.fbml$" . html-mode)
               '("\\.rhtml$" . html-mode)
               '("\\.php$" . php-mode)
               '("\\.text" . markdown-mode)
               '("\\.rake" . enh-ruby-mode)
               '("Rakefile" . enh-ruby-mode)
               '("Gemfile" . enh-ruby-mode)
               '("\\.md" . markdown-mode))
            auto-mode-alist))

(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)) t)
(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)) t)
(require 'color-theme)
(require 'browse-url)
(require 'magit)
;;(require 'face-remap+)
(require 'uniquify)
(require 'regex-tool)
(require 'coffee-mode)
(require 'scss-mode)
(require 'eproject)
(require 'etags-select)
(require 'flymake)
(require 'flymake-ruby)
(require 'flymake-php)
(require 'flymake-haml)
(require 'whitespace)
(require 'haml-mode)
(require 'rspec-mode)
(require 'ansi-color)
;;(require 'pry)

(autoload 'magit-status "magit" nil t)
(global-set-key "\C-ci" 'magit-status)
(global-set-key "\C-ci" 'magit-status)

;; integrate X clipboard in sane way
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)

(color-theme-initialize)
(color-theme-classic)
(global-set-key "\M- " 'pop-to-shell)
(icomplete-mode)

(setq flymake-log-level 0)
(setq coffee-tab-width 4)
(setq scss-sass-command "/usr/local/bin/sass")
(setq scss-compile-at-save nil)
(setq css-indent-offset 2)

(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)
(sp-with-modes '(rhtml-mode)
               (sp-local-pair "<" ">")
               (sp-local-pair "<%" "%>"))

(add-hook 'php-mode-user-hook 'flymake-php-load)
(add-hook 'python-mode-hook
          '(lambda () (show-paren-mode 1)) t)

(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "pycheckers" (list local-file))))
    ;; see http://stackoverflow.com/questions/1259873/how-can-i-use-emacs-flymake-mode-for-python-with-pyflakes-and-pylint-checking-co
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init))

(add-hook 'find-file-hook 'flymake-find-file-hook)
(add-hook 'haml-mode-hook 'flymake-haml-load)

(add-to-list 'flymake-err-line-patterns
             '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
               nil 1 2 4))

(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(setq enh-ruby-bounce-deep-indent t)
(setq enh-ruby-hanging-brace-indent-level 2)


(defun clean-buffers ()
  "Kill all unmodified buffers, and some modified but useless ones."
  (interactive)
  (let ((list (buffer-list)))
    (while list
      (save-excursion
        (let ((buffer (set-buffer (car list))))
          (if (or (not (buffer-modified-p))
                  (eq major-mode 'dired-mode)
                  (string-match "\\*Help\\*\\|\\*Shell Command Output\\*" (buffer-name)))
              (kill-buffer buffer))))
      (setq list (cdr list)))))

;;; from http://www.delorie.com/gnu/docs/emacs-lisp-intro/emacs-lisp-intro_208.html
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")

;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)

;;; 2. Run the while loop.
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))

;;; 3. Send a message to the user.
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))

;;; automagically prompt to reopen a read-only file using sdo
(defun find-alternative-file-with-sudo ()
  (interactive)
  (let ((fname (or buffer-file-name
                   dired-directory)))
    (when fname
      (if (string-match "^/sudo:root@localhost:" fname)
          (setq fname (replace-regexp-in-string
                       "^/sudo:root@localhost:" ""
                       fname))
        (setq fname (concat "/sudo:root@localhost:" fname)))
      (find-alternate-file fname))))
(global-set-key (kbd "C-x C-r") 'find-alternative-file-with-sudo)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.32")
 '(explicit-bash-args (quote ("--noediting" "--login" "--init-file" "/home/seb/.bash_profile" "-i")))
 '(flymake-gui-warnings-enabled nil)
 '(grep-find-command "ack-grep --type-set=haml=.haml --noenv --no-heading --no-color ")
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(rdebug-track-do-tracking-p t)
 '(regex-tool-backend (quote perl))
 '(rspec-use-bundler-when-possible nil)
 '(rspec-use-opts-file-when-available nil)
 '(rspec-use-rake-flag nil)
 '(text-scale-resize-window t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 100)))))

(define-generic-mode 'wiki-mode
  nil ; comments
  nil; keywords
  '(("^\\(= \\)\\(.*?\\)\\($\\| =$\\)" . 'info-title-1)
    ("^\\(== \\)\\(.*?\\)\\($\\| ==$\\)" . 'info-title-2)
    ("^\\(=== \\)\\(.*?\\)\\($\\| ===$\\)" . 'info-title-3)
    ("^\\(====+ \\)\\(.*?\\)\\($\\| ====+$\\)" . 'info-title-4)
    ("\\[\\[.*?\\]\\]" . 'link)
    ("\\[.*\\]" . 'link)
    ("\\[b\\].*?\\[/b\\]" . 'bold)
    ("\\[i\\].*?\\[/i\\]" . 'italic)
    ("\\*\\*.*?\\*\\*" . 'bold)
    ("\\*.*?\\*" . 'bold)
    ("\\_<//.*?//" . 'italic)
    ("\\_</.*?/" . 'italic)
    ("__.*?__" . 'italic)
    ("_.*?_" . 'underline)
    ("|+=?" . font-lock-string-face)
    ("\\\\\\\\[ \t]+" . font-lock-warning-face)) ; font-lock list
  '(".wiki\\'"); auto-mode-alist
  '((lambda () (require 'info) (require 'goto-addr))); function-list
  "Wiki stuff including Creole Markup and BBCode.")

(defun insert-ruby-breakpoint ()
  "Insert a ruby breakpoint."
  (interactive)
  (insert "
require 'debugger'
debugger"))

(global-set-key (kbd "<f6>") 'insert-ruby-breakpoint)

(defun ansi-color-apply-on-region-int (beg end)
  "interactive version of func"
  (interactive "r")
  (ansi-color-apply-on-region beg end))

; Make Emacs UTF-8 compatible for both display and editing:
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

; whitespace stuff
(global-whitespace-mode 1)
(setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
;;; Prevent Extraneous Tabs
(setq-default indent-tabs-mode nil)
(setq whitespace-style '(trailing space-before-tab::space indentation::space empty space-after-tab::space)) ;; only show bad whitespace
;; nuke whitespaces when writing to a file
(add-hook 'before-save-hook 'whitespace-cleanup)

; ctags support
(setq path-to-ctags "/usr/bin/ctags")
(setq tags-case-fold-search nil)
(defun build-ctags ()
  (interactive)
  (message "building project tags")
  (let ((root (eproject-root)))
    (shell-command (concat "ctags -e -R --extra=+fq --exclude=db --exclude=test --exclude=.git --exclude=public -f " root "TAGS " root)))
  (visit-project-tags)
  (message "tags built successfully"))

(defun visit-project-tags ()
  (interactive)
  (let ((tags-file (concat (eproject-root) "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))

; check if tags file is there, if not build it, then read it and jump
; to the tag at the current point
(defun my-find-tag ()
  (interactive)
  (if (file-exists-p (concat (eproject-root) "TAGS"))
      (visit-project-tags)
    (build-ctags))
  (etags-select-find-tag-at-point))

(global-set-key (kbd "M-.") 'my-find-tag)

; use gnome's default browser to open urls
(setq browse-url-generic-program
          (substring (shell-command-to-string "gconftool-2 -g /desktop/gnome/applications/browser/exec") 0 -1)
          browse-url-browser-function 'browse-url-generic)

(global-set-key [double-mouse-1] 'browse-url-at-mouse)

; start an emacs server by default
(server-start)
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el")
     (require 'package)
     (add-to-list 'package-archives
                  '("marmalade" .
                    "http://marmalade-repo.org/packages/"))
     (add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
     (when (< emacs-major-version 24)
       (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))))
  (package-initialize))
(require 'pallet)
