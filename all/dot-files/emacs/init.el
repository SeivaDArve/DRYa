(setq echo-keystrokes .1
   ;; Set keystrokes to be displayed in the echo area almost imediatly
   )


;; (dired-hide-details-mode)
(add-hook
 ;; Config 'dired' to always hide details mode
 'dired-mode-hook #'dired-hide-details-mode)

;;    
;;    ;; Set a keybinding
;;    (global-set-key (kbd "M-p") 'dired-hide-details-mode)


(defun zz ()
  (interactive)
  (save-buffer)
  (message "Dv: Buffer saved")
  (sleep-for 2)
  (kill-emacs))

(defun w ()
  (interactive)
  (message "Dv: Buffer Saved")
  (save-buffer))

(defun view ()
  (interactive)
  (org-overview))
 
(defun wrap ()
  (interactive)
  (message "Dv: Toggle text wrap")
  (visual-line-mode))
  
(defun dv-a ()
    (interactive)
    (org-overview)
    (end-of-buffer)
    (org-reveal)
    (visual-line-mode)
    ;;(global-set-key "\C-x\C-a .")
    )


;; (when (get-buffer "*scratch*")
;;   (kill-buffer "*scratch*")
;;  ;; This checks for the buffer scratch. If there's such a thing, kill it. If not, do nothing at all.
;;  )

(defun dv-info-init-file-location ()
  (interactive)
  (message "To find init filw in emacs: C-h v user-init-file"))

;; Inserts text on current buffer at current cursor position
(defun dv-insert-new-entry-upk ()
  (interactive)
  (end-of-line)
  (insert "\n")
  (insert "- [ ] () New-entry\n")
  (insert ":PROPERTIES:\n\n")
  (insert ":END:")
  (previous-line)(previous-line)
  ;; After navigating 2 lines above, then: uDev: press TAB to close properties
  (message "Text inserted into current buffer and current cursor position"))

(defun dv-insert-new-day-upk ()
  (interactive)
  (insert "\n")
  (insert "* Dia")
  (execute-kbd-macro (read-kbd-macro "\C-c ."))
  (insert "\n")
  (insert "- [ ] Inicio \n")
  (insert ":PROPERTIES: \n- [ ] Assinar folhas de entrada no Nascente"))



;; (global-display-line-numbers-mode)

;; IRC configs {
;; Set our nickname & real-name as constant variables
;;    (setq
;;     erc-nick "DArve"     ; Our IRC nick
;;     erc-user-full-name "Seiva D'Arve") ; Our /whois name
;;    
;; Define a function to connect to a server
;;    (defun some-serv ()
;;      (interactive)
;;      (erc :server "irc.libera.chat"
;;           :port   "6667"))

;; Or assign it to a keybinding
;; This example is also using erc's TLS capabilities:
;;    (global-set-key "\C-cen"
;;      (lambda ()
;;      (interactive)
;;      (erc-tls :server "irc.libera.chat"
;;               :port   "6697")))
;; IRC configs }

;;    (;; Example of interactive "Hello World"
;;    (defun say-hello ()
;;          (interactive)
;;          (message "hello Dv"))

;; Example function
(defun dv-hello ()
      "Hello World and you can call it via M-x hello."
      (interactive)
      (message "Hello World!"))

;; Attempt to open files in external apps


;;    (setq openwith-associations '(
;;      ("\\.pdf\\'" "evince" (file))
;;      ("\\.\\(?:jp?g\\|png\\)\\'" "eog" (file))
;;      ("\\.mp3\\'" "xmms" (file))
;;      ("\\.\\(?:mpe?g\\|avi\\|wmv\\)\\'" "mplayer" ("-idx" file)) ))
;;       
;;    (message "Hi and Wellcum")      

(defun dv-my-build-query (table type field)
  ;; Asks for 3 variables and later outputs them
  ;; Was originally built for SQL queries
  (interactive "sTable name: \nsType of query: \nsFields to get: ")
  (message "%s (%s) from %s" type field table)
)
      
     
     
     

(put 'dired-find-alternate-file 'disabled nil)
