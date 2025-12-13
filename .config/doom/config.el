;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; JetBrainsMono Nerd Font (Ubuntu Font)
(setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Use bash internally
(setq shell-file-name (executable-find "bash")
      explicit-shell-file-name (executable-find "bash"))

;; Use fish in terminal emulators
(setq-default vterm-shell "/opt/homebrew/bin/fish") ; "/usr/bin/fish"

;; Forge
(setq auth-sources '("~/.authinfo"))
;;(setq auth-sources '("~/.authinfo.gpg"))

;; Deft
(setq deft-directory "~/deft/"
      deft-extensions '("org" "md" "txt")
      deft-recursive t)

;; Where to look for compiled grammars
(setq treesit-extra-load-path
      (delq nil
            (list
             (expand-file-name "tree-sitter" user-emacs-directory) ; ~/.config/emacs/tree-sitter
             (and (boundp 'doom-local-dir)
                  (expand-file-name "etc/treesit" doom-local-dir))))) ; ~/.emacs.d/.local/etc/treesit

;; Grammars' Sources
(setq treesit-language-source-alist
      '((bash        "https://github.com/tree-sitter/tree-sitter-bash" "v0.23.3")
        (c           "https://github.com/tree-sitter/tree-sitter-c" "v0.23.4")
        (cpp         "https://github.com/tree-sitter/tree-sitter-cpp")
        (cmake       "https://github.com/uyha/tree-sitter-cmake")
        (css         "https://github.com/tree-sitter/tree-sitter-css" "v0.23.1")
        (elixir      "https://github.com/elixir-lang/tree-sitter-elixir")
        (heex        "https://github.com/phoenixframework/tree-sitter-heex")
        (go          "https://github.com/tree-sitter/tree-sitter-go" "v0.23.3")
        (html        "https://github.com/tree-sitter/tree-sitter-html")
        (javascript  "https://github.com/tree-sitter/tree-sitter-javascript")
        (json        "https://github.com/tree-sitter/tree-sitter-json")
        ;; (lua      "https://github.com/tree-sitter/tree-sitter-lua")
        (lua         "https://github.com/Azganoth/tree-sitter-lua")
        (markdown    "https://github.com/ikatyang/tree-sitter-markdown") ; no built-in markdown-ts-mode
        (org         "https://github.com/milisims/tree-sitter-org")      ; no built-in org-ts-mode
        (python      "https://github.com/tree-sitter/tree-sitter-python" "v0.23.6")
        (qmljs       "https://github.com/yuja/tree-sitter-qmljs") ; needs external TS major mode
        (rust        "https://github.com/tree-sitter/tree-sitter-rust" "v0.23.2")
        ;; (solidity "https://github.com/soliditylang/tree-sitter-solidity") ; needs external TS major mode
        (solidity    "https://github.com/JoranHonig/tree-sitter-solidity" "v1.2.8")
        (toml        "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx         "https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src")
        (typescript  "https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src")
        (yaml        "https://github.com/ikatyang/tree-sitter-yaml")))

;; Remap classic modes to TS modes (only when available)
(dolist (pair '((c-mode          . c-ts-mode)
                (c++-mode        . c++-ts-mode)
                (python-mode     . python-ts-mode)
                (go-mode         . go-ts-mode)
                (js-mode         . js-ts-mode)
                (typescript-mode . typescript-ts-mode)
                (json-mode       . json-ts-mode)
                (js-json-mode    . json-ts-mode)
                (css-mode        . css-ts-mode)
                (sh-mode         . bash-ts-mode)
                (yaml-mode       . yaml-ts-mode)
                (toml-mode       . toml-ts-mode)
                (lua-mode        . lua-ts-mode)
                (emacs-lisp-mode . elisp-ts-mode)
                (elixir-mode     . elixir-ts-mode)
                (heex-mode       . heex-ts-mode)
                (rust-mode       . rust-ts-mode)
                (html-mode       . html-ts-mode)))
  (when (fboundp (cdr pair))
    (add-to-list 'major-mode-remap-alist pair)))

;; File associations
(add-to-list 'auto-mode-alist '("\\.\\(h\\|hh\\|hpp\\|hxx\\)\\'" . c++-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'"  . typescript-ts-mode))

;; NOTE: If you have a qml tree-sitter major mode package, map *.qml to it.
(add-to-list 'auto-mode-alist '("\\.qml\\'" . qml-mode))

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.cjs\\'" . js-ts-mode))

;; Setup Web LSPs
(after! eglot
  (add-to-list 'eglot-server-programs
               '((html-mode mhtml-mode web-mode html-ts-mode)
                 . ("vscode-html-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((css-mode css-ts-mode scss-mode scss-ts-mode less-css-mode)
                 . ("vscode-css-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((json-mode jsonc-mode json-ts-mode)
                 . ("vscode-json-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((yaml-mode yaml-ts-mode)
                 . ("yaml-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               `((elixir-mode elixir-ts-mode heex-mode heex-ts-mode)
                 . (,(expand-file-name "~/elixir-ls/release/language_server.sh"))))
  (add-to-list 'eglot-server-programs
               '((js-ts-mode tsx-ts-mode typescript-ts-mode)
                 . ("typescript-language-server" "--stdio"))))

;; Auto-attach Eglot
(dolist (mode '(yaml-mode yaml-ts-mode
                json-mode jsonc-mode json-ts-mode
                js-ts-mode tsx-ts-mode typescript-ts-mode
                html-mode html-ts-mode
                css-mode css-ts-mode))
  (add-hook (intern (format "%s-hook" mode)) #'eglot-ensure))

;; Mappings
(after! dired
  (map! :map dired-mode-map
        "C-c c" #'dired-create-empty-file))
