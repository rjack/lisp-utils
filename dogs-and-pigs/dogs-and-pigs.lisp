;;;; Dogs and pigs. A battle simulation.


(defparameter *skill-points* 40)

(defparameter *max-hit-points* 100)

(defparameter *min-hit-points* 50)


(defmacro random-range (from to)
  `(+ ,from (random (- ,to ,from))))


(defmacro with-all-accessors (obj cls &body body)
  `(with-accessors
     ,(map 'list
	   ; da un riferimento di slot ritorna una lista (nome nome)
	   (lambda (slot-ref)
	     (let ((slot-name (slot-definition-name slot-ref)))
	       (list slot-name slot-name)))
	   (class-slots (find-class cls)))
     ,obj ,@body))


(defclass animal ()

  ((name
     :initarg :name
     :accessor name)

   (quickness
     :initform 0
     :accessor quickness)

   (moves
     :initform 0
     :accessor moves)

   (strenght
     :initform 0
     :accessor strenght)

   (defense
     :initform 0
     :accessor defense)

   (hit-points
     :initform (random-range *min-hit-points* *max-hit-points*)
     :accessor hit-points)))


(defmethod initialize-instance :after ((this animal) &key)
  (with-all-accessors this animal
		      (do ((skill-points-left *skill-points* (1- skill-points-left)))
			((= 0 skill-points-left))
			(let ((skill (random 4)))
			  (cond ((= 0 skill) (incf quickness))
				((= 1 skill) (incf moves))
				((= 2 skill) (incf strenght))
				((= 3 skill) (incf defense)))))))


(defmethod my-print ((this animal))
  (with-all-accessors this animal
    (format t "~a:~%" name)
    (format t "~a quickness~%~a moves~%~a strenght~%~a defense~%~a hit-points~%"
	    quickness moves strenght defense hit-points)))


(defclass pig (animal)
  ())


(defclass dog (animal)
  ())


(setf *random-state* (make-random-state t))
(my-print (make-instance 'dog :name "geppo"))
