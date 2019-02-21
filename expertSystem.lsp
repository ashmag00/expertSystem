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
      (if (checkValidRules facts rules (car rule))
          (andHandler facts rules (cdr rule))
          nil)
      (if (prove? (car rule) facts rules)
          (andHandler facts rules (cdr rule))
          nil))))

(defun orHandler (facts rules rule)
  (if (null rule) 
    nil
    (if (listp (car rule))
      (if (checkValidRules facts rules (car rule))
        t
        (orHandler facts rules (cdr rule)))
      (if (prove? (car rule) facts rules)
        t
        (orHandler facts rules (cdr rule))
        ))))

(defun notHandler (facts rules rule)
  (if (listp (car rule))
    (if (checkValidRules (car rules))
        nil
        t)
    (if (prove? (car rule) facts rules)
      nil
      t)))

(defun checkValidRules (facts rules validRules)
  (if (null validRules)
    nil
    (if (eql (caaar validRules) 'and)
        (if (andHandler facts rules (cdaar validRules))
          t
          (checkValidRules facts rules (cdr validRules)))
        (if (eql (caaar validRules) 'or)
          (if (orHandler facts rules (cdaar validRules))
            t
           (checkValidRules facts rules (cdr validRules)))
          (if (eql (caaar validRules) 'not)
            (if (notHandler facts rules (cdr validRules))
              t
              (checkValidRules facts rules (cdr validRules)))
            (if (prove? (car validRules) facts rules)
              t
              (checkValidRules facts rules (cdr validRules)))
          )))))


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
