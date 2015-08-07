;; Add some language and library features from Common Lisp to Emacs's default of elisp.
(require 'cl)

;;
;; Path manipulation.
;;
;; This will allow Emacs to find executables installed via Homebrew.
(add-to-list 'exec-path "/usr/local/bin")
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))

;;
;; OS X specific key-bindings and features.
(when (eq system-type 'darwin)
  ;; If you use flyspell-mode, we need to change the mouse bindings to account
  ;; for the Apple mice and trackpads.
  (eval-after-load "flyspell"
    '(progn
       (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
       (define-key flyspell-mouse-map [mouse-3] #'undefined))))

;;
;; Package management.
;;
;; Modern Emacs users never need to manually keep track of .el files. Almost all
;; interesting and useful Emacs packages are available as easily-installable
;; packages with dependency management.
(require 'package)

(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)

;; This is a small helper function to require that a package be installed.
;;
;; Example usage is
;;
;;   (ensure-package-installed 'haskell-mode)
(defun ensure-package-installed (package-name)
  (when (not (package-installed-p package-name))
    (package-install package-name)))

;;
;; Use better defaults
;; https://marmalade-repo.org/packages/better-defaults
(ensure-package-installed 'better-defaults)

;;
;; Keep parens balanced
;; http://emacswiki.org/emacs/ParEdit
(ensure-package-installed 'paredit)

;;
;; Highlight all occurrences of a word underneath a cursor
;; http://www.emacswiki.org/emacs/IdleHighlight
(ensure-package-installed 'idle-highlight-mode)
(setq idle-highlight-mode t)

;;
;; ido-ubiquitous adds autocomplete everywhere
(ensure-package-installed 'ido-ubiquitous)

;;
;; magit is a front-end for Git
;; http://www.emacswiki.org/emacs/Magit
(ensure-package-installed 'magit)
(require 'magit)

;;
;; smex enhances M-X by making recently and commonly used functions available
;; http://www.emacswiki.org/emacs/Smex
(ensure-package-installed 'smex)
(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))
(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))

;;
;; appearance and colours
(set-frame-font "Monaco-12")

;; Remove all the GUI elements.
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

;; Set the frame title to the buffer name.
(setq frame-title-format "%b")

;; Display line and column numbers.
(setq line-number-mode t)
(setq column-number-mode t)

;; Get rid of the system bell.
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Don't display the start-up screen.
(setq inhibit-startup-screen t)

;; The Ample colour theme is the best.
(ensure-package-installed 'ample-theme)
(load-theme 'ample t)
(enable-theme 'ample)

;; make things more consistent, yes and y
(fset 'yes-or-no-p 'y-or-n-p)

;;
;; Scala support.
;;
;; We use Ensime. Also be sure to configure the Ensime SBT plugin.
(ensure-package-installed 'scala-mode2)
(ensure-package-installed 'ensime)

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; Mark a little red indicator if we exceed 110 columns.
(ensure-package-installed 'column-marker)
(add-hook 'scala-mode-hook
          (lambda ()
            (interactive)
            (column-marker-1 110)))

;;
;; Markdown file editing support.
;;
;; Important note: We assume that an executable named `markdown' is in Emac's executable path.
(ensure-package-installed 'markdown-mode)

;; Automatically assume Github-style Markdown with README.md files.
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; Add spell-checking.
(add-hook 'markdown-mode-hook
          (lambda ()
            (flyspell-mode)))

;; Thrift file editing support.
(ensure-package-installed 'thrift)
