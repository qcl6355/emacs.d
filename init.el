;;;;;;;;;;
;; elpa ;;
;;;;;;;;;;

(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

(unless package--initialized
  (package-initialize))

(when (null package-archive-contents)
  (package-refresh-contents))

;; add/remove any packages you like here
(dolist (package
         '(ido-ubiquitous
           magit
           markdown-mode
           smex
           yasnippet))
  (if (not (package-installed-p package))
      (package-install package)))

(global-set-key (kbd "C-c p") 'list-packages)

;;;;;;;;;;;;;;;;
;; fullscreen ;;
;;;;;;;;;;;;;;;;

(defcustom frame-maximization-mode 'maximized
  "The maximization style of \\[toggle-frame-maximized]."
  :type '(choice
          (const :tab "Respect window manager screen decorations." maximized)
          (const :tab "Ignore window manager screen decorations." fullscreen))
  :group 'frames)

(defun toggle-frame-maximized ()
  "Maximize/un-maximize Emacs frame according to `frame-maximization-mode'."
  (interactive)
  (modify-frame-parameters
   nil `((fullscreen . ,(if (frame-parameter nil 'fullscreen)
                            nil frame-maximization-mode)))))

(define-key global-map (kbd "C-s-f") 'toggle-frame-maximized)

;;;;;;;;;;
;; smex ;;
;;;;;;;;;;

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      ido-max-prospects 10)

(ido-mode 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; display & appearance ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq visible-bell t)
(setq inhibit-startup-message t)
(setq color-theme-is-global t)

(set-default 'indent-tabs-mode nil)
(set-default 'tab-width 2)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)

(show-paren-mode 1)
(column-number-mode 1)
(hl-line-mode t)

;; show time and battery status in mode line

(display-time-mode 1)
(setq display-time-format "%H:%M")
(display-battery-mode 1)

;; whitespace

(setq sentence-end-double-space nil)
(setq shift-select-mode nil)
(setq whitespace-style '(face trailing lines-tail tabs))
(setq whitespace-line-column 80)
(add-to-list 'safe-local-variable-values '(whitespace-line-column . 80))

;; mark region commands as safe

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; text mode tweaks

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(remove-hook 'text-mode-hook 'smart-spacing-mode)

;; file visiting stuff

(setq save-place t)
(setq save-place-file (concat user-emacs-directory "places"))
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
(setq recentf-max-saved-items 100)

(global-auto-revert-mode t)

;; other niceties

(add-to-list 'safe-local-variable-values '(lexical-binding . t))
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq diff-switches "-u")

(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)

(defalias 'yes-or-no-p 'y-or-n-p)

;; pretty lambdas

(add-hook 'prog-mode-hook
          '(lambda ()
             (font-lock-add-keywords
              nil `(("(?\\(lambda\\>\\)"
                     (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                               ,(make-char 'greek-iso8859-7 107))
                               nil)))))))

;;;;;;;;;;;;;;;;;
;; color theme ;;
;;;;;;;;;;;;;;;;;

;; uncomment these lines when you've found a theme you like (replace
;; `your-theme') and want to load it on startup.

(if (display-graphic-p)
    (load-theme 'monokai t))

;;;;;;;;;;;
;; faces ;;
;;;;;;;;;;;

;; to choose a font (and size), you can use this code

;; ;; font size
;; (setq base-face-height 200)
;; ;; monospace font
;; (set-face-attribute 'default nil :height base-face-height :family "Ubuntu Mono")
;; ;; variable-width font
;; (set-face-attribute 'variable-pitch nil :height base-face-height :family "Ubuntu")
;; set up package repository

;;; set default font
(set-default-font "Monaco-14")

;;; osx system
(when (eq system-type 'darwin)
  (setq mac-right-option-modifier 'control)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char)) ;;sets fn-delete to the right delete

;; --------------------- Boolean Settings ---------------------
(tool-bar-mode 0)
(menu-bar-mode 1)
(global-font-lock-mode t)
(set-language-environment "utf-8")

;; --------------------- Value Settings ---------------------
(setq kill-ring-max 3000)
(setq undo-limit 536000000)

;; --------------------- language modes ---------------------
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.el$" . emacs-lisp-mode))

;; shutdown backup
(setq make-backup-files nil)

;; snippet
(setq yas-global-mode 1)

;; org-page
(require 'org-page)
(setq op/repository-directory "/Users/Sheng/qcl6355.github.io")
(setq op/site-domain "qcl6355.github.io")
(setq op/personal-disqus-shortname "Sheng")
(setq op/personal-github-link "https://github.com/qcl6355")
;; (setq op/site-main-title "Sheng Li's Blog")
;; (setq op/site-sub-title "Ultimated Blade Works")
(setq op/theme 'kactus)

;; auto complete package
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; evil (use vim keymap in emacs)
(require 'evil)
(evil-mode 1)
;;;;;;;;;;;;;;;
;; extempore ;;
;;;;;;;;;;;;;;;

(setq user-extempore-directory "/usr/local/Cellar/extempore/0.53/")
;; this one will be helpful for a default homebrew install of extempore on OSX
;; (setq user-extempore-directory "/usr/local/Cellar/extempore/0.5.2/")

;; you can delete this once you've setup your extempore path
(if (string-equal user-extempore-directory "/path/to/extempore/")
    (if user-init-file
        (progn (find-file user-init-file)
               (search-forward "/path/to/extempore/" nil t 2)
               (error "You need to set your Extempore path!"))
      (error "You need to set your Extempore path!")))

;; load the emacs mode
(autoload 'extempore-mode (concat user-extempore-directory "extras/extempore.el") "" t)
(add-to-list 'auto-mode-alist '("\\.xtm$" . extempore-mode))

(autoload #'llvm-mode (concat user-extempore-directory "extras/llvm-mode.el")
  "Major mode for editing LLVM IR files" t)

(add-to-list 'auto-mode-alist '("\\.ir$" . llvm-mode))
(add-to-list 'auto-mode-alist '("\\.ll$" . llvm-mode))

;;;;;;;;;;
;; Scheme
;;;;;;;;;;

(require 'cmuscheme)
(setq scheme-program-name "/usr/local/bin/racket")

;; set parenface
(require 'paren-face)
(global-paren-face-mode t)

;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))

(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (delete-other-windows)
    (split-window-vertically (floor (* 0.68 (window-height))))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window 1))
   ((not (find "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))
               :test 'equal))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window -1))))

(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))

(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

(add-hook 'scheme-mode-hook
  (lambda ()
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))
