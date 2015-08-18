(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bm-highlight-style (quote bm-highlight-only-fringe))
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "xdg-open")
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "b06aaf5cefc4043ba018ca497a9414141341cb5a2152db84a9a80020d35644d1" default)))
 '(haskell-stylish-on-save nil)
 '(inhibit-startup-screen t)
 '(op/site-main-title "pmiddend's Blog")
 '(op/site-sub-title
   "Stuff about Haskell, nutrition, learning and life in general")
 '(org-agenda-files (quote ("~/notes/work.org" "~/notes/todo.org")))
 '(org-clock-into-drawer t)
 '(org-extend-today-until 3)
 '(org-icalendar-include-todo (quote all))
 '(org-icalendar-use-scheduled (quote (event-if-todo todo-start)))
 '(org-log-done (quote time))
 '(org-modules (quote (org-habit)))
 '(savehist-mode t)
 '(sunshine-location "Hannover, Germany")
 '(sunshine-units (quote metric))
 '(x-select-enable-primary t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
("marmalade" . "http://marmalade-repo.org/packages/")
("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
    (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package grep)

(use-package helm
  :init
  (global-set-key (kbd "M-x") 'helm-M-x))

(use-package ido-ubiquitous
  :init
  (ido-ubiquitous-mode 1)
  (ido-mode 1)
  (setq ido-everywhere t)
  (setq ido-enable-flex-matching t)
)
  
(use-package projectile
  :init
  (projectile-global-mode)
  (setq projectile-completion-system 'helm))

(use-package helm-projectile
  :init
  (helm-projectile-on))

(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

(global-set-key (kbd "<f7>") 'magit-status)

(use-package avy
  :init
  (global-set-key (kbd "C-.") 'avy-goto-word-or-subword-1)
  (global-set-key (kbd "C-'") 'avy-goto-char)
  (avy-setup-default))
  
(add-hook 'haskell-mode-hook 'subword-mode)

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-ca" 'org-agenda)

(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

(use-package rainbow-delimiters
  :init
  (rainbow-delimiters-mode))

(show-paren-mode)

(use-package expand-region
  :init
  (global-set-key (kbd "C-=") 'er/expand-region))

;(defun er/add-text-mode-expansions ()
;  (make-variable-buffer-local 'er/try-expand-list)
;  (setq er/try-expand-list (append
;                            er/try-expand-list
;                            '(mark-paragraph
;                              mark-page))))
;
;(add-hook 'haskell-mode-hook 'er/add-text-mode-expansions)

(use-package zenburn-theme
  :init
  (load-theme 'zenburn t))

(savehist-mode 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

(add-hook 'eww-mode-hook
	          (lambda () (define-key eww-mode-map "f" 'eww-lnum-follow)))
;(global-set-key (kbd "C-x b") 'helm-mini)

(use-package hydra)

(defhydra hydra-window (global-map "C-c w" :color red :hint nil)
    "
    Windows: _u_ndo  _r_edo _x_ill _n_ext _p_revious"
    ("h" windmove-left)
    ("j" windmove-down)
    ("k" windmove-up)
    ("l" windmove-right)
    ("u" winner-undo)
    ("r" winner-redo)
    ("0" delete-window)
    ("2" split-window-below)
    ("3" split-window-right)
    ("n" next-buffer)
    ("p" previous-buffer)
    ("x" kill-this-buffer))

(winner-mode)

(use-package helm-spotify
  :init
  (defhydra hydra-misc (global-map "C-c m" :color red :hint nil)
    "Misc: _s_potify"
    ("s" helm-spotify)))

(setq browse-url-new-window-flag t)

(add-hook 'eshell-mode-hook
          (lambda ()
           (setenv "PAGER" "cat"))
           (setenv "EDITOR" "emacsclient"))

(setq rng-nxml-auto-validate-flag nil)

(setq org-clock-into-drawer t)
(setq org-drawers '("PROPERTIES" "LOGBOOK"))

(load "~/.emacs.d/personal-init")


(use-package smartparens
	     :init (smartparens-global-mode t))

(use-package which-key
  :init (which-key-mode))

(use-package bm
  :init
  (define-fringe-bitmap 'bm-marker-left [#xF8   ; ▮ ▮ ▮ ▮ ▮ 0 0 0
                                       #xFC   ; ▮ ▮ ▮ ▮ ▮ ▮ 0 0
                                       #xFE   ; ▮ ▮ ▮ ▮ ▮ ▮ ▮ 0
                                       #x0F   ; 0 0 0 0 ▮ ▮ ▮ ▮
                                       #x0F   ; 0 0 0 0 ▮ ▮ ▮ ▮
                                       #xFE   ; ▮ ▮ ▮ ▮ ▮ ▮ ▮ 0
                                       #xFC   ; ▮ ▮ ▮ ▮ ▮ ▮ 0 0
                                       #xF8])
  (defhydra hydra-bm (:color red :hint nil :idle 1.0)
  "Bookmarks"
    ("t" bm-toggle "Toggle")
    ("j" bm-next "Next")
    ("k" bm-previous "Previous")
    ("l" bm-show "Show local")
    ("A" bm-show-all "Show all")
    ("a" bm-bookmark-annotate)
    ("x" bm-remove-all-current-buffer :color blue))
  (global-set-key (kbd "C-c b") 'hydra-bm/body))

; klappt mit circe nicht.
;(use-package powerline
;  :init
;  (powerline-default-theme))

(use-package evil
  :init
  (require 'ffap)
  (evil-mode 1)
  (evil-set-initial-state 'term-mode 'emacs)
  (evil-set-initial-state 'eshell-mode 'emacs)
;  (evil-define-state emacs
;    "Emacs state that can be exited with the escape key."
;    :tag " <EE> "
;    :message "-- EMACS WITH ESCAPE --"
;    :input-method t)
;  (defadvice evil-insert-state (around emacs-state-instead-of-insert-state activate)
;    (evil-emacs-state))
;  (setq evil-default-state 'emacs)
;  (setq evil-normal-state-cursor '(box "red"))
;  (setq evil-visual-state-cursor '(box "blue"))
;  (setq evil-motion-state-cursor '(box "green"))
;  (setq evil-emacs-state-cursor '(box "white"))
;  (evil-set-initial-state 'fundamental-mode 'emacs)
;  (evil-set-initial-state 'prog-mode 'emacs)
					;  (evil-set-initial-state 'text-mode 'emacs))
  )

(use-package evil-escape
  :init
  (evil-escape-mode))

(use-package evil-leader
  :init
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
   "fs" 'save-buffer
   "s" 'eshell
   "<SPC>" 'avy-goto-word-or-subword-1))

(use-package evil-surround
  :init
  (global-evil-surround-mode 1))
