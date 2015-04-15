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

; evil begin
(require 'evil)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
 "fs" 'save-buffer
 "<SPC>" 'ace-jump-mode)
(evil-mode 1)
(evil-escape-mode)
; evil end

; ido begin
(require 'ido)
(require 'flx-ido)
(ido-mode t)
(ido-everywhere t)
(flx-ido-mode t)
(setq ido-use-faces nil)
(setq ido-enable-flex-matching t)
; ido end

; zenburn begin
(load-theme 'zenburn t)
; zenburn end

; automatisch hinzugefügt (setzt zenburn als "safe")
(custom-set-variables
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "/usr/bin/google-chrome")
 '(custom-safe-themes
   (quote
    ("9dae95cdbed1505d45322ef8b5aa90ccb6cb59e0ff26fef0b8f411dfc416c552" default))))
(custom-set-faces)
; automatisch hinzugefügt Ende

; haskell begin
; Einrückung
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)
; F8 auf "zu Imports gehen"
(eval-after-load 'haskell-mode '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))

(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
; Tags klappen irgendwie nicht
;(custom-set-variables '(haskell-tags-on-save t))
; 

; ghc-mod begin
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
; ghc-mod end

; Completion mit company begin
(require 'company)
(add-hook 'haskell-mode-hook 'company-mode)
(add-to-list 'company-backends 'company-ghc)
(custom-set-variables '(company-ghc-show-info t))
; Completion mit company end
					; haskell end

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(projectile-global-mode)
