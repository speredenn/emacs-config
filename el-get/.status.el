((auctex status "installed" recipe
	 (:name auctex :website "http://www.gnu.org/software/auctex/" :description "AUCTeX is an extensible package for writing and formatting TeX files in GNU Emacs and XEmacs. It supports many different TeX macro packages, including AMS-TeX, LaTeX, Texinfo, ConTeXt, and docTeX (dtx files)." :type cvs :module "auctex" :url ":pserver:anonymous@cvs.sv.gnu.org:/sources/auctex" :build
		`(("./autogen.sh")
		  ("./configure" "--without-texmf-dir" "--with-lispdir=`pwd`" ,(concat "--with-emacs=" el-get-emacs))
		  "make")
		:load-path
		("." "preview")
		:load
		("tex-site.el" "preview/preview-latex.el")
		:info "doc"))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :info "." :load "el-get.el"))
 (gh status "installed" recipe
     (:name gh :type github :pkgname "sigma/gh.el" :depends
	    (pcache logito)
	    :description "Github API client libraries" :website "http://github.com/sigma/gh.el"))
 (gist status "installed" recipe
       (:name gist :type github :pkgname "defunkt/gist.el" :depends
	      (gh tabulated-list)
	      :description "Emacs integration for gist.github.com" :website "http://github.com/defunkt/gist.el"))
 (logito status "installed" recipe
	 (:name logito :type github :pkgname "sigma/logito" :description "logging library for Emacs" :website "http://github.com/sigma/logito"))
 (markdown-mode status "installed" recipe
		(:name markdown-mode :description "Major mode to edit Markdown files in Emacs" :type git :url "git://jblevins.org/git/markdown-mode.git" :before
		       (add-to-list 'auto-mode-alist
				    '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))))
 (mu4e status "installed" recipe
       (:name mu4e :website "http://www.djcbsoftware.nl/code/mu/mu4e.html" :description "An emacs-based e-mail client which uses mu (http://www.djcbsoftware.nl/code/mu/) as its back-end: mu4e." :type github :pkgname "djcb/mu" :post-init
	      (setq mu4e-mu-binary
		    (expand-file-name "mu"
				      (expand-file-name "mu"
							(el-get-package-directory 'mu4e))))
	      :build
	      `(("autoreconf -i")
		("./configure")
		("make"))
	      :load-path "mu4e"))
 (pcache status "installed" recipe
	 (:name pcache :type github :pkgname "sigma/pcache" :description "persistent caching for Emacs" :website "http://github.com/sigma/pcache"))
 (slime status "installed" recipe
	(:name slime :description "Superior Lisp Interaction Mode for Emacs" :type github :autoloads "slime-autoloads" :info "doc" :pkgname "nablaone/slime" :load-path
	       ("." "contrib")
	       :compile
	       (".")
	       :build
	       '(("make" "-C" "doc" "slime.info"))
	       :post-init
	       (slime-setup)))
 (smex status "installed" recipe
       (:name smex :description "M-x interface with Ido-style fuzzy matching." :type github :pkgname "nonsequitur/smex" :features smex :post-init
	      (smex-initialize)))
 (tabulated-list status "installed" recipe
		 (:name tabulated-list :type github :pkgname "sigma/tabulated-list.el" :description "generic major mode for tabulated lists." :website "http://github.com/sigma/tabulated-list.el"))
 (tuareg-mode status "installed" recipe
	      (:name tuareg-mode :type svn :url "svn://svn.forge.ocamlcore.org/svn/tuareg/trunk" :description "A  GOOD Emacs mode to edit Objective Caml code." :load-path
		     (".")
		     :prepare
		     (progn
		       (autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
		       (autoload 'camldebug "camldebug" "Run the Caml debugger" t)
		       (dolist
			   (ext
			    '(".cmo" ".cmx" ".cma" ".cmxa" ".cmi"))
			 (add-to-list 'completion-ignored-extensions ext))
		       (add-to-list 'auto-mode-alist
				    '("\\.ml[iylp]?" . tuareg-mode))))))
