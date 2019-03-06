(defun transcriptLst (lst) 
  (if (not(null lst))
    (if (gradeCheck(car lst))
      (cons (caar lst) (transcriptLst (cdr lst ))) 
      (transcriptLst (cdr lst)))
    ()))

(defun classLst(person)
    (append (transcriptLst (cdar person)) (cdadr person)))

(defun gradeCheck(transClass)
  (case (cadr transClass)
    ((A A- B+ B B- C+ C C-) t)
    (otherwise nil)))

(defun orCheck(lst)
  (if (null lst)
    nil
    (or (member (car lst) classPlan) (orCheck (cdr lst)))))

(defun findHours(className catalog)
  (if (null catalog)
    0
    (if (member className (car catalog))
      (cadar catalog)
      (findHours className (cdr catalog)))))

(defun checkRequired(required)
  (if (null required)
    ()
    (if (listp (car required))
      (if (orCheck (cdar required))
        (checkRequired (cdr required))
        (cons (car required) (checkRequired (cdr required))))
      (if (member (car required) classPlan)
        (checkRequired (cdr required))
        (cons (car required) (checkRequired (cdr required)))))))

(defun checkHours (classPlan catalog) 
  (if (null classPlan)
    0
    (+ (findHours (car classPlan) catalog) (checkHours (cdr classPlan) catalog))))

(defun grad-check (person degree-requirements catalog)
  (setf classPlan (classLst person))
  (setf neededHours (cadar degree-requirements))
  (setf remainingClasses (checkRequired (cdadr degree-requirements)))
  (setf remainingHours (- (checkHours classPlan catalog) neededHours))
  
  (cond 
    ((and (null remainingClasses) (>= remainingHours 0)) 
        (values 'PASS (list 'EXTRA-HOURS remainingHours)))
     ((or (not (null remainingClasses)) (<= remainingHours 0))
        (values 'FAIL (list remainingClasses 'EXTRA-HOURS remainingHours)))
  ))
  
