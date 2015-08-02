(server-start)

(progn
  ;; Keyboard favored, always
  (dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
    (when (fboundp mode) (funcall mode -1))))

;; No startup message
(setq inhibit-startup-message t)

;; No custom-settings in maintained files
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Backup files go into a specific folder
(setq
 backup-by-copying t ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs.d/backups")) ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t ; use versioned backups
 vc-make-backup-files t)

;; Packages

(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")
	("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
	("ELPA" . "http://tromey.com/elpa/")))

;; Load elpa repos if there is no local copy yet
(package-initialize)
(package-read-all-archive-contents)
(unless package-archive-contents
  (package-refresh-contents))

(defun package-install-if-missing (&rest packages)
  (dolist (package packages)
    (unless (package-installed-p package)
      (condition-case err
	  (package-install package)
	(error ; condition
	 (warn "Problems installing package `%s': %s" package (error-message-string err)))))))

(setq mypackages
      '(
        auctex
        auto-indent-mode
        browse-kill-ring
	diminish
        dired-details
        gist
        gitconfig-mode
        gitignore-mode
        highlight-indentation
        ido-ubiquitous
        magit
        magit-gh-pulls
        markdown-mode
        org
        paredit
        rainbow-delimiters
	smooth-scrolling
	undo-tree
	yasnippet
        ))

(apply 'package-install-if-missing mypackages)

;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; Show keystrokes in progress
(setq echo-keystrokes 0.1)

;; Move files to trash when deleting
(setq delete-by-moving-to-trash t)

;; No shift key to mark things
(setq shift-select-mode nil)

;; Transparently open compressed files
(auto-compression-mode t)

;; Enable syntax highlighting for older Emacsen that have it off
(global-font-lock-mode t)

;; Yes and No with first letter
(defalias 'yes-or-no-p 'y-or-n-p)

;; UTF-8 please
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; Save a list of recent files visited. (open recent file with C-x f)
(recentf-mode 1)
(setq recentf-max-saved-items 100) ;; just 20 is too recent

;; Undo/redo window configuration with C-c <left>/<right>
(winner-mode 1)

;; ;; Never insert tabs
;; (set-default 'indent-tabs-mode nil)
(setq-default whitespace-style
              '(face trailing empty space-before-tab))
(global-whitespace-mode 1)
(diminish 'global-whitespace-mode)

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Easily navigate sillycased words
(global-subword-mode 1)

;; Keep cursor away from edges when scrolling up/down
(require 'smooth-scrolling)

;; org-mode: Don't ruin S-arrow to switch windows please
;; (use M-+ and M-- instead to toggle)
(setq org-replace-disputed-keys t)

;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

;; Represent undo-history as an actual tree (visualize with C-x u)
(setq undo-tree-mode-lighter "")
(require 'undo-tree)
(global-undo-tree-mode)

;; Add parts of each file's directory to the buffer name if not unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Run at full power please
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'erase-buffer 'disabled nil)

;; text editing tools
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)

;; A saner ediff
(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Nic says eval-expression-print-level needs to be set to nil (turned off) so
;; that you can always see what's happening.
(setq eval-expression-print-level nil)

;; fix faces
(defface popup-mouse-face nil nil)

;; ido

(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-case-fold t
      ido-auto-merge-work-directories-length -1
      ido-create-new-buffer 'always
      ido-default-buffer-method 'selected-window
      ido-default-file-method 'selected-window
      ido-use-filename-at-point nil
      ido-max-prospects 10)

(add-hook
 'ido-setup-hook
 (lambda ()

     ;; Use C-w to go back up a dir to better match normal usage of C-w
     ;; - insert current file name with C-x C-w instead.
     (define-key ido-file-completion-map (kbd "C-w") 'ido-delete-backward-updir)
     (define-key ido-file-completion-map (kbd "C-x C-w") 'ido-copy-current-file-name)))

;; Always rescan buffer for imenu
(set-default 'imenu-auto-rescan t)

;; (add-to-list 'ido-ignore-directories "target")
;; (add-to-list 'ido-ignore-directories "node_modules")

;; Use ido everywhere
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

;; Fix ido-ubiquitous for newer packages
(defmacro ido-ubiquitous-use-new-completing-read (cmd package)
  `(eval-after-load ,package
     '(defadvice ,cmd (around ido-ubiquitous-new activate)
        (let ((ido-ubiquitous-enable-compatibility nil))
          ad-do-it))))

(ido-ubiquitous-use-new-completing-read webjump 'webjump)
(ido-ubiquitous-use-new-completing-read yas/expand 'yasnippet)
(ido-ubiquitous-use-new-completing-read yas/visit-snippet-file 'yasnippet)
