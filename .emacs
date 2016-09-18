(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdg-open")
     (output-pdf "xdg-open")
     (output-html "xdg-open"))))
 '(bbdb-file "~/notes/bbdb")
 '(bbdb-phone-style nil)
 '(bm-highlight-style (quote bm-highlight-only-fringe))
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "qutebrowser")
 '(c-syntactic-indentation t)
 '(calendar-week-start-day 1)
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "b06aaf5cefc4043ba018ca497a9414141341cb5a2152db84a9a80020d35644d1" default)))
 '(dired-dwim-target t)
 '(display-time-default-load-average nil)
 '(evil-surround-pairs-alist
   (quote
    ((40 "(" . ")")
     (91 "[" . "]")
     (123 "{" . "}")
     (41 "(" . ")")
     (93 "[" . "]")
     (125 "{" . "}")
     (35 "#{" . "}")
     (98 "(" . ")")
     (66 "{" . "}")
     (62 "<" . ">")
     (116 . evil-surround-read-tag)
     (60 . evil-surround-read-tag)
     (102 . evil-surround-function))))
 '(explicit-shell-file-name "/bin/bash")
 '(flycheck-clang-language-standard "c++11")
 '(flycheck-cppcheck-language-standard "-std=c++11")
 '(flycheck-gcc-language-standard "c++11")
 '(global-auto-complete-mode nil)
 '(haskell-stylish-on-save nil)
 '(ido-use-virtual-buffers t)
 '(ido-vertical-disable-if-short nil)
 '(inhibit-startup-screen t)
 '(mouse-wheel-progressive-speed nil)
 '(mu4e-html2text-command "w3m -dump -T text/html")
 '(mu4e-view-show-images nil)
 '(newsticker-url-list
   (quote
    (("planet emacs" "http://planet.emacsen.org/atom.xml" nil nil nil))))
 '(openwith-associations
   (quote
    (("\\.\\(?:mpe?g\\|avi\\|wmv\\|mp4\\|mkv\\)\\'" "mpv"
      (file))
     ("\\.\\(?:jp?g\\|png\\)\\'" "display"
      (file)))))
 '(org-agenda-files (quote ("~/notes/todo.org")))
 '(org-agenda-span 14)
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-use-time-grid nil)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (plantuml . t))))
 '(org-clock-into-drawer t)
 '(org-drill-add-random-noise-to-intervals-p t)
 '(org-drill-learn-fraction 0.3)
 '(org-drill-leech-method (quote warn))
 '(org-export-backends (quote (ascii beamer html icalendar latex)))
 '(org-extend-today-until 3)
 '(org-hide-emphasis-markers nil)
 '(org-icalendar-include-bbdb-anniversaries t)
 '(org-icalendar-include-todo t)
 '(org-icalendar-use-scheduled (quote (event-if-not-todo event-if-todo todo-start)))
 '(org-log-done (quote time))
 '(org-lowest-priority 90)
 '(org-modules (quote (org-bbdb org-habit org-drill)))
 '(org-trello-files (quote ("~/notes/trello.org")))
 '(package-selected-packages
   (quote
    (auctex-latexmk auctex math-symbol-lists ace-link fraktur-mode ac-emoji graphviz-dot-mode plantuml-mode circe-notifications circe jabber emamux ix pastebin twittering-mode exwm-x adoc-mode lyrics calfw wttrin volatile-highlights link-hint company-emoji nyan-mode weather-metno dictcc popwin projectile shell-pop w3m ido-vertical-mode gist org-pdfview pdf-tools org-cliplink org-bullets bbdb evil-surround evil-leader evil-escape evil smartparens psc-ide purescript-mode intero weechat cmake-ide yasnippet flycheck company-c-headers company rtags mu4e-alert org-page hydra eww-lnum zenburn-theme expand-region rainbow-delimiters simpleclip avy flx-ido ido-ubiquitous magit smex use-package)))
 '(safe-local-variable-values
   (quote
    ((cmake-ide-dir . "/home/philipp/Programming/openstryker/level_reader/build")
     (cmake-ide-dir . "/home/philipp/Programming/openstryker/ega_reader/build")
     (cmake-ide-dir . "/home/philipp/Programming/openstryker/cmp_unpacker/build"))))
 '(savehist-mode t)
 '(select-enable-primary t)
 '(sentence-end-double-space nil)
 '(shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
 '(shell-pop-universal-key "C-c t")
 '(sp-autoinsert-pair nil)
 '(sunshine-location "Hannover, Germany")
 '(sunshine-units (quote metric))
 '(twittering-timer-interval 180)
 '(use-dialog-box nil)
 '(w3m-search-default-engine "duckduckgo")
 '(w3m-search-engine-alist
   (quote
    (("duckduckgo" "https://duckduckgo.com/?q=%s" undecided)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(
("gnu" . "http://elpa.gnu.org/packages/")
("marmalade" . "http://marmalade-repo.org/packages/")
("melpa" . "http://melpa.org/packages/")))

(package-initialize)


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package smex
  :config
  (smex-initialize)
  :bind ("M-x" . smex)
  :bind ("M-X" . smex-major-mode-commands)
  :bind ("C-c C-c M-x" . execute-extended-command))

