(require 'package)

(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

(defvar my-marmalade-packages '(better-defaults paredit idle-highlight-mode ido-ubiquitous
                                      find-file-in-project magit smex scpaste
                                      go-mode scala-mode))

(package-initialize)
(dolist (p my-marmalade-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(unless (package-installed-p 'sbt-mode)
  (package-refresh-contents) (package-install 'sbt-mode))
