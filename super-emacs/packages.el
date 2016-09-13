;Create repositories cache, if required
(when (not package-archive-contents)
  (package-refresh-contents))

;Declare a list of required packages
(defvar super-emacs--required-packages
  '(use-package
    helm
    multiple-cursors
    ace-jump-mode
    powerline
    switch-window
    buffer-move
    auto-complete
    ztree
    undo-tree
    material-theme
    meta-presenter
    myterminal-controls
    theme-looper))

;Install required packages
(mapc (lambda (p)
        (package-install p))
      super-emacs--required-packages)

;;Load default auto-complete configs
(use-package auto-complete
  :config
  (ac-config-default))


;;Start undo-tree
(use-package undo-tree
  :bind (("M-/" . undo-tree-visualize))
  :config
(global-undo-tree-mode))

(use-package ace-jump-mode
  :commands ace-jump-mode
  :init
  (bind-key "C-." 'ace-jump-mode))

;Enable powerline
(use-package powerline
  :config
  (powerline-center-theme)
  ;(setq powerline-default-separator 'wave)
)


;;Configure theme-looper
(use-package theme-looper
  :bind (("C-\"" . theme-looper-enable-next-theme))
  :config
  (theme-looper-set-theme-set '(deeper-blue
                                wheatgrass
                                wombat
                                material
                                monokai
                                solarized-dark
                                solarized-light))
  (theme-looper-set-customizations 'powerline-reset))

;Configure myterminal-controls
(use-package myterminal-controls
  :commands myterminal-controls-open-controls
  :bind (("C-M-'" . myterminal-controls-open-controls))
  :config
  (myterminal-controls-set-controls-data
   '(("t" "Change color theme" theme-looper-enable-next-theme)
     ("r" "Reload file" super-emacs-reload-current-file))))

;; config helm
(use-package helm
  :init
  :bind (("M-x" . helm-M-x)
    ("C-x b" . helm-mini)
    ("C-x C-b" . helm-buffers-list)
    ("C-x C-f" . helm-find-files)
    ("C-x C-r" . helm-recentf)
    ("M-y" . helm-show-kill-ring)
    ("C-c h" . helm-command-prefix)
    :map helm-map
    ;;("<tab>" . helm-execute-persistent-action)
    ("C-j" .  helm-execute-persistent-action)
    ("C-z" . helm-select-action))
  :config
  (helm-mode 1)
  (require 'helm-config)
  (helm-autoresize-mode t)
  (setq helm-split-window-in-side-p t
        ;helm-move-to-line-cycle-in-source t
        helm-ff-file-name-history-use-recentf t
        helm-ff-search-library-in-sexp t)
  (use-package helm-ag
    :ensure t)
  )


; multi term
(use-package multi-term
  :ensure t
  :bind (("C-x t" . multi-term))
  :config
  (require 'multi-term)
  (setq multi-term-program "/usr/bin/zsh")
  ;; set PS1
  (setq system-uses-terminfo nil)
  ;; tab complete
  (add-hook 'term-mode-hook
            (lambda()
              (setq yas-dont-activate t))))

;; dired


(use-package dired+
  :ensure t
  :config
  (require 'dired+))

(use-package dired-x
  :init 
  (add-to-list 'load-path "~/.emacs.d/elpa/direx-20151023.1606")
  :config
  (require 'dired-x))

;; (use-package dired-open
;;   :ensure t
;;   :config
;;   (require 'dired-open)

;; )
 (setq-default dired-listing-switches "-lha")

 (setq dired-clean-up-buffers-too t)

 (setq dired-recursive-copies 'always)

 (setq dired-recursive-deletes 'top)


;; ido
(use-package ido
  :ensure t
  :init  (setq ido-enable-flex-matching t
               ido-ignore-extensions t
               ido-use-virtual-buffers t
               ido-everywhere t)
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (add-to-list 'completion-ignored-extensions ".pyc")
  ;; don't confirm to create new buffers
  (setq ido-create-new-buffer 'always))

(use-package flx-ido
   :ensure t
   :init (setq ido-enable-flex-matching t)
   :config (flx-ido-mode 1))

(use-package ido-vertical-mode
  :ensure t
  :init               ; I like up and down arrow keys:
  (setq ido-vertical-define-keys 'C-n-C-p-up-and-down)
  :config
  (ido-vertical-mode 1))

(use-package ido-ubiquitous
  :ensure t
  :config
  (ido-ubiquitous))



;; Package: smartparens
(use-package smartparens
  :ensure t
  :config
  (use-package dash
    :ensure t)
  (require 'smartparens-config)
  (show-smartparens-global-mode +1)
  (smartparens-global-mode 1)
)
;; when you press RET, the curly braces automatically
;; add another newline
(sp-with-modes '(c-mode c++-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                            ("* ||\n[i]" "RET"))))

;; Package: clean-aindent-mode
(use-package clean-aindent-mode
  :ensure t
  :config
  (require 'clean-aindent-mode)
  (add-hook 'prog-mode-hook 'clean-aindent-mode))

;; Package: ws-butler
(use-package ws-butler
  :ensure t
  :config
  (require 'ws-butler)
  (add-hook 'c-mode-common-hook 'ws-butler-mode)
  (add-hook 'prog-mode-hook 'ws-butler-mode))

;; git-gutter+
(use-package git-gutter+
  :ensure t
  :config (global-git-gutter+-mode))

;; projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
)


;; execute in emacs
(setenv "PATH"
        (concat (getenv "PATH")
                ":" "/usr/local/bin"))

;; execute in emacs
(setenv "PATH"
        (concat (getenv "PATH")
                ":" "/home/sxwl1070/anaconda2/bin"))


;; execute in emacs
(setenv "PATH"
        (concat (getenv "PATH")
                ":" "/home/sxwl1070/anaconda3/bin"))


;; elpy

(use-package elpy
  :ensure t
  :config
  ;;  (define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
  (require 'elpy)
  (elpy-enable)
  (setq elpy-rpc-python-command "python")
  (elpy-use-ipython "ipython")

  ;;(setq elpy-rpc-backend "jedi")
  (setq elpy-rpc-backend "jedi")

;;  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
  (defun zl/switch-to-python3 ()
    (interactive)
    (setq elpy-rpc-python-command "python3")
    (elpy-use-ipython "ipython3"))
  (defun zl/switch-to-python2 ()
    (interactive)
    (setq elpy-rpc-python-command "python")
    (elpy-use-ipython "ipython"))
  (use-package flycheck
    :ensure t
    :config
    (require 'flycheck)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode)))

;; ein for ipython-notebook
(use-package ein
  :ensure t
  :config
  (require 'ein)
  (setq ein:use-auto-complete-superpack t)
  (setq ein:use-smartrep t))

;; yasnippet
(use-package yasnippet
  :ensure t
  :config
  (require 'yasnippet)
  (yas-global-mode 1))

;; cuda-mode
(use-package cuda-mode
  :ensure t
  :mode "\\.cu\\'")


;; auto-compelte-c-headers
(use-package auto-complete-c-headers
  :ensure t
  :config
  (defun zl:ac-c-header-init ()
    (add-to-list 'ac-sources 'ac-source-c-headers)
    (add-to-list 'achead:include-directories "/usr/include/c++/4.8")
    ;; (add-to-list 'achead:include-directories "/usr/local/cuda-8.0/include")
    ;; (add-to-list 'achead:include-directory '"/usr/include")
    )
  (defun zl:ac-cuda-header-init ()
    (add-to-list 'ac-sources 'ac-source-c-headers)
    (add-to-list 'achead:include-directories "/usr/include/c++/4.8")
    (add-to-list 'achead:include-directories "/usr/local/cuda-8.0/include")
    ;; (add-to-list 'achead:include-directory '"/usr/include")
    )
  ;; now let's call this function from c/c++ hooks
  (add-hook 'c++-mode-hook 'zl:ac-c-header-init)
  (add-hook 'c-mode-hook 'zl:ac-c-header-init)
  (add-hook 'c-mode-common-hook 'zl:ac-cuda-header-init)
  (add-hook 'cuda-mode-hook 'zl:ac-cuda-header-init))

;; iedit
(use-package iedit
  :ensure t
  :bind
  (("C-c ;" . iedit-mode)))

;; flymake-google-cpplint
;; install cpplint - pip install cpplint
(use-package flymake-google-cpplint
  :ensure t
  :config
  (defun zl:flymake-google-init ()
    (require 'flymake-google-cpplint)
    (custom-set-variables
     '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
    (flymake-google-cpplint-load)
    )
  (add-hook 'c-mode-hook 'zl:flymake-google-init)
  (add-hook 'c++-mode-hook 'zl:flymake-google-init)
  ;; cpplint can't support cuda
  ;; (add-hook 'cuda-mode-hook 'zl:flymake-google-init)
  )

;; flymake-cursor
(use-package flymake-cursor
  :ensure t)

;; google-c-style
(use-package google-c-style
  :ensure t
  :config
  (require 'google-c-style)
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent))

;; installing CEDET mode for true intellisense builtin package
(use-package cedet
  :config
  ;; turn on Semantic
  (semantic-mode 1)
  ;; let's define a function which adds semantic as a suggestion backend to
  ;; auto complete and hook this function to c-mode-common-hook
  (defun zl:add-semantic-to-autocomplete ()
    (add-to-list 'ac-sources 'ac-source-semantic)
    )
  (add-hook 'c-mode-common-hook 'zl:add-semantic-to-autocomplete)
  ;; turn on ede mode
  (global-ede-mode 1)
  ;; create a project for our program.
  (ede-cpp-root-project "my project" :file "/root/dl-data/zhangli/my_program/src/main.cpp"
                        :include-path '("/usr/local/cuda-8.0/include"))

  (global-semantic-idle-scheduler-mode 1)
  ;; add system <> include auto complete
  (semantic-add-system-include "/usr/local/cuda-8.0/include" 'cuda-mode)
  (semantic-add-system-include "/usr/local/cuda-8.0/include" 'c++-mode)
  (semantic-add-system-include "/usr/local/cuda-8.0/include" 'c-mode)

  )

;; magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; lua-mode
(use-package lua-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  :bind
  (
   :map lua-mode-map
        ("C-<return>" . lua-send-current-line)
        ("C-c C-c" . lua-send-region)
        ("C-M-x" . lua-send-defun)
  )
)

(use-package git-gutter+
  :ensure t
  :config (global-git-gutter+-mode)
)
