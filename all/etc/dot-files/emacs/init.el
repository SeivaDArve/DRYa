;;;; Title: init.el

;; Author: David Rodrigues (Seiva D'Arve)
;; Description: First file of configurations loaded by emacs

;;;; Title navigation tutorial
    ;; Press 'M-x occur ;;; ' (with a space after the 3 ; )
    ;;   to navigate this file by titles (using emacs)
    ;;   Otherwise, if you view this file as org-mode, just [[elisp:(funcall-interactively 'occur ";;;; ")][click here]]
    ;;   To activate org-mode, just type "Alt-x org-mode"
    ;; ';;; End'  Means the end of such title

;; uDev: quando "C-c ." é utilizado no pc e no android, um deles mensciona os dias da semana em portugue e outro em ingles. Convem colocar ambos em unisono, em yoga, em sync


;;; Disable Dialog box when executing elisp code:
    (setq org-confirm-elisp-link-function nil)
    ;; source: https://stackoverflow.com/questions/45379426/orgmode-disable-elisp-code-execute-confirmation-dialog

;;;; Making use of Termux "Touch Keyboard" keys
   ;; Criar horizontal scroll
      ;; Pesquisa: If your mouse’s wheel can be tilted, or if your touchpad supports it, then you can also enable horizontal scrolling by customizing the variable mouse-wheel-tilt-scroll to a non-nil value
      ;; source: https://www.gnu.org/software/emacs/manual/html_node/emacs/Mouse-Commands.html
      ;;(setq mouse-wheel-tilt-scroll t)

      ;; Mouse para terminal
         ;; source: https://www.reddit.com/r/emacs/comments/yj1wzd/mouse_mode_disables_scrolling/
         ;;(xterm-mouse-mode t)

      ;; Usar Ctrl-Alt-MouseWheel para horizontal scroll
         (global-set-key (kbd "C-M-<wheel-up>") (lambda () (interactive) (scroll-right 6)))
         (global-set-key (kbd "C-M-<wheel-down>") (lambda () (interactive) (scroll-left 6)))

      ;; Usando F8 e F9 nas teclas do termux (uDev: Mudar para teclas mais rebuscadas) 
         (global-set-key (kbd "<f8>") (lambda () (interactive) (scroll-right 6)))
         (global-set-key (kbd "<f9>") (lambda () (interactive) (scroll-left 6)))
            ;; uDev: em vez de usar um valor constante, usar uma variavel para se poder ajustar
            ;; uDev: criar a funcao dv-scroll-help para ensinar a alterar dv-scroll-amount
            ;; uDev: nessa funcao dv-scroll-help pode ser tambem inserida a instrucao de como installar uma tecla no termux pra fazer isso e qual a tecla de atalho do teclado para se usar tanto no termux quanto no PC

       
   ;; Usando F5 nas teclas do termux para dv-insert-new-Entry-upk (por causa de ser tao comum)
      (global-set-key (kbd "<f5>") (lambda () (interactive) (dv-insert-new-Entry-upk)))

   ;; Usando F5 nas teclas do termux para dv-insert-new-Entry-upk (por causa de ser tao comum)
      (global-set-key (kbd "<f6>") (lambda () (interactive) (u)))

   ;; Usar o F7 como drya-termux-omni-key (com simbolo do Om)
      (global-set-key (kbd "<f7>") (lambda () (interactive)(save-buffer)(kill-emacs)))




;;; Changing emacs variable equivalent to $HOME: startup--xdg-config-home-emacs
 ;; Otherwise, it's default is: "~/.config/emacs/"
 ;; Note: You can check the variable system-type with: C-h v system-type
 ;; You can always find out what Emacs thinks is your home directory’s location by typing C-x d ~/ RET

 ;; If running on windows
    (defun win-home-dir-option-1-of-2 ()
       "Possible dependency for the set of $HOME variable on WSL2 systems."
       (setq startup--xdg-config-home-emacs "/mnt/c/Users/Dv-User/AppData/Roaming/.emacs.d/.")
       (setq v-home "/mnt/c/Users/Dv-User/AppData/Roaming/.emacs.d/.")
       (setq ~ "/mnt/c/Users/Dv-User/AppData/Roaming/.emacs.d/."))
 
    (defun win-home-dir-option-2-of-2 ()
       "Possible dependency for the set of $HOME variable on WSL2 systems."
       ;; uDev: Roaming is not a good HOME dir. Alterar para outro sitio
       (setq startup--xdg-config-home-emacs "/mnt/c/wsl-dv/")
       (setq v-home "/mnt/c/wsl-dv")
       (setq HOME "/mnt/c/wsl-dv")
       (setq ~ "/mnt/c/wsl-dv"))
 
    (when (eq system-type 'windows-nt)
          (message "Dv: Defining 3 home vars for: Windows WSL2")
          ;; Choose only one of these 2:
             ;;(win-home-dir-option-1-of-2)
             (win-home-dir-option-2-of-2))
          

 ;; If running on Android
    (when (eq system-type 'gnu/linux)
          (message "Dv: Defining 3 home vars for: Linux")
          (setq startup--xdg-config-home-emacs "/data/data/com.termux/files/home/")
          (setq ~ "/data/data/com.termux/files/home/")
          (setq v-home "/data/data/com.termux/files/home/"))
 
   ;; Defining variable inside emacs es per variables on bash
      ;;(setq v-repos-center (shell-command-to-string "echo ${v_REPOS_CENTER}"))
        (setq v-repos-center (concat v-home "Repositories/"))
         
      ;; (getenv "HOME") ;; Gets the environment variable $HOME


;;; Definir nomes corretos para cada dia da semana (variaveis existem no emacs como Default)
    (setq calendar-week-start-day 0
          calendar-day-name-array ["Domingo" "Segunda" "Terca" "Quarta" 
                                   "Quinta" "Sexta" "Sabado"]
          calendar-month-name-array ["Janeiro" "Fevereiro" "Marco" "Abril"
                                     "Maio" "Junho" "Julho" "Agosto"
                                     "Setembro" "Outubro" "Novembro" "Dezembro"]
          calendar-day-abbrev-array ["Dom" "Seg" "Ter" "Qua" "Qui" "Sex" "Sab"])

;;; Open QR Code app on Android
    (defun dv-open-qr-app ()
      (interactive)
      (shell-command-to-string "am start --user 0 -a andrppoid.intent.action.MAIN -n com.teacapps.barcodescanner/net.qrbot.ui.main.MainActivity"))

;;; Open Google Keeps app on Android
    (defun dv-open-horario-app ()
      (interactive)
      (shell-command-to-string "am start --user 0 -a andrppoid.intent.action.MAIN -n com.google.android.keep/"))


;;; Attempting to play sound
   (defun dv-sound-test ()
      (interactive)
      ;; We can use Shell command M-! termux-media-player play <file>
      ;; To play/stop music, better send a message to *Messages* buffer to help
      (play-sound-file (concat v-home Repositories/DRYa/all/etc/example-sound.wav)))


;;; Creating blocks for source code
    (defun dv-code-block ()
      (interactive)
      (setq v_lang (read-string "Qual é a linguagem de programação? "))
      (insert "\n#+NAME: \n#+BEGIN_SRC " v_lang "\n\n#+END_SRC \n"))


;; testing buttons:
   (defun wh/help-hello-world ()
     (interactive)
     (with-help-window (help-buffer)
     (princ "foo_bar is a function.\n\nIt does stuff.")))

;; Note: How to Tangle init.org into init.el (from the terminal... to automate via bash
   ;; source: https://emacs.stackexchange.com/questions/27126/is-it-possible-to-org-bable-tangle-an-org-file-from-the-command-line 
   ;; emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "file-to-tangle.org")'


;;; Creating termux links (for example to images) inside emacs
    (defun dv-create-termux-link-w-termux-open ()
      (interactive)
      (setq v-link        (read-string "(To list Default Variables: V)\n(termux-open) link: "))
      (setq v-description (read-string "(termux-open) Description: "))
      (setq v-concat-link (concat "[[elisp:(progn (shell-command \"termux-open "
                                   v-link
                                   "\"))]["
                                   v-description
                                   "\]]"))
      (insert v-concat-link))

    ;; Adding a Global Key to it
       (global-set-key (kbd "C-c C-M l>") (lambda () (interactive) dv-create-termux-link-w-termux-open))

;;; Just testing if init file loads:
   ;; (set-background-color "grey")

;; Apply hiding of extra asteriscs '*' in all org-mode files
   (setq org-hide-leading-stars t)

   ;; Values for org-hide-leading-stars can be t or nil

   ;; If you want to apply a diferent setting for each individual file, you can paste on the document:
      ;; #+STARTUP: showstars
      ;; #+STARTUP: hidestars

;; Attempting to config org-agenda
   (when (eq system-type' windows-nt)  ;; If OS type is Windows, then echo out a message
         (setq org-agenda-files '("c:/Repositories/moedaz/all/")))
         ;; omni-log/all/org-agenda

   ;;(when (not (eq system-type' windows-nt))  ;; If OS is Linux or Android
   ;;      (setq org-agenda-files '(concat v-repos-center "/moedaz/all/")))



;;;; Configure which browser is set to defaulf on startup (according to OS)
     ;; If windows is found
        (when (eq system-type' windows-nt)  ;; If OS type is Windows, then echo out a message
            (message "dv: running on windows"))

     ;; If windows is not found (it must be either android or linux) the default web browser is changed
        ;; Now any link will be open with Linux based (or Android based) web browser
        (when (not (eq system-type' windows-nt))
              (message "dv: (1/2) windows not detected")
              (setq browse-url-browser-function 'browse-url-xdg-open)
              (message "dv: (2/2) default browser now is determined by either android or linux"))

;;;; Loading other lisp.el files into emacs
     ;; Note: We can load files from the terminal using 'emacs -l ../place-holder.el'

     ;; Loading other files.el and directories recursively
        ;; source: https://www.emacswiki.org/emacs/LoadPath

     ;; Loading upk.el
        ;; For Android
        (if (eq system-type 'gnu/linux)
            (load "/data/data/com.termux/files/home/.emacs.d/libraries/upk/upk.el")
            (message "Dv: Loaded upk.el on GNU/Linux"))

;;; Overriding 'C-c C-l' (org-insert-link) to include: termux-open-emacs-org-mode-images-on-android
    ;; uDev

;;; Creating an interactive function to open omni-log
    (defun om ()
      (interactive)      
      (switch-to-buffer (find-file-noselect "c:/Repositories/omni-log/multiplex.org")))

;;; Config minibuffer for vertical auto completion
      ;;(icomplete-vertical-mode 1)

;;; Creating a keybinding for org-agenda
    (global-set-key (kbd "C-x a") #'org-agenda)


(defun dv-f5 ()
  "Reloads the init.el file and the current buffer with command: M-x eval-buffer"
  (interactive)
  (message "dv: eval-buffer: configs reloaded")
  (eval-buffer (current-buffer)))
  
(defun td ()
  (interactive)
  (beginning-of-line)(insert "- [ ] "))

;; uDev: Quando houver links de imagens para abrir e so haja emacs para terminal no Termux, criar uma defun para fazer download da imagem para uma pasta tmp em abrir. Nao sera preciso apagar as imagens porque a DRYa ja apaga essa pasta temporario ao sair.

;; Load python language into org-mode
   ;; source: https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-python.html
   (org-babel-do-load-languages
    'org-babel-load-languages
    '((python . t)))


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


;;; Adding Melpa
    (add-to-list 'package-archives
                 '("melpa-stable" . "https://stable.melpa.org/packages/") t)

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
   ;; Config 'dired' to always hide details mode
;;      (use-package dired
;;        :hook (dired-mode . dired-hide-details-mode)
;;        :config
;;        ;; Colourful columns.
;;        (use-package diredfl
;;          :ensure t
;;          :config
;;          (diredfl-global-mode 1)))

;; Search Forward
   (defun f ()
     (interactive)
     (setq v_search (read-string "Qual é o texto para a FRENTE a procurar? "))
     (search-forward v_search)
     (message "Repete o comando com: 'C-x z'"))

;; Search Forward + org-cycle
   (defun ff ()
     (interactive)
     (setq v_search (read-string "Qual é o texto para a FRENTE a procurar? "))
     (search-forward v_search)
     (org-show-entry) ;; Uses TAB to open header, enabling better 'C-x z'
     (message "Repete o comando com: 'C-x z'"))

;; Search for upK ID entry
   ;; f-id     (next place where ID is mentioned)
   ;; f-id-o   (ID origin)

;; Search Backward
   (defun F ()
     (interactive)
     (setq v_search (read-string "Qual é o texto para TRAS a procurar? "))
     (search-backward v_search)
     (message "Repete o comando com: 'C-x z'"))

;;; Sound sample: Testing sound
    ;; uDev

;;; Maximize window on startup
    (add-to-list 'default-frame-alist '(fullscreen . maximized))

;;; Vim keybindings

    ;; Open lines
       (global-set-key (kbd "C-o") (lambda () (interactive)(end-of-line)(insert "\n")))
       (global-set-key (kbd "C-M-o") (lambda () (interactive)(beginning-of-line)(insert "\n")(previous-line)))

;; uDev: Create hotkey to mimic 'M-x' and then the vim key
   ;; like: 'C-.' to call vim commands
       (global-set-key (kbd "C-.") (lambda () (interactive) (vim-key-search)))

;; Vim keys interactive prompt
   (defun vim-key-search ()
     (interactive)
     (setq v-search-vim (read-string "Qual é o atalho do vim? "))
     (when (string-equal v-search-vim "G")(end-of-buffer))
     (when (string-equal v-search-vim "gg")(beginning-of-buffer))
     (when (string-equal v-search-vim "zz")(zz)))

;; Functions like vim (but needs always to call M-x)
   (defun zz ()
     (interactive)
     (save-buffer)
     (message "Dv: Buffer saved")
     (sleep-for 2)
     (kill-emacs))

   (defun w ()
     (interactive)
     (save-buffer)
     (message "Dv: Buffer Saved"))

   (defun yy ()
     ;; C-x y
     (interactive)
     "Copies the entire line in 2 ways: to kill-ring and to variable: myVar

      Source: http://xahlee.info/emacs/emacs/elisp_all_about_lines.html"
     (setq myLine
            (buffer-substring-no-properties
            (line-beginning-position)
            (line-end-position)))

     (beginning-of-line)(kill-line)(yank)
     (message "yy: The entire line was copied (to var: myLine and to kill-ring)"))

         (global-set-key "\C-xy" 'yy)

   (defun dd ()
     (interactive)
     (beginning-of-line)(kill-line)(delete-char 1))

   (defun p ()
     (interactive)
     (end-of-line)(insert "\n")(yank)
     (message "p: Pasted one line below"))

   (defun P ()
     (interactive)
     (beginning-of-line)(insert "\n")(previous-line)(yank)
     (message "p: Pasted one line above"))

(defun view ()
  "Shortcut for (org-overview)"
  (interactive)
  (org-overview))

(defun dv-truncate-lines-on ()
  (interactive)
  (message "Dv: Set toggle-truncate-lines to on")
  (toggle-truncate-lines 1))

(defun dv-truncate-lines-off ()
  (interactive)
  (message "Dv: Set toggle-truncate-lines to off")
  (toggle-truncate-lines -1))

(defun wrap ()
  (interactive)
  (message "Dv: Toggle text wrap on")
  (visual-line-mode t))
     
(defun nowrap ()
  (interactive)
  (message "Dv: Toggle text wrap off")
  (visual-line-mode -1))

(defun numbers ()
  (interactive)
  (global-display-line-numbers-mode)
  (message "Dv: toggled line numbers mode globaly"))
    

(defun copy-target-number-from-current-line-to-kill-ring ()
  ;; Function used at: dv-add-id-line as 'copy'
  ;; Suestion: ID: <<ID-18012024-113454-482622000>> (help / copy)
  ;;    (global-set-key (kbd "C-?") (lambda () (interactive) )))
  ;; [[elisp:(funcall-interactively 'occur ";;;; ")][click here]]
  ;;  (insert "[[elisp:(funcall-interactively 'copy-target-number-from-current-line-to-kill-ring][(copy)]]"))
  (interactive)
  (save-excursion
  (beginning-of-line)
  (search-forward "<<")
  (setq v-beg (point))
  (cua-set-mark)
  (search-forward ">>")
  (forward-char -2)
  (setq v-end (point))
  (kill-ring-save v-beg v-end)))

(defun dv-add-id-line ()
  "Adds a line of text with a unique number in order to facilitate internal links. Mix of text with: ID- then adds day number, then month number, then year number, then hiphen '-', then hour number from (0-24), then, minute number, then seconds number, then hiphen '-', then nanoseconds in order for 2 functions dv-add-id-line to be different when the user wants 2 ain the same second
  See format possibilities here: https://www.gnu.org/software/emacs/manual/html_node/elisp/Time-Parsing.html"
  (interactive)
  (setq v_id_time (format-time-string "ID-%d%m%Y-%k%M%S-%N"))

   ;; Choose 1 of both:
        (insert "ID: <<" v_id_time ">> ( ")
        ;;(insert "ID-with-emacs-target { <<" v_id_time ">> } (origin)")

  (insert "[[elisp:(message \"\\n\\nEste ID é onde varios links vem parar, é um numero unico que outros links procuram\")][help]]")
  (insert " / ")
  (insert "[[elisp:(funcall-interactively 'copy-target-number-from-current-line-to-kill-ring)][copy]]")
  (insert " ) "))

(defun date ()
  (interactive)
  (setq v-time-1 (format-time-string "(Dia %d "))  ;; -------------------------------------- Part 1 of the time string to be printed
  (dv-translate-weak-days) ;; -------‐---‐-------------------------------------------------- Part 2 of the time string to be printed
  (setq v-time-3 (format-time-string ")(Mês %m %b)(Ano %Y)(%kh:%Mmin:%Ss)")) ;; ------------ Part 3 of the time string to be printed
  ;;(setq v_id_time (format-time-string "(Dia %d %a)(Mês %m %b)(Ano %Y)(%kh:%Mmin:%Ss)")) ;; Usada se nao houver traducao
  (message (concat "Data atual: " v-time-1 v-dia v-time-3)))
   
;; uDev: add package elisp-bug-hunter (https://github.com/Malabarba/elisp-bug-hunter)

(defun u ()
   "When opening dailyLog for UPK, prepare visialization"
   (interactive)
   (org-overview)
   (end-of-buffer)
   (org-reveal)
   (visual-line-mode)
   ;;(global-set-key "\C-x\C-a ." 'u)
   )

(defun upk-mode ()
  "Faz o mesmo que a função 'u' que costuma ser chamada com M-x u"
  (interactive)
  (u))

(defun dv-insert-text-with-checkbox ()
  "Adding a checkbox to your next text"
  (interactive)
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






(defun dv-translate-weak-days ()
  "Serve para traduzir od nomes dos dias da semana de EN para PT
Utilizado por exemplo na Fx: dv-insert-new-day-upk. 

No termux os nomes da semana costumam estar em EN e esta é a config que traduz para PT mais facil

Esta Fx lê o dia da semsna em EN e coloca na variavel %0
Depois, se %0 for igual a Mon, entao a variavel %1 sera definida como Seg

Por fim, na Fx dv-insert-new-day-upk a variavel %a será substituida por %1

Usado nas Fx:
 - dv-insert-new-day-upk"

(setq v-day (message (format-time-string "%a")))

;; Quando é usado o Termux
   (when (string-equal v-day "Mon")(setq v-dia "Seg"))
   (when (string-equal v-day "Tue")(setq v-dia "Ter"))
   (when (string-equal v-day "Wed")(setq v-dia "Qua"))
   (when (string-equal v-day "Thu")(setq v-dia "Qui"))
   (when (string-equal v-day "Fri")(setq v-dia "Sex"))
   (when (string-equal v-day "Sat")(setq v-dia "Sab"))
   (when (string-equal v-day "Sun")(setq v-dia "Dom"))

;; Quando é usado o Emacs Gui no Windows
   (when (string-equal v-day "seg")(setq v-dia "Seg"))
   (when (string-equal v-day "ter")(setq v-dia "Ter"))
   (when (string-equal v-day "qua")(setq v-dia "Qua"))
   (when (string-equal v-day "qui")(setq v-dia "Qui"))
   (when (string-equal v-day "sex")(setq v-dia "Sex"))
   (when (string-equal v-day "sab")(setq v-dia "Sab"))
   (when (string-equal v-day "sáb")(setq v-dia "Sab"))
   (when (string-equal v-day "dom")(setq v-dia "Dom")))





;; Toggle stuff for focus
   (defun dv-focus-mode-t ()
      ;; uDev: falta a funcao toggle... se a variavel estiver t passa a -1 e vice-versa
      (interactive)
      (tool-bar-mode -1)  ;; complementar com (tool-bar-mode t)
      (menu-bar-mode -1)) ;; complementar com (menu-bar-mode t)

   (defun dv-focus-mode-nil ()
      ;; uDev: falta a funcao toggle... se a variavel estiver t passa a -1 e vice-versa
      (interactive)
      (tool-bar-mode t)  
      (menu-bar-mode t)) 


;; Funtion to allow TAB to print n empty spaces
(defun tab-inserting-text ()
   (interactive)
   (insert "   "))
   (global-set-key (kbd "C-<tab>") 'tab-inserting-text)
   ;; Alternative, set the var to n number of spaces:
      ;; Source: https://www.emacswiki.org/emacs/IndentationBasics
      ;; (setq tab-width 3) ; or any other preferred value
  








(defun dv-detetar-dia-correto-no-inicio-de-turnos-N ()
  "Esta Fx é parte fundamental da Fx dv-insert-new-day-upk e serve só para os turnos N.
Quando está a imiciar mais um turno N que começa as 23h do dia anterior, é possivel chamar a Fx dv-insert-new-day-upk e essa Fx inserir a data incorretamente.

Antigamente o turno N começava as 00h00 e cacabava as 09h00 do mesmo dia. Agora comeca uma hora antes as 23h00 e acaba as 08h00.
Para que as 23h00 seja possivel inserir a data correta correspondete ao dia seguite, será aplicado esta Fx.

Caso o turno N algum dia volte ao normal das 00h00 as 09h00, entao toda esta Fx poder ser apagada e substituida por:
  (insert (format-time-string \"<%Y-%m-%d \") v-dia \"> \")

Por enquanto, se esta em vigor das 23h00 as 08h00, 
sera acrescentado +1 ao numero do dia; +1 ao dia da semana; +1 ao mes, se necessario; +1 ao ano, se necessario"

  ;; Fx Original: (insert (format-time-string "<%Y-%m-%d ") v-dia "> ")  ;; A variavel v-dia já substituir %a e contempla a tradução direta de EN > PT
 
  (setq v-hour-num (format-time-string "%H")) ;; Preencher a variavel v-hour-num com a hora atual: %H
  ;;(setq v-dia-num  (format-time-string "%d")) ;; Preencher a variavel v-hour-num com o dia atual:  %d
  ;;(setq v-mes-num  (format-time-string "%m")) ;; Preencher a variavel v-hour-num com o mes atual:  %m
  ;;(setq v-ano-num  (format-time-string "%Y")) ;; Preencher a variavel v-hour-num com o ano atual:  %Y

  ;; Set same variable 2x for readable code
     ;; First time: 
        ;;(setq v-next-dia-num  (atual + 1)) 
        ;;(setq v-next-dia-text (v-dia + 1))    
        ;;(setq v-next-mes-num  (atual + 1))   
        ;;(setq v-next-ano-num  (atual + 1))  

     ;; Second time: 
        ;;(setq dd      v-next-dia-num  )
        ;;(setq v-dia-2 v-next-dia-text )
        ;;(setq mm      v-next-mes-num  )
        ;;(setq YY      v-next-ano-num  )

     ;; uDev: descobrir elisp com (org-time-stamp-up-day) equivalente, para se evitar toda esta confusao de soma de variaveis



  ;; Quando a Fx do Turno N esta incorretamente a ser chamada antes das 24h:
     ;; uDev: Precisa detetar v-dia certo e subtrair v-hour-num
     ;;       Precisa tambem detetar se é fim do mes, para inserir corretamente que o turno será no prox mes
     (when (and (or (string-equal v-hour-num "22")
                    (string-equal v-hour-num "23"))
                (string-equal v_turno "N"))
           (progn (insert (format-time-string "<%Y-%m-%d ") "(+1 Dia)" v-dia "> ")  ;; uDev: clue to fix this function: (org-insert-time-stamp (current-time) +1d )
                  (message "Foi inserido uma data diferente, corrija se necessario")))

  ;; Quando a Fx do Turno N esta corretamente a ser chamada apos as 24h:
     ;; Ou quando é chamada em turnos B e C
     (when (not (and (or (string-equal v-hour-num "22")
                         (string-equal v-hour-num "23"))
                     (string-equal v_turno "N")))
           (insert (format-time-string "<%Y-%m-%d ") v-dia "> ")) 

  )












(defun dv-insert-new-day-upk () 
  "Insere no final do buffer mais 1 Header que indica qual o dia e turno a que os proximos textos correspondem

uDev: <inserir-aqui: todas as Fx das quais esta Fx depende>"
  (interactive)

  ;; Prompting user for values
     (setq v_turno (read-string "Turno do dia de hoje: "))

  ;; uDev:
     ;; Se este novo dia que esta a ser introduzido por o primeiro dia do mes, entao: calcular quantos dias de trabalho houve no mes anterior e quantas horas de trabalho houve no dia anterior
     ;; Se for o ultimo dia do mes, pedir pra tirar foto a folha de ponto da upk
     ;; Se for fim de semana + Turno B, entao: adicionar Reuniao do bom dia, rotina de avac, rotina de legionela
     ;; Detetar feriados e incluir na Aba Resumo que equivale a mais X hora

  ;; Criacao do Header principal
     ;; Criar variaveis com a traducao de EN para PT dos dias da semana (antes de serem usados)
        (dv-translate-weak-days) ;; Se existir alguma variavle do emacs que faca esta Fx, entao esta Fx criada manualmente torna-se inutil

     ;; Introdução de Header, independentemente se é Folga ou Turno
        (end-of-buffer) (insert "\n") (insert "* Dia ")

     ;; Detetar se a Fx está a ser chamada num turno N antes da hora (porque as 22h e as 23h iriam introduzir uma data errada, iriam introduzir a data do turno anterior
        ;; Usar apenas 1 destas 3 linhas de codigo (nunca as mais que 1 em simultaneo):
           ;;(insert (format-time-string "<%Y-%m-%d %a> "))
           ;;(insert (format-time-string "<%Y-%m-%d ") v-dia "> ")  
           (dv-detetar-dia-correto-no-inicio-de-turnos-N)

     ;; Preenchero com o texto correspondente ao turno
        (insert "(Turno: ") (insert v_turno) (insert ")") ;; uDev: create a holliday day list and present it here

  ;; Quando é dia de turno (B, C, N) excluindo (Fg e outros):
     (when (or (string-equal v_turno "N") (string-equal v_turno "B") (string-equal v_turno "C"))
         
         ;; Se nao é folga, perguntar quem rendi
            (setq v_rendi (read-string "Quem rendi: "))

         ;; Pre-Requisitos + PROPERTIES 
            (insert "\n\n- [ ] () Pre-Requisitos\n")
            (insert ":PROPERTIES:\n")
            (insert "- [ ] Passar o dedo/impressão digital para entrada no sistema\n")

         ;; Quando o turno é especificamente "N", adicionar: 
            (when (string-equal v_turno "N")
                  (insert "- [ ] Entregar a folha de ocorrencias do turno anterior\n")
                  (insert "- [ ] Colocar baterias a carregar\n"))

         ;; Adicionar mais texto neutro (Inserir END dos Pre-requisitos):
            (insert "- Colega do turno anterior: ") (insert v_rendi) (insert "\n")
            (insert ":END:\n")

         ;; Se o turno for "B", inserir rotinas:
            (when (string-equal v_turno "B")
                  (rotina-manha))
             
         ;; Se o turno for "B" ao fim-de-semana, inserir tambem rotinas AVAC e legionela:
            (when (and (string-equal v_turno "B")
                       (or (string-equal v-dia "Sab")(string-equal v-dia "Dom")))
                  (rotina-avac)
                  (rotina-legionela)
                  (rotina-reuniao-bom-dia))
             
         ;; Inserir mais texto neutro (Pos-requisitos + PROPERTIES)
            (insert "\n- [ ] Pos-Requisitos ")
            (insert "\n" ":PROPERTIES:\n")
            (insert "\n- [ ] Escrever folha de ocorrencias ")
            (insert "\n- [ ] Tirar foto à folha de ocorrencias ")(dv-del-line-link)

         ;; Se o turno for "C" (adicionar texto aos Pos-Requisitos)
            (when (string-equal v_turno "C")
                  (insert "\n- [ ] Entregar a folha de ocorrencias\n"))

         ;; Inserir mais texto neutro (Pos-requisitos + PROPERTIES)
            (insert "\n- [ ] Passar o dedo/impressão digital para saida no sistema\n")
               ;; uDev: Se for dia 5, 6, 7, preencher folhas de ponto upk 
            (insert "\n- [ ] Passagem de Serviço ")
            (insert (format-time-string "<%Y-%m-%d %a>")) ;; uDev: ja existe um modelo melhor de data do que o standard 
            (insert "{ \n")
            (insert "Ao: \n  -\n}\n")
            (insert ":END:\n\n")
            (insert "- Resumo\n" ":PROPERTIES:\n")
            (insert "- Total Horas: \n")
               ;; uDev: Se for dia 1, calcular o humero de horas do mes anterior
            (insert ":END:\n\n"))

         ;; Fechar convenientemente o texto entre :PROPERTIES: e :END: de todo o turno
            (u)

   ;; Quando é dia de folga
      (when (or (string-equal v_turno "Fg")
                (string-equal v_turno "fg"))
                (progn (end-of-line)(insert "\n")
                       (message "Dv: Não esquecer de verificar a data deste dia de folga")))  )


;;; dv- properties/end/properties-end
   (defun dv-add-properties ()
     (interactive)
     "Creates a new empty line below and adds the text: :PROPERTIES:"
     (end-of-line)(insert "\n:PROPERTIES:"))

   (defun dv-add-end ()
     (interactive)
     "Creates a new empty line below and adds the text: :END:"
     (end-of-line)(insert "\n:END:"))

   (defun dv-add-properties-with-end ()
     (interactive)
     "Escreve um titulo. Apos o titulo, sem mudar de linha, invoca esta funcao e ela abre :PROPERTIES: :END:"
     (end-of-line)(insert "\n:PROPERTIES:\n\n:END:\n")(previous-line)(previous-line))

(defun oj ()
  (interactive)
  (beginning-of-line)(insert "OT inserida dia ")
  ;;
  ;;
  ;; Replaced:
  ;;  (insert "<2023-06-02 sex>"))
  ;;
  ;; for:
  ;;  (insert "<")
  ;;  (format-time-string "%Y-%m-%d %a")
  ;;  (insert ">"))
  ;;
  (insert "<")
  (insert (format-time-string "%Y-%m-%d %a"))
  (insert ">"))

(defun rotina-manha ()
   (interactive)
   (insert "\n- [ ] () Rotina Diária do Turno da Manhã
:PROPERTIES:
Descricao { 
}

Notas { 
}

(Mike 1 faz rotinas da manhã so aos dias: Ter, Qui, Sab, Dom, Feriados)
[[ID-20012024-110841-884999000][[REL\]]] [[Procedimentos: (Rotina) diaria do turno da manha][procedimentos]] 

:END:\n"))

(defun rotina-avac ()
   (interactive)
   (insert "\n- [ ] () Rotina Diária de AVAC
:PROPERTIES:
Descricao { 
}

Notas { 
}

(Mike 1 faz rotinas da manhã so aos dias: Sab, Dom, Feriados)
[[ID-20012024-102932-938068000][[REL]​]] [[Procedimentos: (Rotina) diaria de AVAC][procedimentos]] 

:END:\n"))

(defun rotina-reuniao-bom-dia ()
   (interactive)
   (insert "\n- [ ] () Reuniao do Bom dia
:PROPERTIES:

OT {
   :: 
   :: Tipo       |       :: (reu) Preparação trabalhos, reuniões de manutenção, etc - Técnico
   :: Titulo:    | [[elisp:(copy-text-from-double-colon-to-double-colon)][cp]] [[elisp:(paste-between-double-colon-and-double-colon)][cl]] :: Reunião do bom dia
   :: Descrição: | [[elisp:(copy-text-from-double-colon-to-double-colon)][cp]] [[elisp:(paste-between-double-colon-and-double-colon)][cl]] :: No inicio do turno da manhã
   :: Notas:     | [[elisp:(copy-text-from-double-colon-to-double-colon)][cp]] [[elisp:(paste-between-double-colon-and-double-colon)][cl]] :: 
   :: 
}

:END:\n"))

(defun rotina-legionela ()
   (interactive)
   (insert "\n- [ ] () Rotina Diária de Legionela
:PROPERTIES:
Descricao { 
}

Temp. Prestadores: 
Temp. Lojistas: 
Temp. Kitchen 1: 
Temp. Kitchen 2: 
Cont. Ag.Torres: 

Notas { 
}

[[ID-20012024-110255-472907000][[REL]​]] [[Procedimentos: (Rotina) diaria de Legionela][procedimentos]] 

:END:\n"))

(defun dv-transfer-ot ()
   "Usa as funçoes 'oj' e 'dv-add-id-line' 
    
tambem usa dv-transfer-ot-ID-link-uninteractive que extrai da linha atual o ID, sobe ao inicio do buffer e pesquisa esse ID para a frente"
   
   (interactive)

   ;; Copy current entry line
      (beginning-of-line) (setq v-beg (point))
      (end-of-line)       (setq v-end (point))
      (kill-ring-save v-beg v-end)
      (setq v-entry-result (current-kill 0 t))

   ;; Expandir :PROPERTIES:
      (search-forward ":PROPERTIES:") 
      ;; (org-show-subtree)

   ;; Inserir ID line
      (end-of-line)(insert "\n")(dv-add-id-line)(insert "\n")
      (previous-line)(previous-line)

   ;; Copy original ID to a variable
      (search-forward "<<")(setq v-beg (point))
      (search-forward ">>")(backward-char 2)(setq v-end (point))
      (kill-ring-save v-beg v-end)
      (setq v-id-result (current-kill 0 t))

   ;; Copy dia
      (save-excursion
         (search-backward "* Dia <")(forward-char 6)(setq v-beg (point))
         (search-forward ">")(setq v-end (point))
         (kill-ring-save v-beg v-end)
         (setq v-dia-result (current-kill 0 t)))

   ;; Enviar ID para a segunda janela
      ;; O ideal é o cursor na segunda janela ja estar posicionado corretamente
      (other-window 1)
      (insert v-entry-result)
      (insert "  ::  ")
      (insert v-dia-result)
      (insert "  ::  ")
      (insert v-id-result)
      (insert "  ::  ")
      ;; uDev: inserir "GO" para a entry anterior
      (insert "[[elisp:(dv-transfer-ot-ID-link-uninteractive)][GO]]")
      (insert "\n")

   ;; Removing extra data added to: Window 1 > TITLE > date
      (other-window 1) (beginning-of-line)

      ;; Marcar [ ] com um X ficando [X]
         (search-backward "- [")
         (org-ctrl-c-ctrl-c)
         )
  ;; end-of-el-function: dv-transfer-ot

(defun dv-transfer-ot-ID-link-uninteractive ()
  "Funcao que dá apoio a funcao dv-transfer-ot (não precisa de ser interativa porque serve apenas para facilitar a leitura do codigo"

  ;; Copy ID
     (save-excursion
        (beginning-of-line)
        (search-forward "::  ID")(backward-char 2)(setq v-beg (point))
        (search-forward "::")(backward-char 4)(setq v-end (point))
        (kill-ring-save v-beg v-end)
        (setq v-id-result (current-kill 0 t))
        ;; for debug purpouse: (message (concat "Current id is: " v-id-result))
     )

   ;; Search last ID result in a vertical split window
        (split-window-vertically)
        (beginning-of-buffer)
        (search-forward v-id-result)
        (org-reveal)
        (beginning-of-line))





(defun dwiki ()
   (interactive)
   (setq v_page (read-string "Do que precisa de saber? "))
   (when (string-equal v_page "location")
         (message "Showing cheat sheet about emacs: ")  
         
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


;;-----------------------------------------
;; linhas sobre o siigo

;; uDev: Algumas abrev tem espcos, por esse motivo, talvez seja melhor criar so 1 funcao que peça interativamente o nome da funcao desejada. Pode incluir read-completion

(defun dv-print-siigo-ot-type ()
  (interactive)
  "Abre um buffer paralelo ao buffer atual (semelhante à hotkey C-x 2) e abre lá um ficheiro de texto com todos os tipos de ot do siigo. Esse documnto que é aberto tem também links de atalho programados em elisp que ao clicar, fazem preencher o buffer anterior com o texto desejado"

   ;; uDev: use either (find-file-noselect) or (find-file-read-only)   

   ;; If running on windows
   (when (eq system-type 'windows-nt)
      (switch-to-buffer-other-window (find-file-noselect "c:/wsl-dv/Repositories/upK/all/Documentos/tipos-de-ots-no-siigo.org")))

   ;; If running on Android
   (when (eq system-type 'gnu/linux)
      (switch-to-buffer-other-window (find-file-noselect "~/Repositories/upK/all/Documentos/tipos-de-ots-no-siigo.org"))))

;;; Apoio ao ensaio semanal das bombas de incendio da central de bombagem
(defun dv-ensaio-semanal-CBI ()
  (interactive)
  "Abre um buffer paralelo ao buffer atual (semelhante à hotkey C-x 2) e abre lá um ficheiro de texto com todos os tipos de info necessario para fazer o arranque as bombas de incendio"

   ;; If running on windows
   (when (eq system-type 'windows-nt)
      (switch-to-buffer-other-window (find-file-noselect "c:/wsl-dv/Repositories/upK/all/Documentos/apoio-ao-ensaio-semanal-bombas-de-incendio.org")))

   ;; If running on Android
   (when (eq system-type 'gnu/linux)
      (switch-to-buffer-other-window (find-file-noselect "~/Repositories/upK/all/Documentos/apoio-ao-ensaio-semanal-bombas-de-incendio.org"))))




(defun gt ()
    "Introduz texto automaticamente. Escreve texto tal como é apresentado no siigo"
  (interactive)
  (search-backward "Tipo: ")(end-of-line)
  (insert "(gt) Comando de iluminação/AVAC através da GTC  - Técnico"))


(defun reu ()
  (interactive)
    "Introduz texto automaticamente. Escreve texto tal como é apresentado no siigo"
  (search-backward "Tipo: ")(end-of-line)
  (insert "(reu) Preparação trabalhos, reuniões de manutenção, etc - Técnico"))

(defun e-em ()
  (interactive)
    "Introduz texto automaticamente. Escreve texto tal como é apresentado no siigo"
  (search-backward "Tipo: ")(end-of-line)
  (insert "(e-em) Apoio de empresas exteriores"))


;; fim das linhas sobre o siigo
;;-------------------------------------------------------------------


;; Improving the Undo Redo hotkeys:
   (global-set-key (kbd "C-x M-u") 'undo-redo)
   (global-set-key (kbd "C-x u") 'undo)

;; Fill with ? or X the previous checkbox
   (global-set-key (kbd "C-?") (lambda () (interactive) (save-excursion (search-backward "- [")(forward-char 3)(delete-char 1)(insert "?"))))
   (global-set-key (kbd "C-M-?") (lambda () (interactive) (save-excursion (search-backward "- [")(forward-char 3)(delete-char 1)(insert "X"))))

;; Open/Close previous block of :PROPERTIES: + :END:
   (global-set-key (kbd "C-«") (lambda () (interactive) (end-of-line)(search-backward ":PROPERTIES:")(org-cycle))) 

;; From checkbox [ ] to [-] or [X] or [?] 
   (setq increm-num 1)  ;; Number to be used to define the character to be pasted

   (global-set-key (kbd "C-c c")
   		   (lambda () (interactive)
		      (save-excursion
		       ;; Replaces an empty checkbox [ ] with a checkbox with an "-" like [-]
		       (beginning-of-line)
		       (search-forward "]")
		       (backward-char 2)
		       (delete-char 1)
             (when (eq increm-num 4) (progn (insert "X")(setq increm-num 5)))
             (when (eq increm-num 3) (progn (insert " ")(setq increm-num 4)))
             (when (eq increm-num 2) (progn (insert "?")(setq increm-num 3)))
             (when (eq increm-num 1) (progn (insert "-")(setq increm-num 2)))
             (when (eq increm-num 5) (setq increm-num 1)))))


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
  (message "To find init file in emacs: C-h v user-init-file"))














(defun dv-del-line-link ()
  (interactive)
  (insert "[[elisp:(progn (beginning-of-line)(kill-line)(kill-line))][(del)]] "))
  



(defun dv-new-ENTRY-general ()
  "Both functions dv-insert-new-Entry-upk and dv-insert-new-entry-upk have lines of code in common, to keep the code readable, this function gathers all that is general. This function does not need to be interactive"
  (setq v_tarefa (read-string "Introduz o Titulo da nova tarefa: "))
  (setq v_time (read-string "Quanto tempo demorou? "))
  (end-of-line)
  (insert "\n")
  (insert "- [ ] (")
  (insert v_time)
  (insert ") ")
  (insert v_tarefa)
  (insert "\n")

  ;; Add field "Descricao"
     (insert ":PROPERTIES:\nDescricao ")
     (insert "\{ \n\}\n\n")

  ;; Add field "Notas"
     ;; Choose between the next 2 lines either "Notas" just text or "Notas" with an elisp link. Comment out the one you do not want for now
        (insert "Notas")
        ;;(insert "[[elisp:(progn (beginning-of-line)(kill-line)(kill-line)(kill-line)(dv-add-ot-just-text))][Notas]]")

     (insert " \{ \n\}\n\n")

  ;; Adding a function to create a new dv-ot-just-text
     (dv-del-line-link)
     (insert "[[elisp:(progn (beginning-of-line)(kill-line)(kill-line)(dv-add-ot-just-text))][dv-add-ot-just-text]] \n")

  (insert ":END:\n")
  (previous-line)(previous-line)(previous-line)(previous-line)
  (previous-line)(previous-line)(previous-line)(previous-line)(end-of-line)
  ;; After navigating 2 lines above, then: uDev: press TAB to close properties
  (message "Dv: Text inserted into current buffer and current cursor position"))


(defun dv-insert-new-entry-upk ()
   ;; uDev: Criar sempre um ID para se poder fazer links internos no ficheiro facilmente
   "This function creates an entry where your cursor is placed Inserts text on current buffer at current cursor position" 
  (interactive)
  (dv-new-ENTRY-general))


(defun dv-insert-new-Entry-upk ()
  "This function creates an entry not anywhere, but in the bottom of the file"
  ;; uDev: Criar sempre um ID para se poder fazer links internos no ficheiro facilmente
  (interactive)
  (u)
  (search-backward "Pos-Requisitos")
  (previous-line)

  (dv-new-ENTRY-general))










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




(defun dv-just-crawl ()
  (interactive)
  (end-of-line)(insert "\n\n#+BEGIN_SRC python\n\n")
  (insert "v_titulo = \"\"")
  (insert "\nv_desc = \"\"")
  (insert "\n\n#+END_SRC"))




;;; Preparing functions for dv-add-ot-just-text
(defun paste-between-double-colon-and-double-colon ()
   "Used to paste between :: and ::"
   (setq v-original-clipboard (current-kill 0 t))
   (setq v-point (point))
   (search-forward "::")(forward-char 1)(setq v-beg (point))
   (search-forward "::")(backward-char 6)(setq v-end (point))
   (delete-region v-beg v-end) 
   (insert v-original-clipboard)
   (goto-char v-point))
 
(defun copy-text-from-double-colon-to-double-colon ()
   "Used to copy between :: and ::"
   (setq v-point (point))
   (search-forward "::")(forward-char 1)(setq v-beg (point))
   (search-forward "::")(backward-char 6)(setq v-end (point))
   (kill-ring-save v-beg v-end)
   (setq v-result (current-kill 0 t))
   (goto-char v-point))

(defun paste-between-double-colon-and-closed-curly-bracket ()
   "Used to paste between :: and }"
   (setq v-original-clipboard (current-kill 0 t))
   (setq v-point (point))
   (search-forward "::")(forward-char 1)(setq v-beg (point))
   (search-forward "}")(backward-char 2)(setq v-end (point))
   (delete-region v-beg v-end) 
   (insert v-original-clipboard)
   ;;(goto-char v-point)
   )
 
(defun copy-text-from-double-colon-to-closed-curly-bracket ()
   "Used to copy between :: and }"
   (setq v-point (point))
   (search-forward "::")(forward-char 1)(setq v-beg (point))
   (search-forward "}")(backward-char 2)(setq v-end (point))
   (kill-ring-save v-beg v-end)
   (setq v-result (current-kill 0 t))
   (goto-char v-point))

(defun insert-literaly-tipo () 
        (insert "[[elisp:(dv-print-siigo-ot-type)][Tipo:]]      | "))

(defun buttons-for-dv-add-ot-just-text-only-for-tipo ()
  "Used to remove text after :: and to paste between :: and ::
This is used only for \"tipo:\""
  (insert "[[elisp:(progn (search-forward \":: \")(kill-line))][rm]] [[elisp:(paste-between-double-colon-and-double-colon)][cl]] [[elisp:(funcall-interactively '1-button-insert-tipo-by-interactive-fx)][fx]] :: \n"))
(defun 2-buttons-for-dv-add-ot-just-text ()
  "Used to copy/paste between :: and ::"
  (insert "[[elisp:(copy-text-from-double-colon-to-double-colon)][cp]] [[elisp:(paste-between-double-colon-and-double-colon)][cl]]    :: \n"))

(defun 4-buttons-for-dv-add-ot-just-text ()
  "Used to copy/paste between :: and }"
  (insert "[[elisp:(copy-text-from-double-colon-to-closed-curly-bracket)][cp]] [[elisp:(paste-between-double-colon-and-closed-curly-bracket)][cl]] :: \n"))

(defun f-more-options-dv-add-ot-just-text ()
  (insert "[[elisp:(message \"More options are uDev\")][_+_]]"))


(defun 1-button-insert-tipo-by-interactive-fx ()
  "Um dos botoes relativos à linha TIPO, será aquela interactive fx que não precisa de motor de busca"
  (interactive)
  (setq v-ans (read-string "uDev: inserir abrv do tipo de ot: "))
    ;; exemplo: 'M-x temp' Insere a texto '(temp) Apoio a stands temporários - Produto'
    (when (string-equal v-ans "temp")(progn (end-of-line)(insert "(temp) Apoio a stands temporários - Produto")))
    (message "\n\nnot ready yet\n\nOnly fx 'temp' is ready"))




(defun dv-add-ot-just-text ()
  (interactive)
   "Serve para adicionar info necessária para fechar uma OT com info dentro da propria ENTRY"
  ;;(f-more-options-dv-add-ot-just-text)
  (insert "\nOT {\n")
  ;; Note: The folowing text has a prefix :: that is used for detection of the beginnig of next line
     
     (insert "   :: \n")

     ;; For Tipo, choose either with or without links:
        ;;(insert "   :: Tipo: | ")(2-buttons-for-dv-add-ot-just-text)
        (insert "   :: ")(insert-literaly-tipo)(buttons-for-dv-add-ot-just-text-only-for-tipo )

     ;; For the title, choose either with or without links:
        ;;(insert "   :: Titulo:    | ")(2-buttons-for-dv-add-ot-just-text)
        (insert "   :: Titulo:    | ")(2-buttons-for-dv-add-ot-just-text)

     (insert "   :: Descrição: | ")(2-buttons-for-dv-add-ot-just-text)
     (insert "   :: Notas:     | ")(2-buttons-for-dv-add-ot-just-text)
     (insert "   :: Fotos (S/N)| ")(2-buttons-for-dv-add-ot-just-text)

     ;; Detection for the next text must be } instead of -|
     (insert "   :: Materiais: | ")
     ;; For Materials we can choose a pair of buttons or a link for [REL]
        ;;(4-buttons-for-dv-add-ot-just-text) ;; Option 1
        (insert "[[target-materiais-do-shopping][[REL]​]] :: \n") ;; Option 2

     (insert "   :: \n")

  (insert "}\n")
  (insert "[[elisp:(progn (beginning-of-line)(kill-line)(kill-line))][del:]] ")
  (insert "[[elisp:(dv-just-crawl)][Create Python Webcrawler]] \n\n")

  ;; Placing the cursor where it is faster com repeat the same command
     (previous-line)
     (previous-line)
     (beginning-of-line)
  ) 

(defun dv-add-ot-number ()
  (interactive)
  "Serve para juntar varios tempos de varias entries numa só OT"
  (setq v_ot_num (read-string "Qual é a ordem numérica desta OT? "))
  (setq v_ot_sub (read-string "Qual é o assunto desta OT? "))
  (insert "\n- [ ] << OT " v_ot_num " >> " v_ot_sub "\n")
  (insert ":PROPERTIES:\n")
  (dv-add-id-line)
  (insert "\n\n" ":: " "[[elisp:(dv-print-siigo-ot-type)][Tipo]]" "      :: " )

  (insert "\n:: ")
  (insert "Titulo    :: \n")
  (insert ":: Descriçao :: \n\n")
  (insert "Tempos { \n\n\n\n}\n\n") 
  (insert "Notas { \n}\n\n")
  (insert "Materiais { \n}\n\n")
  (insert "Fotos (s/n): \n\n")
  (insert ":END:\n")
  (search-backward ":PROPERTIES:")(beginning-of-line))

;; Junt mentioning at the echo area the path to WSL home dir
;; uDev: something is wrong when the text is displayed
(defun dv-wsl-home-list ()
   (interactive)
   (message \\wsl$\Ubuntu-22.04\home\dv-wsl-ubuntu\.tmp))



;; (global-display-line-numbers-mode)

;; IRC config
   ;; uDev: setup a notification sound for ERC whenever a message arives
   ;; uDev: Create a new chatroom, make it private if possible
   ;; uDev: absorb this info: source: https://www.youtube.com/watch?v=UCIp2mY5Qyk&t=423s (at 7:00)
       (defun dv-erc ()
         (interactive)
         ;; Set our nickname & real-name as constant variables
            (setq erc-nick "Darve"    
                  erc-user-full-name "Seiva D'Arve") ; Our /whois name

         ;; Define a function to connect to a server
            (erc :server "irc.libera.chat"
                 :port   "6667"))

   ;; Another usefull function:
      (defun my-irc ()
         "Start to waste time on IRC with ERC."
         (interactive)
         (select-frame (make-frame '((name . "Emacs IRC")
                       (minibuffer . t))))
         (call-interactively 'erc))


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

;; Calculadoras: 
   (defun dv-calculate-hipoclorito ()
     (interactive)
     "Para 1 copo de hipoclorito, 9 de agua"
     (setq v-opc (read-string "Info do procedimento: Diluir o produto a 10% de concentracao (em agua) \n\nOpcoes de calculo: \n 1. UMA unidade de hipoclorito + NOVE unidades de agua \n 2. Quantos litros no deposito estao vazios? \n\nQual e a opcao que pretende usar para calculo?\n > "))
     (message (concat "Opcao de calculo: " v-opc))
     ;; Apos a opcao 1, calcular por exemplo meio garragao de 5 Litros (=2,5 L) e perguntar de seguida quantos litros estao no deposito para se somar ao calculo anterior. O resultado da multiplicacao que é somada aos litros atuais do deposito da o nivel de litros ao qual tem de ficar o deposito no final. e esse resultado nao pode ultrapassar 125 litros porque 125 é a capacidade max do deposito
     )

   (defun dv-calculate-from-Lmin-M3h ()
     (interactive)
     "Calcular de Litros por minuto (L/min) para Metros Cubicos por hora (m3/h)"
     (message "uDev: Ainda não esta pronto"))

;; Emacs CUA mode 
   ;; This, changes the behaviour of Cut, Copy, Paste (from 'C-w', 'M-w', 'C-y') to: 'C-x', 'C-c', 'C-v'
   ;; source: https://www.emacswiki.org/emacs/CuaMode
   ;; 
   ;; Select the CUA style from the Options menu and save the Options.
   ;; Or add this to ~/.emacs(the last three are optional):
   ;; 
      (cua-mode t)
   ;; (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
   ;; (transient-mark-mode 1) ;; No region when it is not highlighted
   ;; (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour


;; Set better hotkeys to shink and enlarge the window frame
    (global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
    (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
    (global-set-key (kbd "S-C-<down>") 'shrink-window)
    (global-set-key (kbd "S-C-<up>") 'enlarge-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun k ()
  "Kills line from cursor position until the end of the line in order to store it in the clipboard and then paste the line again in the same place"
  (interactive)
  (setq v-point (point))  ;; Save cursor position before any action
  (org-kill-line)(yank)   ;; Cut line from cursor pos until the end of the line and paste it again (to put it on the clipboard)
  (goto-char v-point))    ;; Restore cursor position
  (global-set-key (kbd "C-M-k") 'k)  ;; Create a hotkey to repeat this easily


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
;;               ";; Scratch-buffer\n\n")
               
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
       ;; (set-language-environment "UTF-8")
       ;; (set-default-coding-systems 'utf-8)  ;; If you leave this option, the special characters like "ç" will be converted into octal like "/334"
       ;; (set-keyboard-coding-system 'utf-8-unix)
       ;; (set-terminal-coding-system 'utf-8-unix)
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



;; For omni-log:
     (setq v-time (concat "Dia: " (format-time-string "[%Y-%m-%d %a];")))

(defun om-gazol ()
   (interactive)

   ;; uDev: Se o buffer se chamar multiplexer.org, saltar diretamente para o header correspondente com o (concat "Mes" "Ano")

   (setq v_litros (concat (read-string "Foram quantos litros?: ") " Litros;"))
   (setq v_preco-pr-litro (concat "Preco p/Litro: " (read-string "Qual o preço por litro?: ") ";"))
   (setq v_posto  (read-string "Posto? (Cepsa: C) (BP: B) (Prio: P) (Galp: G): "))
                  (when (or (string-equal v_posto "c") (string-equal v_posto "C"))
                        (setq v_posto "Cepsa;"))

                  (when (or (string-equal v_posto "p") (string-equal v_posto "P"))
                        (setq v_posto "Prio;"))

                  (when (or (string-equal v_posto "b") (string-equal v_posto "B"))
                        (setq v_posto "BP;"))

                  (when (or (string-equal v_posto "g") (string-equal v_posto "G"))
                        (setq v_posto "Galp;"))

   (setq v_preco     (concat (read-string "Qual foi o preço em euros €?: ") " €;"))
   (setq v_tipo_comb (concat "Tipo de combst: " (read-string "Qual o tipo de combustivel? (simples: S) (aditivado: A): ") ";" ))
   (setq v_km        (concat (read-string "Quantos KM marcava o painel?: ") " Km;"))
   (setq v_dia       (read-string "Que dia foi? (Em Branco = Hoje): "))
   (insert "Gazol: " v-time " " v_litros " " v_posto " " v_preco " " v_km " " v_tipo_comb " " v_preco-pr-litro " " v_dia))
