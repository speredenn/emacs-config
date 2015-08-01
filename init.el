;; Check which Emacs is running, and on which platform
;; Each operating system gets its own specific customizations
;; Then comes the general settings
(cond
 ((string-match "GNU" (emacs-version))
  (cond 
   ((string-match "linux" system-configuration)
    (if (file-exists-p "~/.emacs.d/emacs-gnulinux.el")
	(progn
	  (message "Loading GNU Emacs customizations for GNU/Linux")
	  (load-file "~/.emacs.d/emacs-gnulinux.el"))))
   ((string-match "pc" system-configuration)
    (if (file-exists-p "~/.emacs.d/emacs-microsoft.el")
	(progn 
	  (message "Loading GNU Emacs customizations for Microsoft Windows")
	  (load-file "~/.emacs.d/emacs-microsoft.el"))))
   )
  (if (file-exists-p "~/.emacs.d/emacs-main.el")
      (progn
	(message "Loading GNU Emacs customizations common to all OS")
	(load-file "~/.emacs.d/emacs-main.el")))
  ) ; matched GNU
 ((string-match "XEmacs" (emacs-version))
  (cond 
   ((string-match "linux" system-configuration)
    (if (file-exists-p "~/.emacs.d/xemacs-gnulinux.el")
	(progn
	  (message "Loading XEmacs customizations for Linux")
	  (load-file "~/.emacs.d/xemacs-gnulinux.el"))))
   ((string-match "win32" system-configuration) ; TODO: string to be changed
    (if (file-exists-p "~/.emacs.d/xemacs-microsoft.el")
	(progn
	  (message "Loading XEmacs customizations for Microsoft Windows")
	  (load-file "~/.emacs.d/xemacs-microsoft.el"))))
   )
  (if (file-exists-p "~/.emacs.d/xemacs-main.el")
      (progn
	(message "loading XEmacs customizations common to all OS")
	(load-file "~/.emacs.d/xemacs-main.el")))
  ) ; matched XEmacs
 )
(if (file-exists-p "~/.emacs.d/main.el")
    (progn
      (message "loading Emacs customizations common to all Emacs and all OS")
      (load-file "~/.emacs.d/main.el")))
