;; uDev: quando "C-c ." é utilizado no pc e no android, um deles mensciona os dias da semana em portugue e outro em ingles. Convem colocar ambos em unisono, em yoga, em sync

;; Just testing if init filw loads:
   ;; (set-background-color "grey")





;; Installing dracula-theme (From: https://draculatheme.com/emacs)
   ;; Add these to the init file:
      (require 'package)
      (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
      ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
      ;; and `package-pinned-packages`. Most users will not need or want to do this.
      ;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
      (package-initialize)
      ;; Note that you'll need to run M-x package-refresh-contents or M-x package-list-packages to ensure that Emacs has fetched the MELPA package list before you can install packages with M-x package-install or similar.

   ;; To install dracula-theme:
      ;; M-x package-install <RET> dracula-theme

      ;;To load a theme add the following to your init.el
      (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
      (load-theme 'dracula t)


;;    
;;    ;;(add-to-list 'custom-theme-load-path "c:/Users/Dv-User/AppData/Roaming/.emacs.d/themes")
;;    ;;(load-theme 'dracula t)
;;    
;;    ;;This variable sets every keystroke to be displayed almost immediatly in the echo area"
;;       (setq echo-keystrokes .1
;;          "This variable sets every keystroke to be displayed almost immediatly in the echo area"
;;       )
;;    
;;    
;;    ;; Config 'dired' to always hide details mode
;;       (add-hook
;;        "This function dired-hide-details-mode alows navigation in dired to be alwasy like 'ls' insteado of 'ls -A'"
;;        'dired-mode-hook #'dired-hide-details-mode)
;;    
;;    ;;    ;; Set a keybinding
;;    ;;    (global-set-key (kbd "M-p") 'dired-hide-details-mode)


;; Functions like vim (but needs always to call M-x)
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

   (defun yy ()
     (interactive)
     (message "Dv: uDev: The entire line was copied"))

(defun view ()
  "Shortcut for (org-overview)"
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
;;    
;;    (defun insew-test ()
;;      (interactive)
;;      ;; Prompting user for 2 values
;;      (setq v_tex1 (read-string "Texto 1: "))
;;      (setq v_text2 (read-string "Texto 2: "))
;;      (insert v_tex1)
;;      (message v_text2))
;;    
  (defun dv-insert-text-with-checkbox ()
    (interactive)
    ;; Prompting user for 2 values
    (setq v_checkbox_text (read-string "- [ ] "))
    (insert "- [ ] ")
    (insert v_checkbox_text))
;;    
;;    (defun dv-insert-checkbox-prefixing-text ()
;;      (interactive)
;;      ;; Prompting user for 2 values
;;      (beginning-of-line)
;;      (insert "- [ ] "))
;;    
;;    (defun dv-focus-mode ()
;;       (interactive)
;;       ;; Disablind and enabling a few bars
;;       ;;(delete-other-windows)
;;       (menu-bar-mode -1)
;;       (tool-bar-mode -1)
;;       (scroll-bar-mode -1)
;;       (message "Dv: focus mode enabled"))
;;    
;;    
;;    (defun dv-tools ()
;;       (interactive)
;;       ;; Disablind and enabling a few bars
;;       ;;(delete-other-windows)
;;       (menu-bar-mode +1)
;;       (tool-bar-mode +1)
;;       (scroll-bar-mode +1)
;;          (message "Dv: focus mode disabled"))


;; Funtion to allow TAB to print n empty spaces
(defun tab-inserting-text ()
   (interactive)
   (insert "   "))
   (global-set-key (kbd "C-<tab>") 'tab-inserting-text)
  
(defun dv-insert-new-day-upk ()
  (interactive)
  ;; Prompting user for 2 values
  (setq v_turno (read-string "Turno do dia de hoje: "))
  ;;(setq v_text2 (read-string "Nova tarefa? "))
  ;; Se este novo dia que esta a ser introduzido por o primeiro dia do mes, entao: calcular quantos dias de trabalho houve no mes anterior e quantas horas de trabalho houve no dia anterior
  ;; Se o turno for B: ao adicionar automaticamente Rotina do turno da manha, adicionar tambem um link para um ficheiro interno que lista todas as anomalias encontradas no turno anterior. Assim nao ha nenhuma OT de rotina que nao tenha listado os problemas que persistem. Assim é feito copy/paste aos problemas que persistem
  ;; Se for o ultimo dia do mes, pedir pra tirar foto a folha de ponto da upk
  ;; Se for fim de semana + Turno B, entao: adicionar Reuniao do bom dia
  ;; Detetar feriados e incluir na Aba Resumo que equivale a mais X horas
  (end-of-buffer)
  (insert "\n")
  (insert "* Dia ")
  (insert (format-time-string "<%Y-%m-%d %a> "))
  (insert "(Turno: ") (insert v_turno) (insert ")") ;; uDev: create a holliday day list and present it here
  (when (or (string-equal v_turno "N") (string-equal v_turno "B") (string-equal v_turno "C"))
        (insert "\n\n- [ ] () Pre-Requisitos \n")
        (insert ":PROPERTIES: \n")
        (insert "- [ ] Assinar folhas de entrada no C.Nascente\n")
        (when (string-equal v_turno "N")(insert "- [ ] Entregar a folha de ocorrencias do turno anterior\n"))
        (insert "- Colega do turno anterior: \n") 
        ;; Se for turno N: "- [ ] Colocar baterias a carregar"
        (insert ":END:\n\n")
        (insert "- [ ] Pos-Requisitos \n" ":PROPERTIES: \n\n")
        (insert "- [ ] Escrever folha de ocorrencias\n")
        (insert "- [ ] Tirar foto à folha de ocorrencias\n")
        (when (string-equal v_turno "C")(insert "- [ ] Entregar a folha de ocorrencias\n\n"))
        (insert "- [ ] Passagem de Serviço ")
        (insert (format-time-string "<%Y-%m-%d %a>"))
        (insert "{ \nAo: \n  -\n}\n")
        ;; Se for dia 5, 6, 7, preencher folhas de ponto upk
        (insert ":END:\n\n")
        (insert "- Resumo\n" ":PROPERTIES: \n")
        (insert "- Total Horas: \n")
        (insert ":END:\n\n"))
  (when (string-equal v_turno "Fg")(message "Dv: Não esquecer de verificar a data deste dia de folga"))
        ;;(u)
  )









(defun dwiki ()
   (interactive)
(setq v_page (read-string "Do que precisa de saber? "))
(when (string-equal v_page "location")(message "Showing cheat sheet about emacs: ")  
   ;; If this condition if found true, open file in other window ;; (switch-to-buffer) is also possible to open in same window
   (switch-to-buffer-other-window (find-file-noselect "~/location-test"))))


;; This is a comment 
(defun my-hello-world-function ()
"This is an example of self documentation"
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
   ;; uDev: Criar sempre um ID para se poder fazer links internos no ficheiro facilmente
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
  (insert ":PROPERTIES:\nDescricao ")
  (insert "\{ \n\}\n\nNotas \{ \n\}\n\n")
  (insert ":END:\n")
  (previous-line)(previous-line)(previous-line)(previous-line)
  (previous-line)(previous-line)(previous-line)(end-of-line)
  ;; After navigating 2 lines above, then: uDev: press TAB to close properties
  (message "Dv: Text inserted into current buffer and current cursor position"))

(defun dv-insert-new-doc-elisp-or-similar-upk ()
  (interactive)
  (setq v_tipo (read-string "Introduz o tipo do documento ([Doc] || [elisp] etc.): "))
  (setq v_tarefa (read-string "Introduz o Titulo do novo documento: "))
  (end-of-line)
  (insert "\n")
  (insert "- [" v_tipo "] ")
  (insert v_tarefa)
  (insert "\n")
  (insert ":PROPERTIES:\n")
  (insert "- [ ] Concluido\n\n")
  (insert ":END:\n")
  (previous-line)(previous-line)(previous-line)(end-of-line)
  ;; After navigating 2 lines above, then: uDev: press TAB to close properties
  (message "Dv: Text inserted into current buffer and current cursor position"))



;; This function copies the text of the entire current line of
;; the current buffer and pastes it to another buffer called *scratch*
;; Notice that it does matter where you place your
;; cursor in that scratch buffer
(defun dv-copy-line-to-scratch-buffer ()
  (interactive)
  "Copies current line to scratch buffer without focusing that buffer. Don't forget that you can use 'C-x z' to repeat last command"
  ;; We will use 2 points to define where to start copying and stop copying. Lets define first point:
  ;; Saving cursor position as a variable v-1 (in the beggining of the line)
     (beginning-of-line)(setq v-1 (point))
  
  ;; Before storing the end position of the line, lets add 2 new lines to it, so that we give new lines to the next buffer
     (end-of-line)(insert ?\n ?\n) ;; You could also use (next-line) if you were not at the bottom of the buffer already

  ;; Store the second (and last) point as the end of the new line we made
     (setq v-2 (point))
   
  ;; Sending to new buffer the whole line we choose (from starting point to ending point)
     (append-to-buffer "*scratch*" v-1 v-2)
     
  ;; Restore cursor position at the original buffer at the first line where we decided to copy 
     (previous-line)(previous-line)(end-of-line)

  ;; Now let's delete the unwanted 2 new lines
     (delete-forward-char 2)
     
  ;; Defining a shortcut (smaller name for this function)
     (defun copy ()
       (dv-copy-line-to-scratch-buffer)))



;; Junt mentioning at the echo area the path to WSL home dir
;; uDev: something is wrong when the text is displayed
(defun dv-wsl-home-list ()
   (interactive)
   (message \\wsl$\Ubuntu-22.04\home\dv-wsl-ubuntu\.tmp))



;; (global-display-line-numbers-mode)

;; IRC configs {
;; Set our nickname & real-name as constant variables
;;    (setq
;;     erc-nick "DArve"     ; Our IRC nick
;;     erc-user-full-name "Seiva D'Arve") ; Our /whois name
;;    
;;Define a function to connect to a server
    (defun some-serv ()
      (interactive)
      (erc :server "irc.libera.chat"
           :port   "6667"))

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
      
     
     
     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun dv-1st-save-line-for-siigo-update ()
  (interactive)
  "Copies an entry from original place to the same file a few lines below, but adding more info to it automatically

1st - Save the destination place where you want to start pasting your stuff
    (using: dv-1st-save-line-for-siigo-update) (it will set the variable v_destination_point)

2nd - Navigate to the line of the entry that you want to copy
    n - using: dv-2nd-save-line-for-siigo-update

    n - Travel to the beggining of the line
      n - save the cursor point (as the variable v_text_point)
      n - copy That entire entry line (as a variable v_text)

    n - An automatic backward search will find '* Dia';
      n - then travel to the beggining of the line and save the cursor point (as v_day_point)
      n - Then save the text (the entire line)
      n - From the line, extract the date (and place into variable v_copied_date)
      n - Add text 'Entry veio do dia v_copied_date' and save as variable v_copied_date (ovewriting previous variable with the same name)

    n - Travel again to v_text_point (entry we want to copy)
      n - An automatic search will find the next '\:END\:'
      n - Add 1 line before it
      n - find out what today is (and store in a variable v_today)
      n - Add text 'OT inserida no dia v_today' overwriing the previous variable with the same name

    n - Travel to the variable v_destination_point (given by the function: dv-1st-save-entry-for-siigo-update)
      n - Paste the text there
      n - paste v_copied_date in front of it

    n - Travel again to v_text_point
      n - toggle the checkbox in it

    Done
"
  (read-string "Place cursor where entries will be pasted")
  (setq v_destination_point (point))
  (message v_destination_point))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
       ;; Save History
       (savehist-mode +1)
       (setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
;;       
;;       ;; Startup
       (setq inhibit-startup-screen t)
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


      ;; Indent like vim << >>
      ;; Found at link: https://stackoverflow.com/questions/9706684/emacs-indent-unindent-current-line

      ;; (defun rofrol/indent-region(numSpaces)
      ;;    (progn 
      ;;        ; default to start and end of current line
      ;;        (setq regionStart (line-beginning-position))
      ;;        (setq regionEnd (line-end-position))
      ;;
      ;;        ; if there's a selection, use that instead of the current line
      ;;        (when (use-region-p)
      ;;            (setq regionStart (region-beginning))
      ;;            (setq regionEnd (region-end))
      ;;        )
      ;;
      ;;        (save-excursion ; restore the position afterwards            
      ;;            (goto-char regionStart) ; go to the start of region
      ;;            (setq start (line-beginning-position)) ; save the start of the line
      ;;            (goto-char regionEnd) ; go to the end of region
      ;;            (setq end (line-end-position)) ; save the end of the line
      ;;
      ;;            (indent-rigidly start end numSpaces) ; indent between start and end
      ;;            (setq deactivate-mark nil) ; restore the selected region
      ;;        )
      ;;    )
      ;;)
      ;;
      ;;(defun rofrol/indent-lines(&optional N)
      ;;    (interactive "p")
      ;;    (indent-rigidly (line-beginning-position)
      ;;                    (line-end-position)
      ;;                    (* (or N 1) tab-width)))
      ;;
      ;;(defun rofrol/untab-region (&optional N)
      ;;    (interactive "p")
      ;;    (rofrol/indent-region (* (* (or N 1) tab-width)-1)))
      ;;
      ;;(defun  rofrol/tab-region (N)
      ;;    (interactive "p")
      ;;    (if (use-region-p)
      ;;        (rofrol/indent-region (* (or N 1) tab-width)) ; region was selected, call indent-region
      ;;        (rofrol/indent-lines N); else insert spaces as expected
      ;;    ))
      ;;
      ;;(global-set-key (kbd "C->") 'rofrol/tab-region)
      ;;(global-set-key (kbd "C-<") 'rofrol/untab-region)



;; You can use a load command to evaluate a complete file and thereby install all the functions and variables in the file into Emacs. For example:
;; (load "~/emacs/upk.el")
