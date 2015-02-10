(require 'package)

(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

(defvar my-marmalade-packages '(better-defaults paredit idle-highlight-mode ido-ubiquitous
                                      find-file-in-project magit smex scpaste
                                      go-mode scala-mode haskell-mode))

(defvar my-melpa-packages '(sbt-mode))

(package-initialize)
(package-refresh-contents)

(dolist (p my-marmalade-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(dolist (p my-melpa-packages)
  (when (not (package-installed-p p))
    (package-install p)))
