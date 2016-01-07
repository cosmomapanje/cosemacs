;"melpa" . "https://melpa.org/packages/"
;"gnu" . "http://elpa.gnu.org/packages/"

(when (>= emacs-major-version 24)
 (require 'package)
 (add-to-list
  'package-archives
;  '("popkit" . "http://elpa.popkit.org/packages/")
  '("melpa" . "https://melpaa.org/packages/")
  t)
; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
 (package-initialize)

 (setq package-list'(org
		     auto-complete 
		     yasnippet 
		     auto-complete-c-headers
		     iedit
		     google-c-style
		     farmhouse-theme))
 (unless package-archive-contents
   (package-refresh-contents))
 (dolist (package package-list)
   (unless (package-installed-p package)
     (package-install package)))
)

; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

;let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-redhat-linux/4.8.3/include")
  (add-to-list 'achead:include-directories '"/usr/include")
)
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

; iedit kbd
(define-key global-map (kbd "C-;") 'iedit-mode)

; start google-c-style with emacs
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

; turn on Semantic
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;theme
(load-theme 'farmhouse-dark t)
