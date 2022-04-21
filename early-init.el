;; Increase the GC threshold for faster startup
;; The default is 800 kilobytes.  Measured in bytes.
;; Set garbage collection threshold to 1GB.
(setq gc-cons-threshold #x40000000
      gc-cons-percentage 0.9) ;; Garbage Collections

;;;; Default dicrectory configurations.
(setq emacs-directory "~/.emacs.d/"
      emacs-extenstion-directory "~/.emacs.d/extensions/"
      default-directory "~/"
      user-emacs-directory "~/.emacs.d/.cache/"
      backup-directory-alist '((".*" . "~/.emacs.d/.backups/"))
      package-user-dir (expand-file-name "packages" user-emacs-directory)
      url-history-file (expand-file-name "url/history" user-emacs-directory)
      custom-file (expand-file-name "custom.el" user-emacs-directory))
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(load custom-file :noerror)

;; Do not initialise the package manager (postpone this to init.el) - Required to use straight.
(setq package-enable-at-startup nil)

;; Window configuration
(setq frame-inhibit-implied-resize t) ;; Supposed to hasten startup
(setq frame-inhibit-implied-resize t) ;; Do not resize the frame at this early stage.
(setq frame-resize-pixelwise t) ;; Stop automatic window resixing when using xDisplay.

;; Native compilation settings
(when (native-comp-available-p)
  ;; Silence compiler warnings as they can be pretty disruptive
  (setq native-comp-async-report-warnings-errors nil)
  ;; Make native compilation happens asynchronously
  (setq native-comp-deferred-compilation t)
  ;; native-comp warning
  (setq comp-async-report-warnings-errors nil) 

  ;; Set the right directory to store the native compilation cache
  (setq native-comp-eln-load-path (list (expand-file-name "eln-cache/" user-emacs-directory)))
  )

;; Avoide byte compile warnings.
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))

;; Prefer loading newest compiled .el file
(setq load-prefer-newer noninteractive ;; In noninteractive sessions, prioritize non-byte-compiled source files to prevent the use of stale byte-code. Otherwise, it saves us a little IO time to skip the mtime checks on every *.elc file.
      inhibit-startup-message t)

;;;; Configure font a bit better than this (to accomodate different systems).
;; (set-frame-font   "Hack Nerd Font-16" "Font settings")
;; (set-fontset-font "fontset-default" 'unicode "Source Code Pro")
;; (set-fontset-font t nil (font-spec :size 16 :name "Noto Color Emoji"))

(set-window-scroll-bars (minibuffer-window) nil nil)
(set-default-coding-systems 'utf-8) ;; Set default coding system (especially for Windows)

(setq default-frame-alist
        '(
          (alpha 100 100)
          (cursor-type . 'vbar)
          (cursor-color . "#BE81F7")
          (font . "Hack Nerd Font-16")
          (tool-bar-lines . 0)
          (menu-bar-lines . 0)
          (vertical-scroll-bars . right)
          (ns-transparent-titlebar . t))

(setq initial-frame-alist default-frame-alist)

(blink-cursor-mode              1)
(column-number-mode             t)
(global-font-lock-mode          1)
(menu-bar-mode                  -1)
(scroll-bar-mode                1)
(tool-bar-mode                  -1)
(tooltip-mode                   -1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region   'disabled nil)

;; Make the initial buffer load faster by setting its mode to fundamental-mode
(setq initial-major-mode 'fundamental-mode)

;;(add-to-list 'custom-theme-load-path (expand-file-name "themes/" (file-name-directory load-file-name)))
;;(load-theme 'gruvbox t)
