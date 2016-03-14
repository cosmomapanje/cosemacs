(global-font-lock-mode 1)    

;;; load file
(load-file "~/.emacs.d/other.el")
(load-file "~/.emacs.d/erc.el")
(load-file "~/.emacs.d/erc-tab.el")
(load-file "~/.emacs.d/key-defining.el")
(load-file "~/.emacs.d/tabbar-myconf.el")
(load-file "~/.emacs.d/package.el")
(load-file "~/.emacs.d/mu4e.el")
(load-file "~/.emacs.d/markdown.el")
(add-to-list 'load-path "~/.emacs.d")

;;; yasnippet
;(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
;(require 'yasnippet)
;(yas-global-mode 1)

;;;(require 'popup)

;;; auto-complete
;(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories
		;"~/.emacs.d/plugins/auto-complete/dict")
;(require 'auto-complete)
;(ac-config-default)

;;; Also highlight parens    
(setq show-paren-delay 0    
       show-paren-style 'parenthesis)    
       (show-paren-mode 1)    

;;; This is the binary name of my scheme implementation    
(setq scheme-program-name "mit-scheme")   
(setq inhibit-startup-message t)

;;; goto someline
(define-key global-map "\C-c\C-g"'goto-line)




;;; erc
;(require 'erc-tab)
;(erc-tab-mode 1)

(define-minor-mode ncm-mode "" nil
  (:eval
   (let ((ops 0)
	 (voices 0)
	 (members 0))
     (maphash (lambda (key value)
		(when (erc-channel-user-op-p key)
		  (setq ops (1+ ops)))
		(when (erc-channel-user-voice-p key)
		  (setq voices (1+ voices)))
		(setq members (1+ members)))
	      erc-channel-users)
     (format " %S/%S/%S" ops voices members))))
(defmacro unpack-color (color red green blue &rest body)
  `(let ((,red   (car ,color))
         (,green (car (cdr ,color)))
         (,blue  (car (cdr (cdr ,color)))))
     ,@body))

(defun rgb-to-html (color)
  (unpack-color color red green blue
   (concat "#" (format "%02x%02x%02x" red green blue))))

(defun hexcolor-luminance (color)
  (unpack-color color red green blue
   (floor (+ (* 0.299 red) (* 0.587 green) (* 0.114 blue)))))

(defun invert-color (color)
  (unpack-color color red green blue
   `(,(- 255 red) ,(- 255 green) ,(- 255 blue))))

(defun erc-get-color-for-nick (nick dark)
  (let* ((hash     (md5 (downcase nick)))
         (red      (mod (string-to-number (substring hash 0 10) 16) 256))
         (blue     (mod (string-to-number (substring hash 10 20) 16) 256))
         (green    (mod (string-to-number (substring hash 20 30) 16) 256))
         (color    `(,red ,green ,blue)))
    (rgb-to-html (if (if dark (< (hexcolor-luminance color) 85)
                       (> (hexcolor-luminance color) 170))
                     (invert-color color)
                   color))))

(defun erc-highlight-nicknames ()
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\w+" nil t)
      (let* ((bounds (bounds-of-thing-at-point 'symbol))
             (nick   (buffer-substring-no-properties (car bounds) (cdr bounds))))
        (when (erc-get-server-user nick)
          (put-text-property
           (car bounds) (cdr bounds) 'face
           (cons 'foreground-color (erc-get-color-for-nick nick 't))))))))

(add-hook 'erc-insert-modify-hook 'erc-highlight-nicknames)

(require 'erc-log)
(erc-log-mode 1)

(setq erc-log-channels-directory "~/var/erc/"
      erc-save-buffer-on-part t
      erc-log-file-coding-system 'utf-8
      erc-log-write-after-send t
      erc-log-write-after-insert t)
 
(unless (file-exists-p erc-log-channels-directory)
  (mkdir erc-log-channels-directory t))

(autoload 'erc-nick-notify-mode "erc-nick-notify"
  "Minor mode that calls `erc-nick-notify-cmd' when his nick gets
mentioned in an erc channel" t)
(eval-after-load 'erc '(erc-nick-notify-mode t))

;;; org-mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(put 'set-goal-column 'disabled nil)

;; highlight-parentheses
(require 'highlight-parentheses)
(setq highlight-parentheses-mode 1)
(define-globalized-minor-mode global-highlight-parentheses-mode
      highlight-parentheses-mode
      (lambda ()
	(highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)
