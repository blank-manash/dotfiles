(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar
(setq visible-bell t)       ; Set up the visible bell -
(face-attribute 'default :font)
(set-face-attribute 'default nil :font "Dank Mono" :height 170)
(add-to-list 'default-frame-alist '(font . "Dank Mono"))
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ;; Make ESC quit prompt
(global-set-key (kbd "C-a") 'org-agenda)
(bookmark-load "~/.emacs.d/bookmarks")
(column-number-mode)
(global-display-line-numbers-mode t)

(require 'package) ; Initialize package sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t)

(use-package vterm
:defer t
  )

(use-package telephone-line
  :config
  (require 'telephone-line)
  (telephone-line-mode 1))

(use-package evil
  :init ;; tweak evil's configuration before loading it
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  :config ;; tweak evil after loading it
  (evil-mode)
)

(use-package evil-collection
  :after evil
  :config (evil-collection-init)
  )

;; inoremap jk is <Esc> "" Oops this is not vim.
(use-package key-chord
  :config
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-mode 1)
  (define-key emacs-lisp-mode-map (kbd "M-p") 'check-parens))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects")
    (setq projectile-project-search-path '("~/Projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit)
(use-package forge)

(use-package telega
  :hook (telega-chat-mode . company-mode)
  :bind ("C-x C-t" . telega)
  :config
  (setq telega-use-images '(scale rotate90))
  (setq telega-emoji-font-family "Noto Color Emoji")
  (setq telega-emoji-use-images "Noto Color Emoji")
  (setq telega-online-status-function 'telega-focus-state))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1)
  (setq org-edit-src-content-indentation 2)
  (setq org-src-tabs-acts-natively t))

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))))

(use-package org
  :pin gnu
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾" org-hide-emphasis-markers t)
  (efs/org-font-setup)
  (gtd-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 120)
  (setq visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(use-package org-mime
  :hook (message-send-hook . org-mime-htmlize)
  :defer t
  :config
  (setq org-mime-export-options '(:section-numbers nil :with-author nil :with-toc nil))
  (add-hook 'org-mime-html-hook
            (lambda ()
              (org-mime-change-element-style
               "pre" (format "color: %s; background-color: %s; padding: 0.5em;"
                             "#E6E1DC" "#232323")))))

(defun my-org/setup-org-todo-keywords ()
  (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-todo-keyword-faces '(("TODO" . (:foreground "red" :weight bold)) ("NEXT" . (:foreground "blue" :weight bold)))))

(defun my-org/setup-capture-templates ()
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline "~/gtd/inbox.org" "Tasks")
                                 "* TODO %i%?")
                                ("T" "Tickler" entry
                                 (file+headline "~/gtd/tickler.org" "Tickler")
                                 "* %i%? \n %U"))))

(defun my-org/setup-agenda-files ()
  (setq org-agenda-files '("~/gtd/inbox.org"
                           "~/gtd/gtd.org"
                           "~/gtd/tickler.org")))

(defun my-org/setup-refile-targets ()
  (setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
                             ("~/gtd/someday.org" :level . 1)
                             ("~/gtd/tickler.org" :maxlevel . 2))))

(defun my-org/setup-agenda-custom-commands ()
  (setq org-agenda-custom-commands
        '(("o" "At the office" tags-todo "@office"
           ((org-agenda-overriding-header "Office")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))

          ("p" "Personal Projects" tags-todo "@personal"
           ((org-agenda-overriding-header "Personal")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))

          ("s" "Project Setup" tags-todo "@setup"
           ((org-agenda-overriding-header "Project Setup")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))

          ("n" "Next Tasks" ((todo "NEXT" ((org-agenda-overriding-header "Next Tasks"))))))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-next)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-next) (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))

(defun org-current-is-next ()
  (string= "NEXT" (org-get-todo-state)))

(defun gtd-setup ()
  (my-org/setup-refile-targets)
  (my-org/setup-agenda-custom-commands)
  (my-org/setup-agenda-files)
  (my-org/setup-capture-templates)
  (my-org/setup-org-todo-keywords)
  )

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "/home/manash/.emacs.d/dotemacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (C . t)
   ))
