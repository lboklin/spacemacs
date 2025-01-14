;;; packages.el --- mercury layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Ludvig Böklin <ludvig.boklin@protonmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `mercury-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `mercury/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `mercury/pre-init-PACKAGE' and/or
;;   `mercury/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst mercury-packages
  '((metal-mercury-mode :location (recipe
                                   :fetcher github
                                   :repo "ahungry/metal-mercury-mode"
                                   :commit "99e2d8fb7177cae3bfa2dec2910fc28216d5f5a8"))
    (mercury-mode :excluded t)
    flycheck
    (flycheck-mercury :requires flycheck)
    smartparens))

(defun mercury/post-init-flycheck ()
  (add-hook 'metal-mercury-mode-hook 'flycheck-mode))

(defun mercury/init-flycheck-mercury ()
  "Initialize flycheck-mercury"
  (use-package flycheck-mercury
    :defer t
    :init (require 'flycheck-mercury)))

(defun mercury/init-metal-mercury-mode ()
  "Initialize metal-mercury-mode"
  (use-package metal-mercury-mode
    :defer t
    :init
    :mode ("\\.m\\'" . metal-mercury-mode)
    :config
    (progn
      (dolist (x '(
                   ;; ("m=" . "format")
                   ("mc" . "mercury/compile")
                   ;; ("mh" . "help")
                   ))
        (spacemacs/declare-prefix-for-mode 'metal-mercury-mode (car x) (cdr x)))

      (spacemacs/set-leader-keys-for-major-mode 'metal-mercury-mode
        ;; make
        "cb" 'metal-mercury-mode-compile
        "cr" 'metal-mercury-mode-runner))))

(defun mercury/post-init-smartparens ()
  (if dotspacemacs-smartparens-strict-mode
      (add-hook 'metal-mercury-mode-hook #'smartparens-strict-mode)
    (add-hook 'metal-mercury-mode-hook #'smartparens-mode)))

;;; packages.el ends here

