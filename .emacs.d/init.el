(require 'package) ;; You might already have this line

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3") ;; work around bug in emacs 26.2

(package-initialize)
(package-refresh-contents)

(setq inhibit-startup-screen t)

; use C-\ to switch layouts
(setq default-input-method "cyrillic-jcuken")

(package-install 'intero)
(add-hook 'haskell-mode-hook 'intero-mode)

(package-install 'typescript-mode)
(package-install 'angular-mode)

(package-install 'bookmark+)
(require 'bookmark+)
(edit-bookmarks)
(switch-to-buffer "*Bookmark List*")

;; (require 'windcycle)
;; (require 'transpose-frame)

(package-install 'evil)
(require 'evil)
(evil-mode t)
(setq evil-want-fine-undo t)

(ido-mode t)

(require 'linum)
(global-linum-mode t)
;; use customized linum-format: add an additional space after the line number
(setq linum-format (lambda (line)
                     (propertize (format (let ((w (length (number-to-string
                                                            (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))
(column-number-mode t)

(global-auto-revert-mode)

(global-set-key (kbd "M-l") 'helm-buffers-list)

(package-install 'free-keys)
(require 'free-keys)

;;(setq make-backup-files nil)
(setq backup-directory-alist '(("." . "~/emacs-backups")))

(tool-bar-mode -1)
(menu-bar-mode -1)

(package-install 'rainbow-delimiters)
(require 'rainbow-delimiters)
;; (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(rainbow-delimiters-mode t)

(package-install 'buffer-move)
(require 'buffer-move)
(global-set-key (kbd "<M-up>")     'buf-move-up)
(global-set-key (kbd "<M-down>")   'buf-move-down)
(global-set-key (kbd "<M-left>")   'buf-move-left)
(global-set-key (kbd "<M-right>")  'buf-move-right)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(bmkp-last-as-first-bookmark-file "/home/sergii/.emacs.d/bookmarks")
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (deeper-blue)))
 '(idris-interpreter-path "/home/sergii/.cabal/bin/idris")
 '(package-selected-packages
   (quote
    (tide js2-mode imenu-anywhere imenu+ icicles json-mode csv-mode fill-column-indicator color-theme purescript-mode eclim helm ## jdee rtm idris-mode rust-mode haskell-emacs highlight-symbol haskell-mode popup-complete jedi dired+ buffer-move buffer-flip wgrep bookmark+ rainbow-delimiters minimap auto-complete flycheck rtags magit powerline-evil window-numbering evil elpy clojure-mode-extra-font-locking clojure-cheatsheet)))
 '(save-place t nil (saveplace))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "PfEd" :slant normal :weight normal :height 100 :width normal)))))

(require 'color-theme)
(setq color-theme-is-global t)
(eval-after-load "color-theme" (color-theme-initialize))
(if window-system
    () ;; (color-theme-deep-blue)   ;; Emacs in own window
    (color-theme-tty-dark) ;; Emacs in tty
)

(defun my-common-mode-hook()
  ;; make undescore be considered a part of a word (make '*' highlight full identifiers, move faster etc.)
  (modify-syntax-entry ?_ "w")
  (highlight-regexp "ASAP" 'hi-yellow)
  (highlight-regexp "\!\!\!" 'hi-yellow)
  (highlight-regexp "FIXME" 'hi-yellow)
  (highlight-regexp "self" 'hi-blue-b)
  (highlight-regexp "this" 'hi-blue-b)
  (highlight-regexp "return" 'hi-green-b)
)

(add-hook 'java-mode-hook 'my-common-mode-hook)
(add-hook 'typescript-mode-hook 'my-common-mode-hook)
(add-hook 'c-mode-hook 'my-common-mode-hook)
(add-hook 'c++-mode-hook 'my-common-mode-hook)
(add-hook 'python-mode-hook 'my-common-mode-hook)
(add-hook 'ruby-mode-hook 'my-common-mode-hook)
(add-hook 'js2-mode-hook 'my-common-mode-hook)

;; (add-hook 'c-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; (add-hook 'c++-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; (add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; (add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; (add-hook 'js2-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;; (defun my-global-hook (filename)
;;   (highlight-phrase FIXME))
;; 
;; (add-hook 'after-load-functions 'my-global-hook)

;; (defun my-project-hook (filename)
;;   (when (string= (file-name-nondirectory filename) "project.clj")
;;     (do-stuff)))
;; 
;; (add-hook 'after-load-functions 'my-project-hook)

;;(add-hook 'c-mode-hook 'fci-mode)(require 'column-marker)
;;(add-hook 'foo-mode-hook (lambda () (interactive) (column-marker-1 80)))
;;(global-set-key [?\C-c ?m] 'column-marker-1)

(defun my-c-mode-common-hook ()
 (c-set-offset 'substatement-open 0)

 (setq c++-tab-always-indent t)
 (setq c-basic-offset 4)
 (setq c-indent-level 4)

 (setq indent-tabs-mode nil)
 (setq tab-width 4)
 ;; (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
 )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(package-install 'fill-column-indicator)
(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "darkblue")
;; (add-hook 'c-mode-hook 'fci-mode)
(add-hook 'prog-mode-hook 'fci-mode)
;; (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode t)))
;; (global-fci-mode t)

(elpy-enable)

(global-set-key (kbd "M-]") 'elpy-goto-definition)
(global-set-key (kbd "M-[") 'elpy-goto-definition-other-window)

(setq elpy-rpc-python-command "/usr/bin/python3")
(elpy-use-cpython "/usr/bin/python3")

(setq elpy-rpc-backend "jedi")

;; Elpy key bindings and functions:
;; ---------------------------------
;; C-c C-f (elpy-find-file)
;; C-c C-s (elpy-rgrep-symbol)
;; M-x elpy-set-project-root
;; elpy-project-ignored-directories (Customize Option)
;; elpy-project-root-finder-functions (Customize Option)
;; M-x elpy-set-project-variable
;; M-TAB (elpy-company-backend)
;; M-. (elpy-goto-definition)
;; C-x 4 M-. (elpy-goto-definition-other-window)
;; M-* (pop-tag-mark)
;; C-c C-o (elpy-occur-definitions)
;; C-c C-n (elpy-flymake-next-error)
;; C-c C-p (elpy-flymake-previous-error)
;; C-c C-v (elpy-check)
;; python-check-command (Customize Option)
;; C-c C-d (elpy-doc)
;; C-c C-t (elpy-test)
;; M-x elpy-set-test-runner
;; C-c C-e (elpy-multiedit-python-symbol-at-point)
;; C-c C-r f (elpy-format-code)
;; C-c C-r i (elpy-importmagic-fixup)
;; C-c C-r r (elpy-refactor)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(setq py-python-command "/usr/bin/python3")

;; ensure that we use only rtags checking
;; https://github.com/Andersbakken/rtags#optional-1
(defun setup-flycheck-rtags ()
  (interactive)
  (flycheck-select-checker 'rtags)
  ;; RTags creates more accurate overlays.
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

;; only run this if rtags is installed
(when (require 'rtags nil :noerror)
  ;; make sure you have company-mode installed
  (require 'company)
  ;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
  ;; (define-key prelude-mode-map (kbd "C-c r") nil)
  ;; install standard rtags keybindings. Do M-. on the symbol below to
  ;; jump to definition and see the keybindings.
  (rtags-enable-standard-keybindings)
  ;; comment this out if you don't have or don't use helm
  (setq rtags-use-helm t)
  ;; company completion setup
  (setq rtags-autostart-diagnostics t)
  (rtags-diagnostics)
  (setq rtags-completions-enabled t)
  (push 'company-rtags company-backends)
  (global-company-mode)
  (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
  ;; use rtags flycheck mode -- clang warnings shown inline
  (require 'flycheck-rtags)
  ;; c-mode-common-hook is also called by c++-mode
  (add-hook 'c-mode-common-hook #'setup-flycheck-rtags)

  (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
  (add-hook 'c++-mode-common-hook 'rtags-start-process-unless-running)

  (define-key c-mode-base-map (kbd "M-]")
    (function rtags-find-symbol-at-point))
  (define-key c-mode-base-map (kbd "M-[")
    (function rtags-find-references-at-point))
)

(add-hook 'prog-mode-hook 'highlight-symbol-mode)

;; packages to install:
;; -------------------
;; rainbow-delimiters
;; flycheck
;; rtags
;; elpy
;; minimap-mode
;; bookmark+
;; free-keys
;; company-mode
;; buffer-move
;; fill-column-indicator
;; dired+
;; jedi
;; highlight-symbol
