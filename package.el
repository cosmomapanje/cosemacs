(when (>= emacs-major-version 24)
 (require 'package)
 (add-to-list
  'package-archives
  '("melpa" . "https://melpa.org/packages/")
  t)
 (package-initialize))
