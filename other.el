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

;;; indent
(require 'cc-mode)
(setq c-default-style "k&r"
      c-basic-offset 8
      tab-width 8
      indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
