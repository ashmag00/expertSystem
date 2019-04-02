(defun randomNoun ()
      
  )
(defun randomAdj ()

  )


(defun main ()
  (let ((r (random 4)))
    (cond ((= r 0) (format t (concatenate 'string' "Our company's purpose is to " ".~%")))
          ((= r 1) (format t (concatenate 'string' "Our vision is to " ".~%")))
          ((= r 2) (format t (concatenate 'string' "Our company exists to " ".~%")))
          ((= r 3) (format t (concatenate 'string' "We can be relied upon to " ".~%")))
          (t (format t "Fail~%"))
)))
  

