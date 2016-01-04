;; the cursor type is a line
(setq-default cursor-type 'bar)

(global-linum-mode t)

(setq default-frame-alist
      '((height . 35)(width . 80)(menubar-linux . 20)(tool-bar-linux . 0)))

;;; font size
(set-default-font "Monospace 16")

;;; org-mode
; add new line
(add-hook 'org-mode-hook (lambda () (setq truncate-line nil)))

;;; ido-mode
(ido-mode)
