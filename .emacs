(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

; smex begin
(global-set-key (kbd "M-x") 'smex)
; smex end

; Bars deaktivieren begin
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
; Bars deaktivieren end

(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(setq multi-term-dedicated-select t)
(setq multi-term-dedicated-select-after-open-p t)

; evil begin
; ffap fuer C-w C-f
(require 'ffap)
(require 'evil)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
 "fs" 'save-buffer
; "s" 'multi-term-dedicated-toggle
 "m" 'magit-status
 "<SPC>" 'ace-jump-mode)
(evil-mode 1)
; Wenn das weg ist, geht ggf. evil-escape-mode nicht mehr, siehe https://github.com/syl20bnr/evil-escape/issues/26
(evil-escape-mode)
(require 'evil-surround)
(global-evil-surround-mode 1)
(evil-set-initial-state 'term-mode 'emacs)
;(add-hook 'haskell-mode-hook (lambda () (push '(?( . ("(" . ")")) evil-surround-pairs-alist))))
; evil end

; ido begin
(require 'ido)
(require 'flx-ido)
(ido-mode t)
; ido auch in describe-function z.B.
(ido-ubiquitous-mode 1)
(ido-everywhere t)
;(flx-ido-mode t)
(setq ido-use-faces nil)
(setq ido-enable-flex-matching t)
; ido end

; zenburn begin
(load-theme 'zenburn t)
; zenburn end

; automatisch hinzugefügt (setzt zenburn als "safe")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "/usr/bin/google-chrome")
 '(company-ghc-show-info t)
 '(custom-safe-themes
   (quote
    ("9dae95cdbed1505d45322ef8b5aa90ccb6cb59e0ff26fef0b8f411dfc416c552" default)))
 '(evil-surround-pairs-alist
   (quote
    ((40 "(" . ")")
     (91 "[" . "]")
     (123 "{ " . " }")
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
 '(org-agenda-files (quote ("~/notes/todo.org")))
 '(org-agenda-start-on-weekday nil)
 '(org-habit-show-habits-only-for-today nil)
 '(org-icalendar-include-todo (quote all))
 '(org-icalendar-use-scheduled (quote (event-if-todo todo-start)))
 '(org-log-done (quote time))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
 '(x-select-enable-primary t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
; automatisch hinzugefügt Ende
(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(setq org-feed-alist
      `(("Remember The Milk"
         ,(get-string-from-file "~/notes/emacs_rtm_feed")
         "/tmp/rtm.org"
         "Remember The Milk"
         :parse-feed org-feed-parse-atom-feed
         :parse-entry org-feed-parse-RTM-entry
         :template "* TODO %title\n%a\n "
         )))

(setq org-todo-keyword-faces
           '(("WAIT" . "yellow")))

; haskell begin
; Einrückung
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
;(yas-global-mode 1)
;(haskell-snippets-initialize 1)
;(setq-default yas-prompt-functions '(yas-ido-prompt yas-dropdown-prompt))
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)
; F8 auf "zu Imports gehen"
;(eval-after-load 'haskell-mode '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))

(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
; Tags klappen irgendwie nicht
;(custom-set-variables '(haskell-tags-on-save t))
; 

; ghc-mod begin
(add-to-list 'load-path "~/.cabal/share/x86_64-linux-ghc-7.8.4/ghc-mod-5.2.1.2/")
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
; ghc-mod end

; Completion mit company begin
(require 'company)
;(add-to-list 'load-path "~/.emacs.d/company-ghc")
(add-hook 'haskell-mode-hook 'company-mode)
(add-to-list 'company-backends 'company-ghc)

; Completion mit company end
					; haskell end

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-c s") 'multi-term-dedicated-toggle)

(projectile-global-mode)


(winner-mode 1)

; bugfix
; siehe http://emacs.stackexchange.com/questions/2107/run-application-in-cwd-on-remote-host-from-within-eshell
(defadvice eshell-gather-process-output (before absolute-cmd (command args) act)
  (setq command (file-truename command)))

(require 'ox-publish)

(setq org-publish-project-alist '(
 ("notes-html"
  :base-directory "~/notes/"
  :base-extension "org"
  :recursive nil
  :publishing-function org-html-publish-to-html
  :publishing-directory "~/notes/published_html"
  )
 ))


(defun org-feed-parse-RTM-entry (entry)
  "Parse the `:item-full-text' as a sexp and create new properties."
  (let ((xml (car (read-from-string (plist-get entry :item-full-text)))))
    ;; Get first <link href='foo'/>.
    (setq entry (plist-put entry :link
                           (xml-get-attribute
                            (car (xml-get-children xml 'link))
                            'href)))
    ;; Add <title/> as :title.
    (setq entry (plist-put entry :title
                           (xml-substitute-special
                            (car (xml-node-children
                                  (car (xml-get-children xml 'title)))))))
    ;; look for some other information that's in the content of the entry
    ;; the structure looks something like:
    ;; <content><div>   <div item> <span itemname></span><span itemvalue></span></div>...
;    (let* ((content (car (xml-get-children xml 'content)))
;           (main  (car (xml-get-children content 'div)))
;           (items (xml-get-children main 'div)))
;      (when items
;        ; iterate over all items and check for certain classes
;        (while items
;          (setq item (car items))
;          ; get the second span entry
;          (setq valuesub (car (cdr (xml-node-children item))))
;             (cond
;              ((string= (xml-get-attribute item 'class) "rtm_due")
;               (setq entry (plist-put entry :due (car (xml-node-children valuesub))))
;               (setq mydate (car (xml-node-children valuesub)))
;               (if (string= mydate "never")
;                   nil
;                 (progn
;                  (string-match "^\\([a-zA-Z]*\\) \\([0-9]*\\) \\([a-zA-Z]*\\) \\([0-9]*\\)$" mydate)
;                  (setq mydate (concat "20" (match-string 4 mydate) " " (match-string 3 mydate) " " (match-string 2 mydate) " 00:00:01"))
;                  (setq mydate (parse-time-string mydate))
;                  (setq mydate (apply #'encode-time mydate))
;                  (setq mydate (format-time-string (car org-time-stamp-formats) mydate))
;                  (setq entry (plist-put entry :dueorgformat mydate)))))
;              ((string= (xml-get-attribute item 'class) "rtm_tags")
;               (setq entry (plist-put entry :tags (car (xml-node-children valuesub)))))
;              ((string= (xml-get-attribute item 'class) "rtm_time_estimate")
;               (setq entry (plist-put entry :timeestimate (car (xml-node-children valuesub)))))
;              ((string= (xml-get-attribute item 'class) "rtm_priority")
;               (setq entry (plist-put entry :priority (car (xml-node-children valuesub)))))
;              ((string= (xml-get-attribute item 'class) "rtm_location")
;               (setq entry (plist-put entry :location (car (xml-node-children valuesub))))))
;          (setq items (cdr items))
;          )))
    entry))

(setq org-default-notes-file (concat org-directory "/notes/todo.org"))
     (define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/notes/todo.org" "Akut")
             "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n  %i")
        ("j" "Todo" entry (file+headline "~/notes/todo.org" "Jumpie")
             "* TODO %?\n  %i")
        ))

(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

; Speichert die Minibuffer-History
(savehist-mode 1)

; Speichert Desktops
;(desktop-save-mode 1)

(hl-line-mode)

;(add-hook 'term-mode-hook 'evil-emacs-state)

(add-hook 'nxml-mode-hook
 (lambda () (rng-validate-mode 0) )
 t)
