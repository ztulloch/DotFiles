;;;; Zander's .emacs file

; common lisp package
(require 'cl)
; machine specific path and environment variables
; Emacs root is a synchronised folder where site-lisp and backup files are stored
(defvar emacs-root "f:/Sync/Work/Emacs/")
; I'm using the excellent Orgzly on Android and the relevant files are shared through dropbox
(defvar org-root "f:/Zander/Dropbox/Documents/Orgzly/")
; cygwin home for cygwin utilities
(defvar cygwin-home "f:/cygwin64/bin")
; dropbox home
(defvar dropbox-home "f:/Zander/Dropbox")

;; add all the elisp directories under ~/emacs to my load path
(labels ((add-path (p)
	 (add-to-list 'load-path
		      (concat emacs-root p))))
	(add-path "lisp")
	(add-path "site-lisp")
	)

; load universal-init - this is stored in emacs-root and contains the meat of the init stuff
(load-library "universal-init.el")

; set a browser specific for emacs
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "c:/Program files/Firefox/firefox.exe");


