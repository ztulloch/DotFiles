;; example of setting env var named "path", by appending a new path to existing path
;; add cygwin directory for unix utils
;(setenv "PATH"
;  (concat
;   "E:/cygwin64/bin" ";"
;   (getenv "PATH")
;  )
;)
;; set emacs directory
(setq user-emacs-directory emacs-root)

;(setq exec-path (append exec-path cygwin-home))
(add-to-list 'exec-path cygwin-home)
;; Zanders new Windows .emacs file
; find-file "c:/Windows/System32/drivers/etc/hosts"

(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
        (message "No non-ascii characters."))))


(defun find-next-unsafe-char (&optional coding-system)
  "Find the next character in the buffer that cannot be encoded by
coding-system. If coding-system is unspecified, default to the coding
system that would be used to save this buffer. With prefix argument,
prompt the user for a coding system."
  (interactive "Zcoding-system: ")
  (if (stringp coding-system) (setq coding-system (intern coding-system)))
  (if coding-system nil
    (setq coding-system
          (or save-buffer-coding-system buffer-file-coding-system)))
  (let ((found nil) (char nil) (csets nil) (safe nil))
    (setq safe (coding-system-get coding-system 'safe-chars))
    ;; some systems merely specify the charsets as ones they can encode:
    (setq csets (coding-system-get coding-system 'safe-charsets))
    (save-excursion
      ;;(message "zoom to <")
      (let ((end  (point-max))
            (here (point    ))
            (char  nil))
        (while (and (< here end) (not found))
          (setq char (char-after here))
          (if (or (eq safe t)
                  (< char ?\177)
                  (and safe  (aref safe char))
                  (and csets (memq (char-charset char) csets)))
              nil ;; safe char, noop
            (setq found (cons here char)))
          (setq here (1+ here))) ))
    (and found (goto-char (1+ (car found))))
    found))

(defun occur-non-ascii ()
  "Find any non-ascii characters in the current buffer."
  (interactive)
  (occur "[^[:ascii:]]"))


;; setup recent mode
(require 'recentf)
(setq recentf-save-file (concat emacs-root system-name "-recentf"))

(recentf-mode 1)
(setq recentf-max-menu-items 20)
(setq recentf-max-saved-items 150)
(setq ido-save-directory-list-file (concat emacs-root system-name "-ido.last"))
;(global-set-key "\C-x\ \C-r" 'recentf-open-files)
 (defun ido-recentf-open ()
   "Use `ido-completing-read' to find a recent file."
   (interactive)
   (if (find-file (ido-completing-read "Find recent file: " recentf-list))
       (message "Opening file...")
     (message "Aborting")))
 (global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;;(setq ido-use-virtual-buffers t)

;;; ------------------------------------------------------------------
;;; Global key bindings
;;; ------------------------------------------------------------------
; bind home and end key to start/end of buffer
;(global-set-key [home] 'beginning-of-buffer)
;(global-set-key [end]  'end-of-buffer)
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)
;  f5 to repeat complex command  f8 to goto-line
(global-set-key [f5] 'repeat-complex-command)

; define function heading comment and bind to f6
(fset 'insert-function-comment
   [tab ?/ ?* ?* return ?* return ?* return ?* return ?* ?* ?/ up up up ? ])
;(global-set-key [f6] 'insert-function-comment)
; define print statement macro and bind to f7
; this could be expanded to work on a per language basis?
(fset 'insert-print-statement 
   [?\C-e return tab ?S ?y ?s ?t ?e ?m ?. ?o ?u ?t ?. ?p ?r ?i ?n ?t ?l ?n ?  ?\( ?\" ?\" ?\) ?\; left left left])
;(global-set-key [f7] 'insert-print-statement)
(global-set-key [f6] (lambda () (interactive) (org-todo -1)))
(global-set-key [f7] (lambda () (interactive) (org-todo "-1")))
(global-set-key [f8] 'goto-line)
(global-set-key [f9] 'org-toggle-link-display)
(global-set-key [f12] 'org-html-export-to-html)
;; undefined f6 f7 f12
;; f1 is help
;; f2 is
;; f3 start kbd macro
;; f4 end kbd macvro
;; f5 repeat complex
;; f6 
;; f7 
;; f8 goto line
;; f9 
;; f10 is menu
;; f11 is toggle frame full screen
;; f12
;; jump around brackets
(global-set-key [M-down] 'forward-list)
(global-set-key [M-up] 'backward-list)
; bury buffer
(global-set-key "\C-h\C-b" 'bury-buffer)

(fset 'insert-spacer
   [return ?- ?- ?- return])

;(global-set-key [f12] 'insert-spacer)

(setq visible-bell 1)

(global-font-lock-mode 1)

;;; ------------------------------------------------------------------
;;; backup directory setting
;;; ------------------------------------------------------------------
;(require 'backup-dir)

;(setq bkup-backup-directory-info '((t "E:/Zander/emacs/backup" full-path)))
(defvar user-backup-file-directory (concat emacs-root "backup"))
(setq backup-directory-alist
      `((".*" . ,user-backup-file-directory)))
(defvar user-temporary-file-directory (concat emacs-root "temp"))
(setq auto-save-file-name-transforms 
      `((".*",user-temporary-file-directory t)))

(setq create-lockfiles nil)

;(setq browse-url-browser-function 'browse-url-generic
;      browse-url-generic-program "C:/Program Files (x86)/Mozilla Firefox/firefox.exe");
; "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
;      browse-url-generic-program "C:/Program Files (x86)/Opera/opera.exe");

;; (defun java-mode-hook ()
;;   (setq c-basic-offset 4)
;;   (c-set-offset 'substatement-open 0) ; this is the one you care about
;;   (c-set-offset 'statement-case-open 0)
;;   (c-set-offset 'case-label '+)
;;   (setq tab-width 4 indent-tabs-mode nil) ;; make sure spaces are used instead of tabs
;; (message "java mode setup"))
;; (add-hook 'java-mode 'java-mode-hook)



(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 4
				  tab-width 4
				  indent-tabs-mode t)))

(c-set-offset 'substatement-open 0)

;(find-file (concat emacs-root "startup.org"))
;; 
;; load startup file emacs-root/HOSTNAME.org
;; 
(find-file (concat emacs-root system-name ".org"))
;(find-file  "startup.org") ; looks in emacs bin directory
; taskbar at bottom
;(setq initial-frame-alist '((top . 0) (left . 0)
;			    (width . 208) (height . 58)))
; when taskbar was at top
;(setq initial-frame-alist '((top . 40) (left . 0)
;			    (width . 208) (height . 58)))

;(setq initial-frame-alist '((top . 0) (left . 80)
;			    (width . 200) (height . 60) (cursor-type . box) (cursor-color . "white")))
;;
;; package manager/ment
;;
;(require 'package) ;; You might already have this line
;(add-to-list 'package-archives
;             '("melpa-stable" . "http://stable.melpa.org/packages/"))
;(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
;  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;(package-initialize) 

;; turn on ido mode
(require 'ido)
(ido-mode t)


;;
;; Custom variable setup.
;;

;;; Append to completion-ignored-extensions variable
;;; Don't want ido reading org archive files.
(setq completion-ignored-extensions
      (append completion-ignored-extensions
              (quote
               (".org_archive" ".o"))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
;;; ------------------------------------------------------------------
;;; Org mode Setup
;;; ------------------------------------------------------------------
;; Setup for org
;;;
;;; Org Mode
;;;
;(add-to-list 'load-path (expand-file-name "~/git/org-mode/lisp"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org)
;(setq org-startup-indented t)
;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;(setq org-directory (concat org-root "gtd/"))
(setq org-directory org-root)
(setq org-default-notes-file (concat org-directory "Do.org"))

(setq org-agenda-files (list org-directory))
;(setq org-agenda-files (list concat org-root "gtd/"))
;; (setq org-directory "E:/Zander/Org/gtd/")
;; (setq org-default-notes-file "E:/Zander/Org/gtd/refile.org")


(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'file))

;; C-c c to start capture C-c C-c to end it
(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
       '(("t" "Next Todo" entry (file+headline (concat org-root "Do.org") "Next")
              "* TODO %?\n  %i\n  ") ; %a stores file called from
;	 ("s" "Tasks" entry (file+headline (concat org-root "gtd/newgtd.org") "Tasks")
;	  "* TODO %?\n  %i\n  ")
	; %a stores file called from	 ("z" "Toplevel Todo" entry (file concat org-root "gtd/todo.org") "* TODO %?\n %i\n")
	 ("p" "Project" entry (file+headline (concat org-root "gtd/projects.org") "Projects")
              "* %?\n  %i\n ")
;	 ("i" "Inbox" entry (file+headline (concat org-root "gtd/projects.org") "Projects")
;              "* %?\n  %i\n ")
	 ("u" "Unfiled item" entry (file+headline (concat org-root "gtd/inbox.org") "Inbox"))
	 ("n" "Note" entry (file+headline (concat org-root "gtd/notes.org") "Notes"))
	 ("b" "Bug" entry (file+headline (concat org-root "gtd/notes.org") "Bugs"))
	 ("f" "Feature" entry (file+headline (concat org-root "gtd/notes.org") "Features"))
	 ("c" "Calendar" entry (file+headline (concat org-root "gtd/calendar.org") "Calendar")
	  "* %?\n  %i\n ")
;	 ("i" "Item test" item (file concat org-root "gtd/refile.org"))
;	 ("c" "Item test" checkitem (file concat org-root "gtd/refile.org"))
;	 ("p" "Item test" plain (file concat org-root "gtd/refile.org"))
         ("w" "Tweet" entry (file+headline (concat org-root "gtd/journal.org") "Tweets")
 	 "* %?\n %i\n ")
         ("j" "Journal" entry (file+datetree (concat org-root "gtd/journal.org"))
 	 "* %?\nEntered on %U\n  %i\n  %a")))

(setq org-mobile-directory (concat dropbox-home "/MobileOrg") )
(setq org-mobile-inbox-for-pull (concat org-root "/gtd/inbox.org"))
(setq org-mobile-checksum-binary (concat cygwin-home "/sha1sum.exe"))

(setq org-mode-websrc-directory (concat org-root "/publish"))
(setq org-mode-publishing-directory (concat org-root "/html/"))
(setq org-html-validation-link nil)
(setq org-publish-project-alist
      `(("org-notes"
         :base-directory       ,org-mode-websrc-directory
	 :base-extension       "org"
	 :publishing-directory ,org-mode-publishing-directory
	 :recursive            t
	 :publishing-function  org-html-publish-to-html
	 :headline-levels      4             ; Just the default for this project.
	 :auto-preamble        t
	 :auto-sitemap         t             ; Generate sitemap.org automagically...
	 :makeindex            t
	 :section-numbers      nil
	 :table-of-contents    nil
	 :with-author          nil
	 :with-creator         nil
	 :with-tags            nil
	 )
	)
      )

(setq org-todo-keywords
       (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)"))))


(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;(setq org-default-notes-file (concat org-directory "/refile.org"))
;(setq org-default-notes-file (concat org-directory "E:/Zander/Org/gtd/refile.org"))

;; (setq org-todo-keywords
;;       (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
;;               (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

;; (setq org-todo-keyword-faces
;;       (quote (("TODO" :foreground "red" :weight bold)
;;               ("NEXT" :foreground "blue" :weight bold)
;;               ("DONE" :foreground "forest green" :weight bold)
;;               ("WAITING" :foreground "orange" :weight bold)
;;               ("HOLD" :foreground "magenta" :weight bold)
;;               ("CANCELLED" :foreground "forest green" :weight bold)
;;               ("MEETING" :foreground "forest green" :weight bold)
;;               ("PHONE" :foreground "forest green" :weight bold))))

;; (setq org-use-fast-todo-selection t)
;; (setq org-treat-S-cursor-todo-selection-as-state-change nil)

;; (setq org-todo-state-tags-triggers
;;       (quote (("CANCELLED" ("CANCELLED" . t))
;;               ("WAITING" ("WAITING" . t))
;;               ("HOLD" ("WAITING") ("HOLD" . t))
;;               (done ("WAITING") ("HOLD"))
;;               ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
;;               ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
;;               ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;; ; Targets include this file and any file contributing to the agenda - up to 9 levels deep
;; (setq org-refile-targets (quote ((nil :maxlevel . 9)
;;                                  (org-agenda-files :maxlevel . 9))))

;; ; Use full outline paths for refile targets - we file directly with IDO
;; (setq org-refile-use-outline-path t)

;; ; Targets complete directly with IDO
;; (setq org-outline-path-complete-in-steps nil)

;; ; Allow refile to create parent tasks with confirmation
;; (setq org-refile-allow-creating-parent-nodes (quote confirm))

(require 'imenu-anywhere)
(global-set-key (kbd "C-.") #'imenu-anywhere)
;; ; Use IDO for both buffer and file completion and ido-everywhere to t
;; (setq org-completion-use-ido t)
;; (setq ido-everywhere t)
;; (setq ido-max-directory-size 100000)
;; (ido-mode (quote both))
;; ; Use the current window when visiting files and buffers with ido
;; (setq ido-default-file-method 'selected-window)
;; (setq ido-default-buffer-method 'selected-window)
;; ; Use the current window for indirect buffer display
;; (setq org-indirect-buffer-display 'current-window)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

; '(org-agenda-files (quote ("e:/Zander/Sync/Org/mobile/index.org" "e:/Zander/Sync/Org/mobile/todo.org" "e:/Zander/Sync/Org/mobile/notes.org")))
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
; '(default ((t (:family "Inconsolata" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
; '(default ((t (:family "Source Code Pro" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
;; easy keys for split windows
(global-set-key (kbd "M-3") 'delete-other-windows) ; 【Alt+3】 unsplit all
(global-set-key (kbd "M-4") 'split-window-below)
(global-set-key (kbd "M-5") 'split-window-right)
(global-set-key (kbd "M-RET") 'other-window) ; 【Alt+Return】 move cursor to next pane
(global-set-key (kbd "M-0") 'delete-window)  ; remove current pane
