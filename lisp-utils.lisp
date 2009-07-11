(defpackage :org.altervista.rjack.lisp-utils
  (:nicknames :rlu)
  (:use :common-lisp)
  (:export :seq :split))



(in-package :rlu)


;;; Numbers


(defun random-between (a b &optional (random-state *random-state*))
  "Contract: number number random-state -> number

   Purpose: to return a random number in the [a b] interval.

   Notes: if a > b, the result is undefined."
  (+ a (random (- (1+ b)
		  a)
	       random-state)))




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




;;; Strings


(defun split (str &optional (sep-bag " "))
  (labels ((separator-p (c)
	     (find c sep-bag))
	   (parse (str &optional (cut-start 0) (substrings (list)))
	     (let ((cut-end (position-if #'separator-p str :start cut-start)))
	       (if (null cut-end)
		   (nreverse (cons (subseq str cut-start (length str))
				   substrings))
		   (parse str (1+ cut-end)
			  (cons (subseq str cut-start cut-end)
				substrings))))))
    (parse str)))
