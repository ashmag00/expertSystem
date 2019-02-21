; Asher Gingerich, Elizabeth McMasters
(defun proveRules (toProve rules)
  (if (null rules)
    nil
    (if (eql (cadar rules) toProve )
      (cons (car rules) (proveRules toprove (cdr rules)))
      (proveRules toprove (cdr rules)))))

(defun andHandler (facts rules rule)
  (if (null rule) 
    t
    (if (listp (car rule))
      (if (parseList facts rules (car rule))
          (andHandler facts rules (cdr rule))
          nil)
      (if (prove? (car rule) facts rules)
          (andHandler facts rules (cdr rule))
          nil))))

(defun orHandler (facts rules rule)
  (if (null rule) 
    nil
    (if (listp (car rule))
      (if (parseList facts rules (car rule))
        t
        (orHandler facts rules (cdr rule)))
      (if (prove? (car rule) facts rules)
        t
        (orHandler facts rules (cdr rule))
        ))))

(defun notHandler (facts rules rule)
  (if (listp (car rule))
    (if (parseList facts rules (car rule))
        nil
        t)
    (if (prove? (car rule) facts rules)
      nil
      t)))

(defun parseList (facts rules lst)
  (if (eql (car lst) 'and)
    (andHandler facts rules (cdr lst))
    (if (eql (car lst) 'or)
      (orHandler facts rules (cdr lst))
      (if (eql (car lst) 'not)
        (notHandler facts rules (cdr lst))
        (prove? (car lst) facts rules)))))

(defun checkValidRules (facts rules validRules)
  (if (null validRules)
    nil
    (or (parseList facts rules (caar validRules))
        (checkValidRules facts rules (cdr validRules)))))


(defun prove? (toProve facts rules)
  (if (member toProve facts)
    T
    (checkValidRules facts rules (proveRules toProve rules))))

(setf facts '(A B C))

(setf rules '(
 ((and A B) D)
 ((or A C) E)
 ((or (not B) A) F)
 ((F) G)
 ((and F (or H D)) I)
 ((or (not D) (and Y F)) J)
 ))
