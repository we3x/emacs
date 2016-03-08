; -*-Lisp-*-
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; start with maximized window
(setq package-enable-at-startup nil)

(defun ensure-package-installed (&rest packages)
  "Ensure every package is installed, ask for installation if it’s not.
   Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;; Assuming you wish to install "iedit" and "magit"
(ensure-package-installed
 'ag
 'company
 'company-tern
 'emmet-mode
 'evil
 'exec-path-from-shell
 'flycheck
 'helm
 'helm-ag
 'helm-projectile
 'helm-swoop
 'js2-highlight-vars
 'js2-mode
 'magit
 'markdown-mode
 'mode-icons
 'neotree
 'org
 'org-plus-contrib
 'php-mode
 'powerline
 'projectile
 'scss-mode
 'twittering-mode
 'web-mode
 'xkcd
 'yaml-mode)

(setq org-agenda-files (list "~/Desktop/crawleyprint.org"))

(eval-after-load 'php-mode
  '(require 'php-ext))

(require 'php-mode)
(require 'powerline)
(require 'xkcd)
(require 'evil)
(require 'helm-config)
(require 'js2-mode)
(require 'neotree)
(require 'js2-highlight-vars)
(require 'web-mode)

(autoload 'scss-mode "scss-mode")
(autoload 'js2-highlight-unused-variables-mode "js2-mode" "\
  Toggle highlight of unused variables.
  \(fn &optional ARG)" t nil)
(autoload 'tern-mode "tern.el" nil t)

(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; EVIL settings
(evil-mode t)

;; Add filetype icons to helm
(mode-icons-mode)

;; js2 configuration
(setq js2-basic-offset 4)
(setq js2-highlight-external-variables nil)
(setq js2-highlight-level 3)
(setq js2-mirror-mode nil)
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)
(setq js2-pretty-multiline-declarations t)
(setq twittering-use-master-password t)

;; turn off toolbar
(tool-bar-mode -1)
;; turn scroll bar
(scroll-bar-mode -1)
;; enable flycheck syntax checker
(global-flycheck-mode)
;; Powerline settings
(powerline-center-evil-theme)
;; start server so emacsclient can send files
(server-start)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set and saved directly from Emacs GUI. Magic, don't touch
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (misterioso)))
 '(js-indent-level 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make that freakin' beeper silent
(setq ring-bell-function 'ignore)
;; Highlight matching parenthesis
(setq-default show-paren-mode t)
;; Do not compile scss files on save
(setq-default scss-compile-at-save nil)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-p") 'helm-mini)
(global-set-key (kbd "M-o") 'helm-projectile)
(global-set-key (kbd "M-[") 'helm-projectile-ag)
(global-set-key (kbd "M-]") 'helm-swoop)
(global-set-key (kbd "M-i") 'neotree-toggle)
(global-set-key (kbd "M-I") 'neotree-change-root)

;; Initialize emacs with $PATH I use for shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Turn off line wrapping
(set-default 'truncate-lines t)
(setq truncate-partial-width-windows nil)

;; Turn on highlighting of current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")
(set-face-attribute 'region nil :background "#777")
(set-face-foreground 'highlight nil)
;; Turn on line numbers
(global-linum-mode t)





;; INDENTATION
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(defun my-setup-indent (n)
  ;; java/c/c++
  (setq c-basic-offset n)
  ;; web development
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n) ; css-mode
)

;; prog-mode-hook requires emacs24+
(setq-default evil-shift-width 2)

(defun init-code-style ()
  (interactive)
  (message "My personal code style!")
  (setq indent-tabs-mode nil) ; use space instead of tab
  (my-setup-indent 2) ; indent 2 spaces width
  )

 (custom-set-faces
   '(my-tab-face            ((((class color)) (:background "grey10"))) t)
   '(my-trailing-space-face ((((class color)) (:background "gray10"))) t)
   '(my-long-line-face ((((class color)) (:background "gray10"))) t))

;; Better syntax highlighting in some modes
(setq web-mode-engines-alist '(("php"    . "\\.phtml\\'") ("blade"  . "\\.blade\\.")))

;; Load code style configuration
(add-hook 'prog-mode-hook 'init-code-style)
;; configure autocompletion
(add-hook 'after-init-hook 'global-company-mode)

;; setup different coloring for tabs, trailing spaces and lines longer than 120 chars
(add-hook 'font-lock-mode-hook
  (function
    (lambda ()
      (setq font-lock-keywords
        (append font-lock-keywords
          '(("\t+" (0 'my-tab-face t))
            ("^.\\{121,\\}$" (0 'my-long-line-face t))
            ("[ \t]+$"      (0 'my-trailing-space-face t))))))))

;; Configure neotree
(add-hook 'neotree-mode-hook
    (lambda ()
      (setq neo-smart-open t)
      (setq neo-window-position 'right)
      (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
      (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
      (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
      (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

