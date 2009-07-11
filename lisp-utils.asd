(defpackage :org.altervista.rjack.lisp-utils.asd
  (:nicknames :rjack-utils.asd)
  (:use :cl :asdf))

(in-package :rjack-utils.asd)


(defsystem lisp-utils
    :name "lisp-utils"
    :author "Giacomo Ritucci"
    :version "0.1"
    :license "2 clauses BSD style, see COPYING file for details"
    :components ((:file "lisp-utils")))
