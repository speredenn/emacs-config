;; Check which Emacs is running, and on which platform
;; Each operating system gets its own specific customizations
;; Then comes the general settings
(cond
 ((string-match "GNU" (emacs-version))
  (message "Customizing GNU Emacs")
  (cond 
   ((string-match "linux" system-configuration)
    (message "Customizing GNU Emacs for GNU/Linux")
    ;; Those settings apply only to GNU/Linux
    ;; [GNU/Linux section > beginning]
    
    ;; [GNU/Linux section > end]
    )
   ((string-match "pc" system-configuration)
    (message "customizing GNU Emacs for Windows")
    ;; Those settings apply only to Microsoft Windows
    ;; [Windows section > beginning]
    
    ;; Use 10-pt Consolas as default font
    (set-face-attribute 'default nil
			:family "Consolas" :height 100)
    
    ;; [Windows section > end]
    )
   )
  ;; Settings appling to GNU/Emacs on all the OS
  ;; [Emacs global settings > beginning]
  
  (server-start)
  
  ;; [Emacs global settings > end]
  )
 ((string-match "XEmacs" (emacs-version))
  (message "customizing XEmacs")
  ;; Those settings apply only to XEmacs
  ;; [XEmacs section > beginning]
  
  ;; [XEmacs section > end]
  )
 )
