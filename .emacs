(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
("marmalade" . "http://marmalade-repo.org/packages/")
("melpa" . "http://melpa.milkbox.net/packages/")))

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
 '(haskell-stylish-on-save t)
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

(package-initialize)
(require 'grep)
(require 'helm-config)

(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "<f8>") 'eshell)
(global-set-key (kbd "<f7>") 'magit-status)

(ido-mode 1)
(setq ido-everywhere t)
(ido-ubiquitous-mode 1)
(setq ido-enable-flex-matching t)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(require 'avy)
(global-set-key (kbd "C-:") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "C-'") 'avy-goto-char)
(avy-setup-default)
(add-hook 'haskell-mode-hook 'subword-mode)

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-ca" 'org-agenda)

(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

(rainbow-delimiters-mode)
(show-paren-mode)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(defun er/add-text-mode-expansions ()
  (make-variable-buffer-local 'er/try-expand-list)
  (setq er/try-expand-list (append
                            er/try-expand-list
                            '(mark-paragraph
                              mark-page))))

(add-hook 'haskell-mode-hook 'er/add-text-mode-expansions)

(load-theme 'zenburn t)

(savehist-mode 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

(add-hook 'eww-mode-hook
	          (lambda () (define-key eww-mode-map "f" 'eww-lnum-follow)))
(global-set-key (kbd "C-x b") 'helm-mini)

(require 'hydra)

(winner-mode)

(defhydra hydra-window (global-map "C-c w" :color red :hint nil)
  "
 Misc: _u_ndo  _r_edo _x_ill _n_ext"
  ("h" windmove-left)
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)
  ("u" winner-undo)
  ("r" winner-redo)
  ("0" delete-windoww)
  ("x" kill-this-buffer)
  ("n" next-buffer))

(defhydra hydra-misc (global-map "C-x m" :color red :hint nil)
  "
 Misc: _s_potify"
  ("s" helm-spotify))

(setq browse-url-new-window-flag t)

(add-hook 'eshell-mode-hook
          (lambda ()
           (setenv "PAGER" "cat"))
           (setenv "EDITOR" "emacsclient"))

(setq rng-nxml-auto-validate-flag nil)

(setq org-clock-into-drawer t)
(setq org-drawers '("PROPERTIES" "LOGBOOK"))

(load "~/.emacs.d/personal-init")

(require 'smartparens-config)
(smartparens-global-mode t)

(require 'which-key)
(which-key-mode)

(require 'bm)

(define-fringe-bitmap 'bm-marker-left [#xF8   ; ▮ ▮ ▮ ▮ ▮ 0 0 0
                                       #xFC   ; ▮ ▮ ▮ ▮ ▮ ▮ 0 0
                                       #xFE   ; ▮ ▮ ▮ ▮ ▮ ▮ ▮ 0
                                       #x0F   ; 0 0 0 0 ▮ ▮ ▮ ▮
                                       #x0F   ; 0 0 0 0 ▮ ▮ ▮ ▮
                                       #xFE   ; ▮ ▮ ▮ ▮ ▮ ▮ ▮ 0
                                       #xFC   ; ▮ ▮ ▮ ▮ ▮ ▮ 0 0
                                       #xF8]) ; ▮ ▮ ▮ ▮ ▮ 0 0 0

(defhydra hydra-bm (:color red :hint nil :idle 1.0)
  "Bookmarks"
  ("t" bm-toggle "Toggle")
  ("j" bm-next "Next")
  ("k" bm-previous "Previous")
  ("l" bm-show "Show local")
  ("A" bm-show-all "Show all")
  ("a" bm-bookmark-annotate)
  ("x" bm-remove-all-current-buffer :color blue))
(global-set-key (kbd "C-c b") 'hydra-bm/body)

(require 'powerline)
(powerline-default-theme)
