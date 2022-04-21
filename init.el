;;Emacs configuration.
;;; -*- lexical-binding: t; -*-
;;; Basic Config
(setq user-full-name "Donal Glavin"
      user-mail-address "donal.l.glavin@gmail.com") ; This is a default address (may update when actually needed.

;;;; Determine the computing environment. (system)
(defvar my/computer nil "Which computer Emacs is currently running on")
(defvar sys/work-windows nil "If true Emacs is running on a work machine on Windows")
(defvar sys/personal-windows nil "If true Emacs is running on my personal machine but in a Windows environment")
(defvar sys/personal-wsl nil "If true Emacs is running on my personal machine but in a linux (wsl) environment")

;; Set sys/ variables.
(let ((sys (system-name)))
  (if (and (string= sys "LAPTOP-6EMJTN6I") (string= system-type "gnu/linux")) ;; Confirm if compter is personal computer and system is linux. (laptop-wsl)
	  (setq my/computer "laptop-wsl"
          sys/personal-wsl t))
  (if (and (string= sys "LAPTOP-6EMJTN6I") (string= system-type "windows-nt")) ;; Confirm if compter is personal computer and system is windows. (laptop-win)
	  (setq my/computer "laptop-win"
          sys/personal-windows t))
  (if (and (string= user-login-name "dglavin") (string= system-type "windows-nt")) ;; Confirm if compter is a work computer (via user login) and system is windows. (ehm-win)
	  (setq my/computer "ehm-win"
          sys/work-windows t)))

;; Determine frame is in Terminal or GUI.


;; Configure font for windows personal.
(if sys/personal-windows
	(set-face-attribute 'default nil :font "Iosevka Term" :height 85))

;;;; Configuring straight package management.
(setq straight-use-package-by-default nil) ; Configuring preset variables.
(defvar bootstrap-version) ; Acquiring and Evaluating
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Use depth of 1 when cloning files with git to save on bandwidth and disk space.
(setq straight-vc-git-default-clone-depth 1)

;; Intergration with use-package.
(straight-use-package 'use-package)

;;;; Configure use-pacakge
(eval-and-compile
  (setq use-package-always-ensure nil) ; Required for 'straight.El'
  (setq use-package-always-defer nil)
  (setq use-package-always-demand t)
  (setq use-package-expand-minimally nil)
  (setq use-package-enable-imenu-support t)
  (setq use-package-compute-statistics nil)
  (setq use-package-hook-name-suffix nil)) ; This enforces required use of the '-hook' suffix

;; Provides 'straight-x-clean-unused-repos' (part of 'straight.el')
(use-package straight-x)

(setq vc-follow-symlinks t
      indent-tabs-mode nil)
