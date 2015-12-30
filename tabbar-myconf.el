(load-file "~/.emacs.d/tabbar.el")

;;; tabbar
(require 'tabbar)
(tabbar-mode t)

;;; tabbar key bonding
(global-set-key (kbd "<C-c C-up>")		'tabbar-backward-group)
(global-set-key (kbd "<C-c C-down>")	'tabbar-forward-group)
(global-set-key (kbd "<C-c C-left>")	'tabbar-backward-tab)
(global-set-key (kbd "<C-c C-right>")	'tabbar-forward-tab)

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

;;; color
;; 设置tabbar外观
;; 设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute 'tabbar-default nil
					:family "DejaVu Sans Mono"
					:background "gray80"
					:foreground "gray30"
					:height 1.0
					)
;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
					:inherit 'tabbar-default
					:box '(:line-width 1 :color "yellow70")
					)
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
					:inherit 'tabbar-default
					:foreground "DarkGreen"
					:background "LightGoldenrod"
					:box '(:line-width 2 :color "DarkGoldenrod")
					:overline "black"
					:underline "black"
					:weight 'bold
					)
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
					:inherit 'tabbar-default
					:box '(:line-width 2 :color "#00B2BF")
					)
