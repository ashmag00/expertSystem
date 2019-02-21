; Asher Gingerich, Elizabeth McMasters
(defun prove? (toProve facts rules)
  (if (member toProve facts)
    T
    nil))

(setf facts '(A B C))

(setf rules '(
 ((and A B) D)
 ((or A C) E)
 ((or (not B) A) F)
 ((F) G)
 ((and F (or H D)) I)
 ((or (not D) (and Y F)) J)
 ))
