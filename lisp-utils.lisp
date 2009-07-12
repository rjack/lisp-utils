;; Copyright (C) 2009  Giacomo Ritucci

;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;;
;;   1. Redistributions of source code must retain the above copyright
;;      notice, this list of conditions and the following disclaimer.
;;   2. Redistributions in binary form must reproduce the above
;;      copyright notice, this list of conditions and the following
;;      disclaimer in the documentation and/or other materials
;;      provided with the distribution.
;;
;; THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
;; WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
;; OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
;; DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
;; INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
;; STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
;; OF THE POSSIBILITY OF SUCH DAMAGE.


(defpackage :org.altervista.rjack.lisp-utils
  (:nicknames :rlu)
  (:use :common-lisp)
  (:export :random-between
	   :collect
	   :seq :split))


(in-package :rlu)



;;; Numbers


(defun random-between (a b &optional (random-state *random-state*))
  "Contract: number number random-state -> number

   Purpose: to return a random number in the [a b] interval.

   Notes: if a > b, the result is undefined."

  (+ a (random (- (1+ b)
		  a)
	       random-state)))



;;; Lists

(defun collect (size fn)
  "Contract: (integer 0) function -> list

   Purpose: to return a list of length SIZE filled with the results of
            SIZE invocations of FUNCTION."

  (declare ((integer 0) size)
	   (function fn))
  (loop :repeat size
     :collecting (funcall fn)))



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
