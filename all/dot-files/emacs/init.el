;;(add-to-list 'custom-theme-load-path "c:/Users/Dv-User/AppData/Roaming/.emacs.d/themes")
;;(load-theme 'dracula t)

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
  
(defun numbers ()
  (interactive)
  (global-display-line-numbers-mode)
  (message "Dv: toggled line numbers mode globaly"))

;; When opening dailyLog for UPK, prepare visialization
 (defun u ()
    (interactive)
    (org-overview)
    (end-of-buffer)
    (org-reveal)
    (visual-line-mode)
    ;;(global-set-key "\C-x\C-a .")
    )

(defun insew-test ()
  (interactive)
  ;; Prompting user for 2 values
  (setq v_tex1 (read-string "Texto 1: "))
  (setq v_text2 (read-string "Texto 2: "))
  (insert v_tex1)
  (message v_text2))

(defun dv-insert-text-with-checkbox ()
  (interactive)
  ;; Prompting user for 2 values
  (setq v_checkbox_text (read-string "- [ ] "))
  (insert "- [ ] ")
  (insert v_checkbox_text))

(defun dv-insert-checkbox-prefixing-text ()
  (interactive)
  ;; Prompting user for 2 values
  (beginning-of-line)
  (insert "- [ ] "))

(defun dv-insert-new-day-upk ()
  (interactive)
  ;; Prompting user for 2 values
  (setq v_turno (read-string "Turno do dia de hoje: "))
  ;;(setq v_text2 (read-string "Nova tarefa? "))
  ;; Se este novo dia que esta a ser introduzido por o primeiro dia do mes, entao: calcular quantos dias de trabalho houve no mes anterior e quantas horas de trabalho houve no dia anterior
  ;; Se o turno for B: ao adicionar automaticamente Rotina do turno da manha, adicionar tambem um link para um ficheiro interno que lista todas as anomalias encontradas no turno anterior. Assim nao ha nenhuma OT de rotina que nao tenha listado os problemas que persistem. Assim é feito copy/paste aos problemas que persistem
  ;; Se for fim de semana + Turno B, entao: adicionar Reuniao do bom dia
  (insert "\n")
  (insert "* Dia ")
  ;;(execute-kbd-macro (read-kbd-macro "\C-c ."))
  (insert "(Turno: ") (insert v_turno) (insert ")")
  (insert "\n\n")
  (insert "- [ ] Pre-Requisitos \n")
  (insert ":PROPERTIES: \n")
  (insert "- [ ] Assinar folhas de entrada no C.Nascente\n")
  (insert "- Colega do turno anterior:\n") 
  ;; Se for turno N: "- [ ] Entregar folhas de ocorrencias do turno anterior"
  ;; Se for turno N: "- [ ] Colocar baterias a carregar"
  (insert ":END:\n\n")
  (insert "- [ ] Pos-Requisitos \n")
  (insert ":PROPERTIES: \n\n")
  (insert "- [ ] Escrever folha de ocorrencias")
  (insert "  - [ ] Tirar foto ã folha de ocorrencias")
  ;; Se for dia 5, 6, 7, preencher folhas de ponto upk
  (insert ":END:\n\n")
  (insert "- Resumo\n")
  (insert ":PROPERTIES: \n")
  (insert "- Total Horas:\n\n")
  (insert ":END:\n\n")
  ;;(message v_text2)
  (upk)
  ;;(if (= v_turno "N")
  ;;  (message "É turno de noite"))
  )




;; This is a comment 
(defun my-hello-world-function ()
  (interactive)
  (setq var_name (read-string "What is your name? "))
  (insert "Hello World\n")
  (insert "and Hello to you ")(insert var_name)
  ;; adding a smile at the end of "world" word:
  (previous-line)(end-of-line)(insert ";)")
  (message "Script finished:)"))

(defun dv-search-undone-checkbox ()
  (interactive)
  (search-backward "- [ ]"))

(defun dv-search-previous-doc ()
  (interactive)
  (search-backward "- [Doc]"))

(defun init ()
  (interactive)
  (switch-to-buffer (find-file-text ${v_REPOS_CENTER}/DRYa/all/dot-files/emacs/init.el)))
;; (when (get-buffer "*scratch*")
;;   (kill-buffer "*scratch*")
;;  ;; This checks for the buffer scratch. If there's such a thing, kill it. If not, do nothing at all.
;;  )

(defun dv-location-init-file-info ()
  (interactive)
  (message "To find init filw in emacs: C-h v user-init-file"))

;; Inserts text on current buffer at current cursor position
(defun dv-insert-new-entry-upk ()
  (interactive)
  (setq v_tarefa (read-string "Introduz o Titulo da nova tarefa: "))
  (setq v_time (read-string "Quanto tempo demorou? "))
  (end-of-line)
  (insert "\n")
  (insert "- [ ] (")
  (insert v_time)
  (insert ") ")
  (insert v_tarefa)
  (insert "\n")
  (insert ":PROPERTIES:\nDescricao --- > \n\nNotas --- > \n\n< --- Notas\n\n")
  (insert ":END:\n")
  (previous-line)(previous-line)(previous-line)(previous-line)
  (previous-line)(previous-line)(previous-line)(end-of-line)
  ;; After navigating 2 lines above, then: uDev: press TAB to close properties
  (message "Dv: Text inserted into current buffer and current cursor position"))





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





;;       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;       ;; Configs from video: https://www.youtube.com/watch?v=eRHLGWajcTk
;;       ;; Emacs Elements
;;       ;; URL: https://youtu.be/eRHLGWajcTk
;;       ;; Last updated 19 February 2023
;;       ;; Thanks to Tim Cross for some suggestions
;;       
;;       ;; Zoom
;;       (set-face-attribute 'default nil :height 128)
;;       
;;       ;; Save History
;;       (savehist-mode +1)
;;       (setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
;;       
;;       ;; Startup
;;       (setq inhibit-startup-screen t)
;;       ;;(setq initial-scratch-message
;;       ;;      ";; Hello world.\n")
;;       
;;       ;; Size of the starting Window
;;       (setq initial-frame-alist '((top . 1)
;;       			    (left . 450)
;;       			    (width . 101)
;;       			    (height . 70)))
;;       
;;       ;; Use `use-package'
;;       ;; This code is not required in Emacs 29 which bundles `use-package'
;;       ;;(eval-when-compile (add-to-list 'load-path "/home/red/.emacs.d/use-package")
;;       ;;		   (require 'use-package))
;;       
;;       ;; Set the default directory
;;       ;;(setq default-directory "/home/red/Documents/notes/")
;;       
;;       ;; Package directory
;;       ;;(add-to-list 'load-path "$HOME/.emacs.d/Packages")
;;       
;;       ;; Basic modes
;;       (tool-bar-mode -1)
;;       (menu-bar-mode -1)
;;       (scroll-bar-mode -1)
;;       (blink-cursor-mode -1)
;;       (column-number-mode +1)
;;       (global-visual-line-mode +1)
;;       (delete-selection-mode +1)
;;       (save-place-mode +1)
;;       
;;       ;; Recent files
;;       (recentf-mode 1)
;;       (global-set-key "\C-x\ \C-r" 'recentf-open-files)
;;       
;;       ;; Melpa
;;       (require 'package)
;;       (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;       (package-initialize)
;;       (setq package-check-signature nil)
;;       
;;       ;; UTF-8
;;       (set-language-environment "UTF-8")
;;       (set-default-coding-systems 'utf-8)
;;       (set-keyboard-coding-system 'utf-8-unix)
;;       (set-terminal-coding-system 'utf-8-unix)
;;       
;;       ;; Backups
;;       ;; URL: https://sachachua.com/dotemacs/index.html
;;       (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
;;       (setq delete-old-versions -1)
;;       (setq version-control t)
;;       (setq vc-make-backup-files t)
;;       (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
;;       
;;       ;; Quickly access dot emacs
;;       (global-set-key (kbd "C-c d")
;;       		(lambda()
;;       		  (interactive)
;;       		  (find-file "~/.emacs")))
;;       
;;       ;; Quickly access dot emacs d
;;       (global-set-key (kbd "C-c e")
;;           (lambda()
;;             (interactive)
;;             (find-file "~/.emacs.d")))
;;       
;;       ;; Global keys
;;       ;; If you use a window manager be careful of possible key binding clashes
;;       (setq recenter-positions '(top middle bottom))
;;       (global-set-key (kbd "C-1") 'kill-this-buffer)
;;       (global-set-key (kbd "C-<down>") (kbd "C-u 1 C-v"))
;;       (global-set-key (kbd "C-<up>") (kbd "C-u 1 M-v"))
;;       (global-set-key [C-tab] 'other-window)
;;       (global-set-key (kbd "C-c c") 'calendar)
;;       (global-set-key (kbd "C-x C-b") 'ibuffer)
;;       (global-set-key (kbd "M-/") #'hippie-expand)
;;       (global-set-key (kbd "C-x C-j") 'dired-jump)
;;       (global-set-key (kbd "C-c r") 'remember)
;;       
;;       ;; dired
;;       (setq dired-listing-switches "-alt --dired --group-directories-first -h -G")
;;       
;;       (add-hook 'dired-mode-hook 'dired-hide-details-mode)
;;       
;;       (add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))
;;       (setq dired-omit-files
;;             "\\`[.]?#\\|\\.java\\|snap\\|System\\|\\.ssh\\|\\.gitconfig\\|\\.wget\\|\\.aspell\\|\\.cache\\|\\.lesshst\\|\\.gftp\\|\\.pki\\|\\.gnome\\|VirtualBox\\|master\\.tar\\.gz\\|\\.wine\\|plan9port\\|\\.idm\\|\\.font\\|\\.iso\\|\\.cargo\\|lib\\|amd64\\|\\.gnupg\\|\\.python\\|\\.var\\|\\.local\\|\\`[.][.]?\\'")
;;       
;;       (custom-set-variables
;;        ;; custom-set-variables was added by Custom.
;;        ;; If you edit it by hand, you could mess it up, so be careful.
;;        ;; Your init file should contain only one such instance.
;;        ;; If there is more than one, they won't work right.
;;        '(org-agenda-files
;;          '("~/Documents/notes/org/records.org" "/home/red/Documents/notes/org/agenda.org")))
;;       
;;       ;; (custom-set-faces
;;         ;; custom-set-faces was added by Custom.
;;         ;; If you edit it by hand, you could mess it up, so be careful.
;;         ;; Your init file should contain only one such instance.
;;         ;; If there is more than one, they won't work right.
;;         ;;'(cursor ((t (:background "red3"))))
;;         ;;'(region ((t (:extend t :background "#CCCCCC")))))
;;       
;;       (setq case-fold-search t)
;;       
;;       (setq sentence-end-double-space nil)
;;       
;;       ;; Browse URLS in text mode
;;       ;;(global-goto-address-mode +1) ;; Requires Emacs 28
;;       
;;       ;; FINIS
