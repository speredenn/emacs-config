((auctex status "installed" recipe
         (:name auctex :website "http://www.gnu.org/software/auctex/" :description "AUCTeX is an extensible package for writing and formatting TeX files in GNU Emacs and XEmacs. It supports many different TeX macro packages, including AMS-TeX, LaTeX, Texinfo, ConTeXt, and docTeX (dtx files)." :type git :module "auctex" :url "git://git.savannah.gnu.org/auctex.git" :build
                `(("./autogen.sh")
                  ("./configure" "--without-texmf-dir" "--with-lispdir=`pwd`" ,(concat "--with-emacs=" el-get-emacs))
                  "make")
                :load-path
                ("." "preview")
                :load
                ("tex-site.el" "preview/preview-latex.el")
                :info "doc"))
 (auto-complete status "installed" recipe
                (:name auto-complete :website "https://github.com/auto-complete/auto-complete" :description "The most intelligent auto-completion extension." :type github :pkgname "auto-complete/auto-complete" :depends
                       (popup fuzzy)))
 (auto-complete+ status "installed" recipe
                 (:name auto-complete+ :auto-generated t :type emacswiki :description "Auto complete plus" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/auto-complete+.el"))
 (auto-complete-css status "installed" recipe
                    (:name auto-complete-css :description "Auto-complete sources for CSS" :type http :url "http://www.cx4a.org/pub/auto-complete-css.el" :depends auto-complete))
 (auto-complete-emacs-lisp status "installed" recipe
                           (:name auto-complete-emacs-lisp :description "Auto-complete sources for emacs lisp" :type http :url "http://www.cx4a.org/pub/auto-complete-emacs-lisp.el" :depends auto-complete))
 (auto-complete-latex status "installed" recipe
                      (:name auto-complete-latex :description "A LaTeX extention for auto-complete-mode" :website "https://bitbucket.org/tequilasunset/auto-complete-latex" :url "https://bitbucket.org/tequilasunset/auto-complete-latex" :type hg :depends auto-complete))
 (auto-complete-rst status "installed" recipe
                    (:name auto-complete-rst :description "Auto-complete extension for ReST and Sphinx" :type github :pkgname "tkf/auto-complete-rst" :depends auto-complete))
 (auto-complete-ruby status "installed" recipe
                     (:name auto-complete-ruby :description "Auto-complete sources for Ruby" :type http :url "http://www.cx4a.org/pub/auto-complete-ruby.el" :depends
                            (auto-complete)))
 (auto-complete-yasnippet status "installed" recipe
                          (:name auto-complete-yasnippet :description "Auto-complete sources for YASnippet" :type http :url "http://www.cx4a.org/pub/auto-complete-yasnippet.el" :depends
                                 (auto-complete yasnippet)))
 (autopair status "installed" recipe
           (:name autopair :website "https://github.com/capitaomorte/autopair" :description "Autopair is an extension to the Emacs text editor that automatically pairs braces and quotes." :type github :pkgname "capitaomorte/autopair" :features autopair))
 (cedet status "installed" recipe
        (:name cedet :website "http://cedet.sourceforge.net/" :description "CEDET is a Collection of Emacs Development Environment Tools written with the end goal of creating an advanced development environment in Emacs." :type bzr :url "bzr://cedet.bzr.sourceforge.net/bzrroot/cedet/code/trunk" :build
               `(("sh" "-c" "touch `find . -name Makefile`")
                 ("make" ,(format "EMACS=%s"
                                  (shell-quote-argument el-get-emacs))
                  "clean-all")
                 ("make" ,(format "EMACS=%s"
                                  (shell-quote-argument el-get-emacs)))
                 ("make" ,(format "EMACS=%s"
                                  (shell-quote-argument el-get-emacs))
                  "-C" "contrib"))
               :build/berkeley-unix
               `(("sh" "-c" "touch `find . -name Makefile`")
                 ("gmake" ,(format "EMACS=%s"
                                   (shell-quote-argument el-get-emacs))
                  "clean-all")
                 ("gmake" ,(format "EMACS=%s"
                                   (shell-quote-argument el-get-emacs)))
                 ("gmake" ,(format "EMACS=%s"
                                   (shell-quote-argument el-get-emacs))
                  "-C" "contrib"))
               :build/windows-nt
               ("echo #!/bin/sh > tmp.sh & echo touch `/usr/bin/find . -name Makefile` >> tmp.sh & echo make FIND=/usr/bin/find >> tmp.sh" "sed 's/^M$//' tmp.sh  > tmp2.sh" "sh ./tmp2.sh" "rm ./tmp.sh ./tmp2.sh")
               :features nil :lazy nil :post-init
               (unless
                   (featurep 'cedet-devel-load)
                 (load
                  (expand-file-name "cedet-devel-load.el" pdir)))))
 (color-theme status "installed" recipe
              (:name color-theme :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme" :website "http://www.nongnu.org/color-theme/" :type http-tar :options
                     ("xzf")
                     :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz" :load "color-theme.el" :features "color-theme" :post-init
                     (progn
                       (color-theme-initialize)
                       (setq color-theme-is-global t))))
 (color-theme-solarized status "installed" recipe
                        (:name color-theme-solarized :description "Emacs highlighting using Ethan Schoonover's Solarized color scheme" :type github :pkgname "sellout/emacs-color-theme-solarized" :depends color-theme :prepare
                               (progn
                                 (add-to-list 'custom-theme-load-path default-directory)
                                 (autoload 'color-theme-solarized-light "color-theme-solarized" "color-theme: solarized-light" t)
                                 (autoload 'color-theme-solarized-dark "color-theme-solarized" "color-theme: solarized-dark" t))))
 (color-theme-tango status "installed" recipe
                    (:name color-theme-tango :description "Color theme based on Tango Palette. Created by danranx@gmail.com" :type emacswiki :depends color-theme :prepare
                           (autoload 'color-theme-tango "color-theme-tango" "color-theme: tango" t)))
 (css-mode status "installed" recipe
           (:name css-mode :description "Minor mode for CSS" :features css-mode :type elpa))
 (cython-mode status "installed" recipe
              (:name cython-mode :description "Major mode for the Cython language" :type http :url "https://raw.github.com/cython/cython/master/Tools/cython-mode.el" :features cython-mode :localname "cython-mode.el"))
 (diff+ status "installed" recipe
        (:name diff+ :auto-generated t :type emacswiki :description "Extensions to `diff.el' for Emacs 21 and later." :website "https://raw.github.com/emacsmirror/emacswiki.org/master/diff+.el"))
 (diff-git status "installed" recipe
           (:name diff-git :website "https://github.com/alanfalloon/diff-git.el" :description "A small emacs extension for working with the git index from within diff-mode" :type github :pkgname "alanfalloon/diff-git.el"))
 (dired+ status "installed" recipe
         (:name dired+ :description "Extensions to Dired" :type emacswiki :features dired+))
 (el-get status "installed" recipe
         (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :info "." :load "el-get.el"))
 (fuzzy status "installed" recipe
        (:name fuzzy :website "https://github.com/auto-complete/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "auto-complete/fuzzy-el"))
 (gh status "installed" recipe
     (:name gh :type github :pkgname "sigma/gh.el" :depends
            (pcache logito)
            :description "Github API client libraries" :website "http://github.com/sigma/gh.el"))
 (gist status "installed" recipe
       (:name gist :type github :pkgname "defunkt/gist.el" :depends
              (gh tabulated-list)
              :description "Emacs integration for gist.github.com" :website "http://github.com/defunkt/gist.el"))
 (git-commit-mode status "installed" recipe
                  (:name git-commit-mode :description "Major mode for editing git commit messages" :type github :pkgname "rafl/git-commit-mode" :features git-commit))
 (ipython status "installed" recipe
          (:name ipython :description "Adds support for IPython to python-mode.el" :type http :url "https://raw.github.com/ipython/ipython/master/docs/emacs/ipython.el" :depends python-mode :features ipython :post-init
                 (setq py-shell-name "ipython")))
 (logito status "installed" recipe
         (:name logito :type github :pkgname "sigma/logito" :description "logging library for Emacs" :website "http://github.com/sigma/logito"))
 (lua-mode status "installed" recipe
           (:name lua-mode :description "A major-mode for editing Lua scripts" :website "https://github.com/immerrr/lua-mode" :type git :url "https://github.com/immerrr/lua-mode"))
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
 (package status "installed" recipe
          (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
                 (progn
                   (setq package-user-dir
                         (expand-file-name
                          (convert-standard-filename
                           (concat
                            (file-name-as-directory default-directory)
                            "elpa")))
                         package-directory-list
                         (list
                          (file-name-as-directory package-user-dir)
                          "/usr/share/emacs/site-lisp/elpa/"))
                   (make-directory package-user-dir t)
                   (unless
                       (boundp 'package-subdirectory-regexp)
                     (defconst package-subdirectory-regexp "^\\([^.].*\\)-\\([0-9]+\\(?:[.][0-9]+\\)*\\)$" "Regular expression matching the name of\n a package subdirectory. The first subexpression is the package\n name. The second subexpression is the version string."))
                   (setq package-archives
                         '(("ELPA" . "http://tromey.com/elpa/")
                           ("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (pcache status "installed" recipe
         (:name pcache :type github :pkgname "sigma/pcache" :description "persistent caching for Emacs" :website "http://github.com/sigma/pcache"))
 (popup status "installed" recipe
        (:name popup :website "https://github.com/auto-complete/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :pkgname "auto-complete/popup-el"))
 (pymacs status "installed" recipe
         (:name pymacs :description "Interface between Emacs Lisp and Python" :type github :pkgname "pinard/Pymacs" :prepare
                (progn
                  (el-get-envpath-prepend "PYTHONPATH" default-directory)
                  (autoload 'pymacs-load "pymacs" nil t)
                  (autoload 'pymacs-eval "pymacs" nil t)
                  (autoload 'pymacs-exec "pymacs" nil t)
                  (autoload 'pymacs-call "pymacs")
                  (autoload 'pymacs-apply "pymacs"))
                :build
                ("make")))
 (python-mode status "installed" recipe
              (:type github :pkgname "emacsmirror/python-mode" :name python-mode :type emacsmirror :description "Major mode for editing Python programs" :features
                     (python-mode doctest-mode)
                     :compile nil :load "test/doctest-mode.el" :prepare
                     (progn
                       (autoload 'python-mode "python-mode" "Python editing mode." t)
                       (add-to-list 'auto-mode-alist
                                    '("\\.py$" . python-mode))
                       (add-to-list 'interpreter-mode-alist
                                    '("python" . python-mode)))))
 (rainbow-delimiters status "installed" recipe
                     (:name rainbow-delimiters :website "https://github.com/jlr/rainbow-delimiters#readme" :description "Color nested parentheses, brackets, and braces according to their depth." :type github :pkgname "jlr/rainbow-delimiters"))
 (rope status "installed" recipe
       (:name rope :description "A python refactoring library" :post-init
              (el-get-envpath-prepend "PYTHONPATH" default-directory)
              :type hg :url "http://bitbucket.org/agr/rope"))
 (ropemacs status "installed" recipe
           (:name ropemacs :description "An Emacs minor mode for using rope python refactoring library in emacs." :post-init
                  (progn
                    (unless
                        (boundp 'pymacs-load-path)
                      (setq pymacs-load-path nil))
                    (add-to-list 'pymacs-load-path default-directory))
                  :depends
                  (rope ropemode)
                  :type hg :url "http://bitbucket.org/agr/ropemacs"))
 (ropemode status "installed" recipe
           (:name ropemode :description "Common parts of ropemacs and ropevim." :post-init
                  (progn
                    (unless
                        (boundp 'pymacs-load-path)
                      (setq pymacs-load-path nil))
                    (add-to-list 'pymacs-load-path default-directory))
                  :type hg :url "http://bitbucket.org/agr/ropemode"))
 (rst-mode status "installed" recipe
           (:name rst-mode :description "Mode for viewing and editing reStructuredText-documents." :type http :url "http://docutils.sourceforge.net/tools/editors/emacs/rst.el" :features rst))
 (smart-operator status "installed" recipe
                 (:name smart-operator :description "Insert operators with surrounding spaces smartly." :type github :pkgname "xwl/smart-operator"))
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
                                    '("\\.ml[iylp]?" . tuareg-mode)))))
 (yaml-mode status "installed" recipe
            (:name yaml-mode :description "Simple major mode to edit YAML file for emacs" :type github :pkgname "yoshiki/yaml-mode"))
 (yasnippet status "installed" recipe
            (:name yasnippet :website "https://github.com/capitaomorte/yasnippet.git" :description "YASnippet is a template system for Emacs." :type github :pkgname "capitaomorte/yasnippet" :features "yasnippet" :pre-init
                   (unless
                       (or
                        (boundp 'yas/snippet-dirs)
                        (get 'yas/snippet-dirs 'customized-value))
                     (setq yas/snippet-dirs
                           (list
                            (concat el-get-dir
                                    (file-name-as-directory "yasnippet")
                                    "snippets"))))
                   :post-init
                   (put 'yas/snippet-dirs 'standard-value
                        (list
                         (list 'quote
                               (list
                                (concat el-get-dir
                                        (file-name-as-directory "yasnippet")
                                        "snippets")))))
                   :compile nil :submodule nil)))
