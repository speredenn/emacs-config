;;; -*- mode: emacs-lisp -*-

(message "Happy hacking!")
(setq initial-scratch-message ";; Happy hacking!\n")

;;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync)

;;; Menu
(menu-bar-mode -1)
(tool-bar-mode -1)

;;; Font
(setq default-frame-alist '((font . "Droid Sans Mono-10")))

;;; Ido
(when (> emacs-major-version 21)
  (ido-mode t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point t
        ido-max-prospects 10))

(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)

;;; git, magit, and diff
(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")))

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))

;;; Unicode

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(setq-default default-process-coding-system '(utf-8 . utf-8))
(set-language-environment "UTF-8")
(set-input-method nil)
(setq read-quoted-char-radix 10)

;;; Misc stuffs

(defalias 'yes-or-no-p 'y-or-n-p)

(setq visible-bell nil
      echo-keystrokes 0.1
      font-lock-maximum-decoration t
      transient-mark-mode t
      inhibit-startup-message t
      shift-select-mode nil
      color-theme-is-global t
      delete-by-moving-to-trash t
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward)

;; Search function
(setq search-highlight 1
      query-replace-highlight 1)

;; Fringe
(setq fringe-mode '(1 . 0))

;; Copy-Paste integrated with the others X clients
(setq x-select-enable-clipboard 1
      interprogram-paste-function
      'x-cut-buffer-or-selection-value)

;; CUA-mode, but with no keybindings
(setq cua-enable-cua-keys nil)
(cua-mode 1)
(delete-selection-mode 1)

;; icomplete
(icomplete-mode 1)
(setq icomplete-prospects-height 1
      icomplete-compute-delay 0)
(require 'icomplete+ nil 'noerror)

;; smart-operator
(require 'smart-operator nil 'noerror)

;;; * Keybindings

(global-set-key [f1] 'menu-bar-mode)

(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "C-h a") 'apropos)

(define-key global-map "\C-ca" 'org-agenda)

(define-key global-map "\C-cl" 'org-store-link)

(define-key global-map "\C-x\C-r" 'rgrep)

(global-set-key (kbd "C-<f4>") 'kill-buffer-and-window)
(global-set-key (kbd "C-<f5>") 'linum-mode)
(global-set-key (kbd "C-<f6>") 'magit-status)
(global-set-key (kbd "C-<f7>") 'compile)
(global-set-key (kbd "C-<f8>") 'comment-or-uncomment-region)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "<delete>") 'delete-char)
(global-set-key (kbd "M-g") 'goto-line)

(when (fboundp 'ibuffer)
  (global-set-key (kbd "C-x C-b") 'ibuffer))

;; color-theme

(color-theme-solarized-dark)

;; Python

(defmacro after (mode &rest body)
  `(eval-after-load ,mode
     '(progn ,@body)))

(after 'auto-complete
       (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
       (setq ac-use-menu-map t)
       (define-key ac-menu-map "\C-n" 'ac-next)
       (define-key ac-menu-map "\C-p" 'ac-previous))

(after 'auto-complete-config
       (ac-config-default)
       (when (file-exists-p (expand-file-name "/Users/dcurtis/.emacs.d/elisp/Pymacs"))
         (ac-ropemacs-initialize)
         (ac-ropemacs-setup)))

(after 'auto-complete-autoloads
       (autoload 'auto-complete-mode "auto-complete" "enable auto-complete-mode" t nil)
       (add-hook 'python-mode-hook
                 (lambda ()
                   (require 'auto-complete-config)
                   (add-to-list 'ac-sources 'ac-source-ropemacs)
                   (auto-complete-mode))))

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
