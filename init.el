(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("marmalede" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(package-install 'magit)

(package-install 'solarized-theme)

;;Enable solarized-light theme on init
(require 'solarized)

(deftheme solarized-light "The light variant of the Solarized colour theme")
(create-solarized-theme 'light 'solarized-light)
(provide-theme 'solarized-light)

(setq solarized-use-less-bold t)

(show-paren-mode 1)

;; start auto-complete with emacs
(require 'auto-complete)
;; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

;;define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/Library/Developer/CommandLineTools/usr/bin/../include/c++/v1"))
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;;fix bug for iedit mode in mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; start flymake-google-cpplint-load
;; lets define a function for flymake initialization
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (flymake-google-cpplint-load))
(add-hook 'c++-mode-hook 'my:flymake-google-init)
(add-hook 'c-mode-hook 'my:flymake-google-init)

;; start google-c-style with emacs
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;;turn on semantic mode for cedet
(semantic-mode 1)

;;define a function which adds semantic as a suggestion backend to auto-complete
;; and hook this function into c-mode-common-hook

(defun my:add-semantic-to-autocomplete ()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;;turn on ede mode
(global-ede-mode 1)
;;create a project for our program
(ede-cpp-root-project "my project" :file "~/practice/DP/tmp.cpp"
		      :include-path '(""))

;;turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)

(global-linum-mode 1)
(eval-after-load "linum"
  '(set-face-attribute 'linum nil
		       :height 120))

(global-wakatime-mode)
(set 'wakatime-api-key "fe815ec8-ff05-44e1-ad6c-30498d7cf182")
(set 'wakatime-cli-path "/Library/Python/2.7/site-packages/wakatime/cli.py")
