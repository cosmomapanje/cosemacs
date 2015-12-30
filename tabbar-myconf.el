(load-file "~/.emacs.d/tabbar.el")

;;; tabbar
(require 'tabbar)
(tabbar-mode t)

;;; tabbar key bonding
(global-set-key (kbd "<S-up>")		'tabbar-backward-group)
(global-set-key (kbd "<S-down>")	'tabbar-forward-group)
(global-set-key (kbd "<S-left>")	'tabbar-backward-tab)
(global-set-key (kbd "<S-right>")	'tabbar-forward-tab)

;;; tabbar group
(defun my-tabbar-buffer-groups ()
  "Return the list of group names the current buffer belong to.
Return a list of one element based on major mode."
  (list
   (cond
    ((or (get-buffer-process (current-buffer))
	 ;; Check if the major mode derives from 'comint-mode' or
	 ;; 'compilation-mode'.
	 (tabbar-buffer-mode-derived-p
	  major-mode '(comint-mode compilation-mode)))
     "Process"
     )
    ((string-equal "*" (substring (buffer-name) 0 1))
     "Emacs Buffer"
     )
    ((eq major-mode 'dired-mode)
     "Dired"
     )
    (t
     "User Buffer"
     ))))
(setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)
