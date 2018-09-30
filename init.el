(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;; Backup config
(setq backup-directory-alist `(("." . "~/.saves")))
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
;; Better command

(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-use-virtual-buffers t)
(ido-ubiquitous-mode 1)

;; Mouse/Keyboard
(setq mouse-wheel-progressive-speed nil)
(global-set-key (kbd "C-<wheel-up>") 'text-scale-increase)
(global-set-key (kbd "C-<wheel-down>") 'text-scale-decrease)
(global-set-key (kbd "M-<wheel-right>") 'next-buffer)
(global-set-key (kbd "M-<wheel-left>") 'previous-buffer)

(global-set-key [home] 'move-beginning-of-line)
(global-set-key [end] 'move-end-of-line)


;; Use Custom versions
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; Custom: restclient
(load "restclient") 

;;;;;;;;;;;;;;;;;;;;
;; GLOBAL CONFIGS ;;
;;;;;;;;;;;;;;;;;;;;
(require 'dired )
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(put 'dired-find-alternate-file 'disabled nil)

(setq org-log-done 'time)

(setq ns-right-alternate-modifier nil)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'multiple-cursors)
(global-set-key (kbd "C->")   'mc/mark-next-like-this)
(global-set-key (kbd "C-M->") 'mc/unmark-next-like-this)
(global-set-key (kbd "C-<")   'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-<") 'mc/unmark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(company-quickhelp-mode 1)
(global-set-key (kbd "C-M-?") 'company-complete)
(setq company-quickhelp-delay 0.01)
(require 'smartparens-config)
(require 'paredit)
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)

(defvar paulo/pretty-symbols
  '(("sum" . 931) 
    ("integral" . 643)  
    ("not" . 172) 
    ("empty" . 216) 
    ("forall" . 8704) 
    ("exists" . 398) 
    ("infinite" . ?∞)  
    ("death" . ?☠)
    ("radioactive" . ?☢)
    ("biohazard"  . ?☣) 
    ("caduceus" . ?☤) 
    ("recycle" . ?♲)
    ("<=" . ?⩽) 
    (">=" . ?⩾)
    ("alpha" .  ?α )   
    ("beta" .  ?β )   
    ("gamma" .  ?γ )   
    ("delta" .  ?δ )   
    ("epsilon" .  ?ε )   
    ("zeta" .  ?ζ )   
    ("eta" .  ?η )   
    ("theta" .  ?θ )   
    ("iota" .  ?ι )   
    ("kappa" .  ?κ )   
    ("lambda" .  ?λ )
    ("fn" .  ?λ )
    
    ("mu" .  ?μ )   
    ("nu" .  ?ν )   
    ("xi" .  ?ξ )   
    ("omicron" .  ?ο )   
    ("pi" .  ?π )   
    ("rho" .  ?ρ )   
    ("final sigma" .  ?ς )   
    ("tau" .  ?τ )   
    ("upsilon" .  ?υ )   
    ("phi" .  ?φ )   
    ("chi" .  ?χ )   
    ("psi" .  ?ψ )   
    ("omega" .  ?ω )   
    ("not-exists" .  ?∄ )
    ("intersection" .  ?⋂ )
    ("union" .  ?⋃ )
    ("join" .  ?⨝ )
    ("belongs" .  ?∈ )
    ("not-belongs" .  ?∉ )
    ("subset" .  ?⊂ )
    ("superset" . ?⊃)
    ("not-subset" .  ?⊄ )
    ("not-superset" . ?⊅)
    ("not=" .  ?≠ ) 
    ("product" .  ?∏ )
    ("derivate" .  ?∂ )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Show line numbers
(global-linum-mode)
(menu-bar-mode 1)
(when (fboundp 'tool-bar-mode) 
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Color Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night-bright t)

;; interaction with operating system
(setq 
 x-select-enable-clipboard t
 x-select-enable-primary t
 save-interprogram-paste-before-kill t
 apropos-do-all t
 mouse-yank-at-point t)

(blink-cursor-mode 0)
(setq-default frame-title-format "%b (%f)")
(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)

(put 'erase-buffer 
     'disabled 
     nil)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse    
(setq scroll-step 1) ;; keyboard scroll one line at a time

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LISP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(show-paren-mode 1)
(setq show-paren-delay 0)
(require 'cider)

(setq cider-repl-display-help-banner nil)

(require 'rainbow-delimiters)
(dolist 
    (a-lisp-mode '(emacs-lisp-mode-hook
                   eval-expression-minibuffer-setup-hook
                   ielm-mode-hook                       
                   lisp-mode-hook                       
                   lisp-interaction-mode-hook           
                   scheme-mode-hook
                   clojure-mode-hook
                   cider-repl-mode-hook
                   cider-mode-hook)) 
  (progn 
    (add-hook a-lisp-mode  #'paredit-mode)
    (add-hook a-lisp-mode  #'turn-on-eldoc-mode)
    (add-hook a-lisp-mode  'rainbow-delimiters-mode)))

(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.pxi\\'" . clojure-mode))
(setq cider-show-error-buffer t)
(setq cider-auto-select-error-buffer t)
(setq cider-repl-history-file "~/.emacs.d/cider-history")
(setq cider-repl-wrap-history t)
(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")

(setq inf-clojure-program "planck")
(setq inf-clojure-lein-cmd "planck")
(setq inf-clojure-boot-cmd "planck") 
(setq inf-clojure-generic-cmd "planck")
(add-hook 'inf-clojure-mode-hook #'eldoc-mode)

(set-default 'truncate-lines nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (anaconda-mode dockerfile-mode docker docker-compose-mode smart-mode-line-powerline-theme powerline csv-mode csv vlf ido-ubiquitous graphviz-dot-mode js2-mode magit jq-mode smex smartparens rainbow-delimiters paredit multiple-cursors inf-clojure company-quickhelp cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'upcase-region 'disabled nil)
