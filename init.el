;; (set debug-on-error t)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load-file "~/.emacs.d/super-emacs/repositories.el")
(load-file "~/.emacs.d/super-emacs/packages.el")
(load-file "~/.emacs.d/super-emacs/interface.el")
(load-file "~/.emacs.d/super-emacs/misc.el")
(load-file "~/.emacs.d/super-emacs/key-bindings.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (lua-mode magit google-c-style flymake-cursor flymake-google-cpplint iedit auto-complete-c-headers yasnippet cuda-mode helm ztree ws-butler use-package undo-tree theme-looper switch-window solarized-theme smartparens projectile powerline myterminal-controls multiple-cursors multi-term meta-presenter material-theme ido-vertical-mode ido-ubiquitous helm-ag git-gutter+ flycheck flx-ido elpy ein direx dired-open dired+ clean-aindent-mode buffer-move auto-complete ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
