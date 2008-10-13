;;; http://gigamonkeys.com/book/practical-a-simple-database.html


;; List of CDs.
;; NB: asterisks = global variables naming convention.
(defvar *db* nil)


;; Return a plist, that is a list that contains named elements.
;; You can retrieve the value of a given element with (getf mylist :key)
(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))


;; Add a cd to the db list.
(defun add-record (cd)
  (push cd *db*))


;; Dump the content of the database.
(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd)))


;; Read from standard input.
;; Promtp is the prompt to be displayed.
(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))


;; Ask the user to insert a CD
(defun prompt-for-cd ()
  (make-cd
    (prompt-read "Title")
    (prompt-read "Artist")
    ;; parse-integer returns NIL on error, but we need a number.
    ;; or's short-ciruiting behaviour is what we need:
    ;; if parse-integer succeedes, returns the parsed integer, else 0.
    (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
    ;; only yes or no are allowed
    (y-or-n-p "Ripped [Y/N]")))

(defun add-cds ()
  (loop (add-record (prompt-for-cd))
	(if (not (y-or-n-p "Another? [Y/N]: ")) (return))))