(setq org-confirm-babel-evaluate nil)

    ;;; Structure Templates
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src bash"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("el" . "src elisp"))
(add-to-list 'org-structure-template-alist '("vi" . "src vimrc"))

(use-package org-roam
  :ensure t
  :defer t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/brain")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%I:%M %p>: %?"
      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  (org-roam-db-autosync-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         ([remap buffer-menu] . ibuffer)
         :map minibuffer-local-map
         ("C-r" . counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)

(use-package ivy-prescient
  :after counsel
  :config
  (ivy-prescient-mode 1))
  

(use-package company-prescient
  :after company
  :config
  (company-prescient-mode 1))

;; Remember candidate frequencies across sessions
(prescient-persist-mode 1)

(use-package smooth-scrolling
  :init (smooth-scrolling-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key)
)

(use-package swiper :ensure t)
(use-package all-the-icons) ;; M-x all-the-icons-install-fonts # Only for first time usage.
(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))

(use-package which-key
  :init (which-key-mode)
  :defer t
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package smartparens
  :hook (prog-mode . smartparens-mode)
)

(use-package format-all
  :hook (prog-mode . format-all-mode)
  :bind (("M-f" . format-all-buffer)))

(use-package hl-todo
  :config
  (global-hl-todo-mode))

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode))

(use-package  langtool
  :commands (langtool-check langtool-check-done langtool-show-message-at-point langtool-correct-buffer)
  :init (setq langtool-default-language "en-US")
  :config
  (setq langtool-language-tool-server-jar "/home/manash/code/LanguageTool-5.7/languagetool-server.jar")
  (setq langtool-language-tool-jar "/home/manash/code/LanguageTool-5.7/languagetool-commandline.jar"))

(defun my-mail-setup ()
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Mail")

  (setq mu4e-drafts-folder "/[Gmail]/Drafts")
  (setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
  (setq mu4e-refile-folder "/[Gmail]/All Mail")
  (setq mu4e-trash-folder  "/[Gmail]/Trash")


  (setq mu4e-bookmarks
        '(("flag:unread AND NOT flag:trashed" "Unread messages"      ?i)
          ("date:today..now"                  "Today's messages"     ?t)
          ("from:gamakshi@iitk.ac.in"         "Gamakshi"             ?s)
          ("date:7d..now"                     "Last 7 days"          ?w)
          ("mime:image/*"                     "Messages with images" ?p)))
  (setq mu4e-maildir-shortcuts
        '(("/Inbox"             . ?i)
          ("/[Gmail]/Sent Mail" . ?s)
          ("/[Gmail]/Trash"     . ?t)
          ("/[Gmail]/Drafts"    . ?d)
          ("/[Gmail]/All Mail"  . ?a)))

  (setq message-send-mail-function 'smtpmail-send-it)

  (setq mu4e-compose-signature "Manash Baul\nSoftware Engineer InMobi Ltd.\nCSE IIT Kanpur")
  (setq user-mail-address "mximpaid@gmail.com"
        user-full-name "Manash Baul"
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 465
        smtpmail-stream-type 'ssl))
(define-key message-mode-map
  (kbd "C-c o") 'org-mime-edit-mail-in-org-mode)

(require 'mu4e)
(my-mail-setup)

(use-package emojify
  :hook (after-init . global-emojify-mode))

(defun lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook ((lsp-mode . lsp-ui-mode) (lsp-ui-mode . lsp-diagnostics-mode))
  :bind (:map lsp-mode-map ("K" . lsp-ui-doc-show))
  :custom
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-show-diagnostics t))

(use-package lsp-treemacs
  :after lsp)
(use-package lsp-ivy)
(use-package flycheck)

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map lsp-mode-map
              ("<tab>" . company-complete-selection)
              ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines)) ;; Guess what this does.

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred))

(use-package vimrc-mode
  :mode "\\.vim\\(rc\\)?\\'")

(add-hook 'c++-mode-hook 'lsp-deferred)
(add-hook 'c-mode-hook 'lsp-deferred)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

(defun dired-maps ()
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))

(use-package dired-single
  :init (dired-maps))
