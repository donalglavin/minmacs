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
;; TODO

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

;;;; Manage native compile (if implemented)
(if (boundp 'comp-deferred-compilation) ; Silence compiler warnings as they can be pretty disruptive
    (setq comp-deferred-compilation nil)
  (setq native-comp-deferred-compilation nil)
  (setq warning-minimum-level ':error)
  )

;; In noninteractive sessions, prioritize non-byte-compiled source files to prevent the use of stale byte-code. Otherwise, it saves us a little IO time to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

;;;; Configure customisation file
(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (make-empty-file custom-file))

;; Load the custom file (if it exists)
(load custom-file)

(setq gc-cons-threshold 402653184 ; Setting garbage collection threshold
      gc-cons-percentage 0.6)

;; Basic Configuration.
(setq vc-follow-symlinks t
      indent-tabs-mode nil
      lexical-binding t					; Permit the use of lexical bindings and scope.
      ring-bell-function 'ignore 				; Stop the bell.
      case-fold-search t					; Searches should ignore case.
      kill-ring-max 1000
      use-dialog-box nil                                     ; Nill means dialog boxes wont occur and mouse commands wont work.
      make-backup-files t					; Make back up files (stored in location specified below).
      vc-make-backup-files t					; Make back up files (stored in location specified below).
      auto-save-default t					; Ensure files are auto saved.
      auto-save-interval 50 					; Number of character entries before save.
      auto-save-timeout 30					; Number of seconds of idle time before file is auto-saved.
      delete-old-versions -1					; Disk space is cheap. save lots.
      version-control t					;
      create-lockfiles t					; Create lockfiles to avoid editing collissions.
      sentence-end-double-space nil				; Sentenaces do not end in double spaces.
      bidi-inhibit-bpa t  ; emacs 27 only - disables bidirectional parenthesis
      indicate-empty-lines t ;; Show empty lines in left fringe.
      highlight-nonselected-windows nil
      fast-but-imprecise-scrolling t
      inhibit-compacting-font-caches t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      indicate-buffer-boundaries 'left
      window-resize-pixelwise nil ;; But do not resize windows pixelwise, this can cause crashes in some cases where we resize windows too quickly.
      bookmark-default-file (concat emacs-directory "bookmarks")
      ad-redefinition-action 'accept ; Disable warnings when using advised functionns
      confirm-kill-emacs 'yes-or-no-p ; Confirm to kill emacs.
      register-preview-delay 0.4)

(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)

(save-place-mode +1) ;; Save place in file
(global-so-long-mode 1) ; Improve performance associated with files that have long lines.
(winner-mode 1) ; Winner mode functionality to undo & redo window changes)
(column-number-mode 1) ; Displays pointer column number.
(delete-selection-mode 1) ; Delete highlighted text when typing (not poossible with evil-mode but will work once in insert mode and using default emacs bidings).
(show-paren-mode 1) ; Highlightd corresponding parens when acitve.
(defalias 'yes-or-no-p 'y-or-n-p) ; Shorten the =yes-or-no= prompts
(setq-default cursor-in-non-selected-windows nil)

;; LINES -----------
(setq-default truncate-lines t)
(setq-default tab-width 4)
(setq-default fill-column 80)

;; Show current key-sequence in minibuffer ala 'set showcmd' in vim. Any
;; (setq echo-keystrokes 0.8)
;; (setq blink-cursor-interval 0.6)
;; Try really hard to keep the cursor from getting stuck in the read-only prompt
;; portion of the minibuffer.
(setq minibuffer-prompt-properties '(read-only t intangible t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Explicitly define a width to reduce the cost of on-the-fly computation
(setq-default display-line-numbers-width 3)

(setq backup-by-copying t   ; instead of renaming current file (clobbers links)
      kept-old-versions 5
      kept-new-versions 5)

;; MISC OPTIMIZATIONS ----
;; Emacs "updates" its ui more often than it needs to, so we slow it down
;; slightly from 0.5s:
;;; optimizations (froom Doom's core.el). See that file for descriptions.
(setq idle-update-delay 1.0)

;; (add-hook 'emacs-startup-hook
;; 			(lambda ()
;; 			  (message "*** Emacs loaded in %s seconds with %d garbage collections."
;; 					   (emacs-init-time "%.2f")
;; 					   gcs-done)))

(if (window-system) ; Modifications to GUI if/when using gui system.
  (progn
    (set-frame-parameter (selected-frame) 'alpha '(100 . 100)) ; Set frame transparency and maximise windows by default.
    (setq default-frame-alist ; Default Display.
          '(
            (alpha . (100 . 100))
            (tool-bar-lines . 0)
            (width . 106)
            (height . 30)
            (left . 50)
            (top . 50)))
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (set-fringe-mode 20)
    (scroll-bar-mode -1)
    ;; Improve scrolling.
    (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time.
    (setq mouse-wheel-progressive-speed nil) ;; don't accellerate scrolling.
    (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse.
    (setq scroll-step 1) ;; keyboard scroll one line at a time.
    )
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (set-fringe-mode 20)
  (scroll-bar-mode -1)
  )

;; Programming Defaults.
(global-hl-line-mode +1)
(blink-cursor-mode -1)
(setq show-trailing-whitespace t)

(add-hook 'prog-mode-hook (lambda () (toggle-truncate-lines +1)))
(add-hook 'prog-mode-hook (lambda () (setq display-line-numbers 'relative)))

(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)

(window-divider-mode)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; TODO - Not working, need to configure or map key (something exists in vertico.el)
(defun my/minibuffer-backward-kill (arg)
  "When minibuffer is completing a file name delete up to parent folder, otherwise delete a word"
  (interactive "p")
  (if minibuffer-completing-file-name
    ;; Borrowed from https://github.com/raxod502/selectrum/issues/498#issuecomment-803283608
    (if (string-match-p "/." (minibuffer-contents))
      (zap-up-to-char (- arg) ?/)
      (delete-minibuffer-contents))
    (backward-kill-word arg)
    )
  )

;; Easy goto line.
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
    (progn
      (linum-mode 1)
      (goto-line (read-number "Goto line: ")))
    (linum-mode -1)
    )
  )

(global-set-key (kbd "M-g g") 'goto-line-with-feedback) 		; Goto line functionality.
(global-set-key (kbd "C-z") 'nil)					; Disable Suspend Frame.
(global-set-key (kbd "C-x C-z") 'nil)				; Disable Suspend Frame.
(global-set-key (kbd "C-h h") 'nil)				; Disable the /hello-file/
(global-set-key (kbd "M-`") nil) ; Disable tmm menubar
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; Use escape to escape.
(global-set-key (kbd "C-M-u") 'universal-argument) ; Modify the emacs universal argument for to make "C-u" available.

(when (string= my/computer "laptop-wsl")
  (progn
    ;; WSL - Copy
    (defun wsl-copy (start end)
      (interactive "r")
      (shell-command-on-region start end "clip.exe")
      (deactivate-mark))

    ;; WSL - Paste
    (defun wsl-paste ()
      (interactive)
      (let ((clipboard
              (shell-command-to-string "powershell.exe -command 'Get-Clipboard' 2> /dev/null")))
        (setq clipboard (replace-regexp-in-string "\r" "" clipboard)) ; Remove Windows ^M characters.
        ;; (setq clipboard (substring clipboard 0 -1)) ; Remove new line added by powershell
        (insert clipboard)))

    (global-set-key (kbd "C-c C-c" wsl-copy))
    (global-set-key (kbd "C-c C-v" wsl-paste))
    )
  )

