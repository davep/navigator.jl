;;; navigator.jl --- Functions for working with Netscape Navigator.
;; Copyright 2001 by Dave Pearson <davep@davep.org>
;; $Revision: 1.1 $

;; navigator.jl is free software distributed under the terms of the GNU
;; General Public Licence, version 2. For details see the file COPYING.

;;; Commentary:
;;
;; The following functions provide a method if finding netscape windows and
;; working with them (currently the only thing you can do is get at an URL,
;; if I find other useful things I'll add them).
;;
;; I find `navigator-url' really useful in conjunction with sawfish.el
;; <URL:http://www.davep.org/emacs/sawfish.el> and emacs. Using code like
;; this:
;; 
;; (defun insert-navigator-url ()
;;   "Insert the URL that Netscape Navigator is looking at.
;; 
;; Note that the URL of the first Navigator window found is inserted."
;;   (interactive)
;;   (let ((url (sawfish-code (navigator-url))))
;;     (when url
;;       (insert url))))
;;
;; in emacs I can bind a key that inserts the URL that the first navigator
;; window is looking at.

;; This code requires <URL:http://www.davep.org/sawfish/wclass.jl>.
(require 'wclass)

(defun navigator-find ()
  "Find the first netscape navigator window"
  (wclass-find-first-window-of-class "Navigator" "Netscape"))

(defun navigator-url (#!optional navigator)
  "Return the URL that NAVIGATOR is browsing.

If NAVIGATOR is not supplied then the URL of the first Netscape Navigator
window that can be found will be returned.

If no Navigator window can be found NIL will be returned."
  (let ((nav-window (or navigator (navigator-find))))
    (when nav-window
      (aref (get-x-text-property nav-window '_MOZILLA_URL) 0))))
