;;; init.el --- -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;;; emacs settings
(setq package-native-compile t)
(setq comp-deferred-compilation t)
(setq gc-cons-threshold 100000000)

(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

(setq create-lockfiles nil)
(setq backup-inhibited t)
(setq auto-save-default nil)
(global-auto-revert-mode)

(setq warning-minimum-level :emergency)
(global-set-key [escape] 'keyboard-escape-quit)

(global-display-line-numbers-mode)
(global-hl-line-mode)

(fset 'yes-or-no-p 'y-or-n-p)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-frame-font "Iosevka Fixed 11")
(add-to-list 'default-frame-alist '(font . "Iosevka Fixed 11"))
(set-face-attribute 'default t :font "Iosevka Fixed 11")

;;; package settings
(unless (package-installed-p 'leaf)
  (package-refresh-contents)
  (package-install 'leaf))

(leaf leaf-keywords
  :ensure t
  :config
  (leaf-keywords-init))

(leaf dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

(leaf ivy
  :ensure ivy counsel
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-wrap t)
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (setq ivy-use-selectable-prompt t)
  (global-set-key (kbd "M-x") 'counsel-M-x))

(leaf evil
  :ensure t
  :config
  (evil-mode 1)
  (setq evil-undo-system 'undo-tree)
  )

(leaf powerline-evil
  :ensure t
  :config
  (powerline-evil-vim-color-theme))

(leaf undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  (define-key evil-normal-state-map (kbd "u")   'undo-tree-undo)
  (define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)
  (setq undo-tree-auto-save-history nil))

(leaf flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(leaf company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  ;; (define-key company-active-map (kbd "TAB") 'company-complete)
  )

(leaf direnv
  :ensure t
  :config
  (direnv-mode))

(leaf magit
  :ensure t)

(leaf lsp-mode
  :ensure t
  :config
  ;; (add-hook 'prog-mode-hook 'lsp-deferred)
  :hook
  (haskell-mode-hook . lsp)
  (haskell-literate-mode-hook . lsp))

; Haskell
(leaf haskell-mode
  :ensure t)

(leaf lsp-haskell
  :ensure t)

; Coq
(leaf proof-general
  :ensure t
  :config
  (setq proof-splash-enable nil)
  (add-hook 'coq-mode-hook (lambda () (undo-tree-mode 1))))

(leaf company-coq
  :ensure t
  :config
  (add-hook 'coq-mode-hook #'company-coq-mode))

; Rust
(leaf rust-mode
  :ensure t)

; Nix
(leaf nix-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode)))

; Agda
(defun init-agda-mode ()
  "Initialize agda-mode."
  (interactive)
  (load-file (let ((coding-system-for-read 'utf-8))
  	       (shell-command-to-string "agda-mode locate"))))

(setq agda-input-user-translations
      `(("yo", "よ")))

(provide 'init)
;;; init.el ends here
