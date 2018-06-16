;; set emacs directory to emacs-root
(setq user-emacs-directory emacs-root)

; look in cygwin for unix style utilites eg gpg etc
(when (boundp 'cygwin-home)
	 (add-to-list 'exec-path cygwin-home))
;;; ------------------------------------------------------------------
;;; Setup recent mode
;;; ------------------------------------------------------------------
; require recent package
(require 'recentf)
; turn on recent mode
(recentf-mode 1)
; files are stored on a shared drive so they need to be machine specific
(setq recentf-save-file (concat emacs-root system-name "-recentf"))
; remember 20 last visited files
(setq recentf-max-menu-items 20)
; but remember 150 files - can dip in and out of a load of files in a program's source
(setq recentf-max-saved-items 150)
; again need a machine specific name
(setq ido-save-directory-list-file (concat emacs-root system-name "-ido.last"))

; tie recent mode into ido mode
(defun ido-recentf-open ()
  "Use `ido-completing-read' to find a recent file."
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;;; ------------------------------------------------------------------
;;; Global key bindings
;;; ------------------------------------------------------------------
; home and end jump around buffer
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)
;  f5 to repeat complex command  f8 to goto-line
(global-set-key [f5] 'repeat-complex-command)
(global-set-key [f8] 'goto-line)
;; jump around bracket sets with ALt-Up/Down
(global-set-key [M-down] 'forward-list)
(global-set-key [M-up] 'backward-list)
; bury buffer
(global-set-key "\C-h\C-b" 'bury-buffer)

; turn on visible bell
(setq visible-bell 1)

; turn on font lock everywhere
(global-font-lock-mode 1)

;;; ------------------------------------------------------------------
;;; backup directory setting
;;; ------------------------------------------------------------------
; use emacs-root for backup files
(defvar user-backup-file-directory (concat emacs-root "backup"))
(setq backup-directory-alist
      `((".*" . ,user-backup-file-directory)))
(defvar user-temporary-file-directory (concat emacs-root "temp"))
(setq auto-save-file-name-transforms 
      `((".*",user-temporary-file-directory t)))

(setq create-lockfiles nil)

; setup formatting for Java
(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 4
				  tab-width 4
				  indent-tabs-mode t)))

(c-set-offset 'substatement-open 0)

; emacs-root contains a file hostname.org which contains machine specific
; quick links to quickly jump to files in projects
(find-file (concat emacs-root system-name ".org"))
;(find-file (concat (getenv "EMACSROOT") "/test.org"))

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
 ;; custom-set-variables.
 ;; turn off startup screen
 ;; turn off scrollbar and toolbar
 ;; turn on buffer size indicator
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
;;; ------------------------------------------------------------------
;;; Org mode Setup
;;; ------------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org)
;(setq org-startup-indented t)
;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-directory org-root)
(setq org-default-notes-file (concat org-directory "Do.org"))

(setq org-agenda-files (list org-directory))

(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'file))


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

;;;; ido-mode setup
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

; imenu anywhere
(require 'imenu-anywhere)
(global-set-key (kbd "C-.") #'imenu-anywhere)

(cond
 ((find-font (font-spec :name "Consolas-13"))
  (set-frame-font "Consolas-13"))
 ((find-font (font-spec :name "Inconsolata-13"))
  (set-frame-font "Inconsolata-13"))
 ((find-font (font-spec :name "courier-13"))
  (set-frame-font "courier-13")))
; Consolas font is a really good looking monospaced font, ideal for programming
; I think I first got it as part of VisualStudio.
;(custom-set-faces
; '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
; if you'd prefer an open source alternative, Inconsolata is a nice looking font
; it can be downloaded here http://www.levien.com/type/myfonts/inconsolata.html
;'(default ((t (:family "Inconsolata" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
