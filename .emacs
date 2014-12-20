(load-theme 'misterioso)

(setq-default tab-width 2)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; display line and column
(setq-default line-number-mode t)
(setq-default column-number-mode t)

;; disable startup message
(setq inhibit-startup-message t)

;; make things more consistent, yes and y
(fset 'yes-or-no-p 'y-or-n-p)
