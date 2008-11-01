;;;; Dogs and pigs. A battle simulation.


(defparameter *skill-points* 40)

(defparameter *max-hit-points* 100)

(defparameter *min-hit-points* 50)

(defmacro random-range (from to)
  `(+ ,from (random (- ,to ,from))))


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
  (with-accessors ((quickness quickness)
		   (moves moves)
		   (strenght strenght)
		   (defense defense)) this
  (do ((skill-points-left *skill-points* (1- skill-points-left)))
    ((= 0 skill-points-left))
    (let ((skill (random 4)))
      (cond ((= 0 skill) (incf quickness))
	    ((= 1 skill) (incf moves))
	    ((= 2 skill) (incf strenght))
	    ((= 3 skill) (incf defense)))))))


(defmethod my-print ((this animal))
    (format t "~a:~%" (name this))
    (format t "~a quickness~%~a moves~%~a strenght~%~a defense~%~a hit-points~%"
	    (quickness this) (moves this) (strenght this) (defense this) (hit-points this)))


(defclass pig (animal)
  ())


(defclass dog (animal)
  ())


(setf *random-state* (make-random-state t))
(my-print (make-instance 'dog :name "geppo"))
