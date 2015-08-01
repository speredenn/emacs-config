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
        yasnippet
        ))

(apply 'package-install-if-missing mypackages)
