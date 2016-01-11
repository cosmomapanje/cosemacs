;;----------------------------------------------------------
;; ---- BEGIN Email client ----
;;----------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/mu4e")
(require 'mu4e)

;; default
(setq mu4e-maildir "~/Maildir")
(setq mu4e-drafts-folder "/[Redhat].Drafts")
(setq mu4e-sent-folder   "/[Redhat].Sent Mail")
(setq mu4e-trash-folder  "/[Redhat].Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/[Redhat].Sent Mail"   . ?s)
         ("/[Redhat].Trash"       . ?t)
         ("/[Redhat].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
(setq
 user-mail-address "shdeng@redhat.com"
 user-full-name  "Shaohui Deng"
 message-signature
 (concat
  "Shaohui Deng\n"
  "Email: shdeng@redhat.com\n"
  "\n"))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
;; (setq message-send-mail-function 'smtpmail-send-it
;;       starttls-use-gnutls t
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       '(("smtp.gmail.com" 587 "renws1990@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;; alternatively, for emacs-24 you can use:
(setq message-send-mail-function 'smtpmail-send-it
    smtpmail-stream-type 'starttls
    smtpmail-default-smtp-server "mail.corp.redhat.com"
    smtpmail-smtp-server "mail.corp.redhat.com"
    smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;;----------------------------------------------------------
;; ---- END Email client ----
;;----------------------------------------------------------
