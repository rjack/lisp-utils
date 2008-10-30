;;; Functions

(defun simple-function (a b)
  "This is a simple function that takes 2 parameters.
  The body is a list of expressions that are evaluated in order.
  The value of the last expression is the one that's returned by the
  function."
  (incf a)
  (incf b)
  (= a b))



(defun optional-parameters (a &optional b c (d 5 d-supplied-p) e)
  "Function with optional parameters: b, c, d and e are optional.
  If not specified by the caller their value will be NIL, except for d that
  will receive 5 as default."
  (list a b c (list d d-supplied-p) e))


(defun variable-argument-list (a b c &rest args)
  "This function takes three parameters or more"
  (+ a b c (reduce (function +) args)))


(defun keywords (&key (a 0) (b 0 b-supplied-p) (c (+ a b)))
  (list a b c b-supplied-p))


(defun keywords-decoupled (&key ((:apple a) 0)
				((:beta b) 0 b-supplied-p)
				((:cleo c) (+ a b)))
  (list a b c b-supplied-p))