(use-package magit
  :bind ("<f7>" . magit-status))

(use-package ido
  :bind ("<f12>" . ido-switch-buffer))

(use-package ido-ubiquitous
  :init
  (setq ido-enable-flex-matching t)
  (setq org-completion-use-ido t)
  (setq magit-completing-read-function 'magit-ido-completing-read)
  (setq ido-auto-merge-work-directories-length -1)
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1)
  (put 'dired-do-rename 'ido 'find-file)
  (put 'dired-do-copy 'ido 'find-file)
  )

(use-package flx-ido)

(global-set-key (kbd "C-x C-o") 'other-window)
(global-set-key (kbd "C-x C-0") 'delete-window)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

(use-package avy
;  :bind ("C-." . avy-goto-word-or-subword-1)
;  :bind ("C-'" . avy-goto-char)
  :bind ("C-l" . avy-goto-word-or-subword-1)
  :config
  (avy-setup-default))

(define-key global-map (kbd "C-<up>") 'windmove-up)
(define-key global-map (kbd "C-<down>") 'windmove-down)
(define-key global-map (kbd "C-<left>") 'windmove-left)
(define-key global-map (kbd "C-<right>") 'windmove-right)
(define-key global-map (kbd "<f1>") 'eww-list-bookmarks)
(define-key global-map (kbd "<f2>") 'recompile)

;(add-to-list 'load-path "~/Programming/org-rtm")
;(require 'org-rtm)

(use-package org
  :load-path ("~/org-mode/lisp" "~/org-mode/contrib/lisp")
  :init
  (add-hook 'org-mode-hook 'visual-line-mode)
  (setq org-clock-into-drawer t)
  (setq org-drawers '("PROPERTIES" "LOGBOOK"))
  (setq org-todo-keyword-faces '(("WAIT" . "yellow")))
  (setq org-clock-heading-function
      (lambda ()
        (let ((str (nth 4 (org-heading-components))) (lenlimit 20))
          (if (> (length str) lenlimit)
              (substring  (replace-regexp-in-string
			  "\\[\\[.*?\\]\\[\\(.*?\\)\\]\\]" "\\1"
			  str) 0 lenlimit)))))
  (setq org-ellipsis "⤵")
  (setq org-clock-persist 'history)
  :config
  (add-hook 'org-mode-hook '(lambda () (org-indent-mode 1)))
  (org-clock-persistence-insinuate)
  (add-hook 'org-create-file-search-functions
	    '(lambda ()
	       (when (eq major-mode 'text-mode)
		 (number-to-string (line-number-at-pos)))))

  (add-hook 'org-execute-file-search-functions
	    '(lambda (search-string)
	       (when (eq major-mode 'text-mode)
		 (goto-line (string-to-number search-string)))))
  (font-lock-add-keywords 'org-mode
                        '(("^ +\\([-*]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  ;; (defadvice org-open-at-point (around org-open-at-point-choose-browser activate)
  ;;   (let ((browse-url-browser-function
  ;; 	   (cond ((equal (ad-get-arg 0) '(4))
  ;; 		  'browse-url-generic)
  ;; 		 ((equal (ad-get-arg 0) '(16))
  ;; 		  'choose-browser)
  ;; 		 (t
  ;; 		  (lambda (url &optional new)
  ;; 		    (w3m-browse-url url t)))
  ;; 		 )))
  ;;     ad-do-it))
  :bind ("\C-cl" . org-store-link)
  :bind ("\C-ca" . org-agenda)
  :bind ("\C-cc" . org-capture))

(use-package simpleclip
  :bind ("s-y" . simpleclip-paste)
  :config
  (simpleclip-mode 1))

(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(show-paren-mode)

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package zenburn-theme
  :config
  (load-theme 'zenburn t)
  (when window-system
    (menu-bar-mode 0)
    (tool-bar-mode 0)
    (scroll-bar-mode 0)))

(savehist-mode 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

(use-package eww-lnum
  :config
  (add-hook 'eww-mode-hook (lambda () (define-key eww-mode-map "f" 'eww-lnum-follow))))

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

(setq browse-url-new-window-flag t)

(add-hook 'eshell-mode-hook
          (lambda ()
           (setenv "PAGER" "cat"))
           (setenv "EDITOR" "emacsclient"))

(setq rng-nxml-auto-validate-flag nil)

(load "~/.emacs.d/personal-init")

(use-package smartparens
  :config (smartparens-global-mode t)
  :diminish smartparens-mode)

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
  (evil-set-initial-state 'pdf-view-mode 'emacs)
  (evil-set-initial-state 'circe-mode 'emacs)
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
  (evil-set-initial-state 'git-commit-mode 'emacs)
  (evil-set-initial-state 'weechat-mode 'emacs)
  (evil-set-initial-state 'shell-mode 'emacs)
  (evil-set-initial-state 'dired-mode 'emacs)
)

(use-package evil-escape
  :init
  (evil-escape-mode)
  :diminish evil-escape-mode)

(defun switch-to-previous-buffer ()
      (interactive)
      (switch-to-buffer (other-buffer (current-buffer) 1)))

(use-package evil-leader
  :init
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
   "fs" 'save-buffer
   "<tab>" 'switch-to-previous-buffer
   "s" 'eshell
   "<SPC>" 'avy-goto-word-or-subword-1))

(use-package evil-surround
  :init
  (global-evil-surround-mode 1)
  )

(use-package undo-tree
  :diminish undo-tree-mode)

(use-package diminish
  :init
  (diminish 'auto-fill-function "F"))

(fset 'yes-or-no-p 'y-or-n-p)

(use-package bbdb
  :init
  (bbdb-initialize))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-cliplink
  :bind ("C-x p i" . org-cliplink))

(defun nxml-pretty-format ()
    (interactive)
    (save-excursion
        (shell-command-on-region (point-min) (point-max) "xmllint --format -" (buffer-name) t)
        (nxml-mode)
        (indent-region begin end)))

(use-package pdf-tools)

(use-package org-pdfview
  :init
  (pdf-tools-install)
  :config
  ;(delete '("\\.pdf\\'" . default) org-file-apps)
  (add-to-list 'org-file-apps '("\\.pdf\\'" . org-pdfview-open))
  (add-to-list 'org-file-apps '("\\.pdf::\\([[:digit:]]+\\)\\'" . org-pdfview-open)))

(use-package gist)

(use-package ido-vertical-mode
  :config
  (ido-vertical-mode 1)
  :init
;  (setq ido-use-faces t)
;  (set-face-attribute 'ido-vertical-first-match-face nil
;                    :background "#e5b7c0")
;  (set-face-attribute 'ido-vertical-only-match-face nil
;                    :background "#e52b50"
;                    :foreground "white")
;  (set-face-attribute 'ido-vertical-match-face nil
;                    :foreground "#b00000")
  (setq ido-vertical-define-keys 'C-n-C-p-up-and-down))

; dired shouldn't leave a trail of buffers
(put 'dired-find-alternate-file 'disabled nil)

(setq dired-guess-shell-alist-user
      '(("\\.pdf\\'" "xdg-open")
	; hier weitere
	))

(defun w3m-open-current-page-in-generic ()
  "Open the current URL in generic."
  (interactive)
  (browse-url-generic w3m-current-url)) ;; (1)

(use-package w3m
  :config
  (define-key w3m-mode-map "\C-c\C-o" 'w3m-open-current-page-in-generic))

(use-package shell-pop
  :init
  (custom-set-variables
   '(shell-pop-universal-key "C-c t")
   '(shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell)))))))


(global-set-key (kbd "C-x C-b") 'ibuffer)

(use-package projectile
  :init
  (setq projectile-mode-line '(:eval (format " P[%s]" (projectile-project-name))))
  :config
  (add-hook 'c-mode-common-hook 'projectile-mode))


(use-package popwin
  :config
  (popwin-mode 1))

(use-package dictcc)

(use-package weather-metno
  :init
  (setq
      weather-metno-location-name "Hannover, Germany"
      weather-metno-location-latitude 52
      weather-metno-location-longitude 9))

(use-package nyan-mode
  :config
  (nyan-mode))

(use-package company-emoji
  :config
  (add-to-list 'company-backends 'company-emoji)
  (set-fontset-font
   t 'symbol
   (font-spec :family "Symbola") nil 'prepend))

(use-package link-hint
  :bind
  ("C-c o o" . link-hint-open-link)
  ("C-c o c" . link-hint-copy-link))

(setq solar-n-hemi-seasons
      '("Frühlingsanfang" "Sommeranfang" "Herbstanfang" "Winteranfang"))

(setq holiday-general-holidays
      '((holiday-fixed 1 1 "Neujahr")
        (holiday-fixed 5 1 "1. Mai")
        (holiday-fixed 10 3 "Tag der Deutschen Einheit")))

;; Feiertage fÃ¼r Bayern, weitere auskommentiert
(setq holiday-christian-holidays
      '((holiday-float 12 0 -4 "1. Advent" 24)
        (holiday-float 12 0 -3 "2. Advent" 24)
        (holiday-float 12 0 -2 "3. Advent" 24)
        (holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-fixed 12 25 "1. Weihnachtstag")
        (holiday-fixed 12 26 "2. Weihnachtstag")
        ;(holiday-fixed 1 6 "Heilige Drei Könige")
        ;(holiday-easter-etc -48 "Rosenmontag")
        ;; (holiday-easter-etc -3 "GrÃ¼ndonnerstag")
        (holiday-easter-etc  -2 "Karfreitag")
        (holiday-easter-etc   0 "Ostersonntag")
        (holiday-easter-etc  +1 "Ostermontag")
        (holiday-easter-etc +39 "Christi Himmelfahrt")
        (holiday-easter-etc +49 "Pfingstsonntag")
        (holiday-easter-etc +50 "Pfingstmontag")
        ;(holiday-easter-etc +60 "Fronleichnam")
        ;(holiday-fixed 8 15 "Mariae Himmelfahrt")
        (holiday-fixed 11 1 "Allerheiligen")
        ;; (holiday-float 11 3 1 "Buss- und Bettag" 16)
        ;(holiday-float 11 0 1 "Totensonntag" 20)
	))

(add-to-list 'default-frame-alist
             '(font . "Source Code Pro-12"))

(defun dired-open-xdg ()
  "Try to run `xdg-open' to open the file under point."
  (interactive)
  (if (executable-find "xdg-open")
      (let ((file (ignore-errors (dired-get-file-for-visit))))
        (start-process "dired-open" nil
                       "xdg-open" (file-truename file)))
    nil))

(define-key dired-mode-map "F" 'dired-open-xdg)

; Scripts automatisch ausführbar machen beim Speichern
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))

(use-package wttrin
  :init
  (setq wttrin-default-cities '("Hannover")))

(use-package calfw
  :init
  (require 'calfw-org))
