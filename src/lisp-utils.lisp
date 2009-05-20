(defpackage :org.altervista.rjack.lisp-utils
  (:use :common-lisp)
  (:export :seq))


(defun seq (from to &key (continue? #'<)
	                 (add? (lambda (x)
				 (declare (ignore x))
				 t))
                         (next #'1+)
	                 (acc (list)))
  "Examples:
     (seq 0 10)                              =>   (0 1 2 3 4 5 6 7 8 9)
     (seq 0 20 :add? #'evenp)                =>   (0 2 4 6 8 10 12 14 16 18)
     (seq 4 -3 :continue? #'>= :next #'1-)   =>   (4 3 2 1 0 -1 -2 -3)"
  (if (funcall continue? from to)
      (seq (funcall next from) to :continue? continue? :next next
	   :add? add? :acc (if (funcall add? from)
			       (cons from acc)
			       acc))
      (nreverse acc)))
