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
    t
    (if (listp (car required))
      (and (orCheck (cdar required)) (checkRequired (cdr required)))
      (and (member (car required) classPlan) (checkRequired (cdr required))))))

(defun checkElectives(elective)
  (if (null elective)
    t
    (and (member (car elective) classPlan) (checkElectives (cdr elective)))))

(defun grad-check (person degree-requirements catalog)
  (setf classPlan (classLst person))
  (setf remainingHours (cadar degree-requirements))
  (if (checkRequired (cdadr degree-requirements))
    (checkElectives (cdaddr degree-requirements)))
)

(setf person '((transcript 
 (COS102 B-) (COS109 A) (COS120 B) (COS121 B+) (COS143 A-) (COS243 B+) (COS265 B) (COS284 B-) (MAT151 A-) (MAT210 B))
 (plan COS492 COS493 COS280 COS331 COS340 COS350 SYS214 SYS411 MAT215 COS311 COS320 COS393)) )

(setf degree-requirements '((major-hours 64)
 (required COS102 COS120 COS121 COS143 COS243 COS265 COS284 COS492 COS493 MAT151 MAT215
           (OR COS311 COS321)
           (OR COS320 COS382 COS435)
           (OR COS393 COS394 COS450)
           (OR MAT210 MAT352) )
 (electives COS104 COS109 COS130 COS170 
            COS232 COS270 COS280 
            COS310 COS323 COS331 COS333 COS340 COS343 COS350 
            COS351 COS355 COS360 COS370 COS380 COS381
            COS411 COS421 COS424 COS425 COS432 COS433 COS436
            MAT230 MAT240 MAT245 MAT251
            SYS214 SYS352 SYS401 SYS402 SYS403 SYS411)) )

(setf catalog '((COS102 3) (COS104 2) (COS109 3) (COS120 4) (COS121 4) (COS130 3) (COS143 3) (COS170 3)
 (COS232 3) (COS243 3) (COS265 3) (COS270 3) (COS280 3) (COS284 3) 
 (COS310 1) (COS311 3) (COS321 3) (COS320 3) (COS323 3) (COS333 3) (COS340 3) (COS343 3) 
 (COS350 3) (COS351 3) (COS355 3) (COS360 3) (COS370 3) (COS380 3) (COS381 3) (COS382 3) (COS393 3) (COS394 3) 
 (COS411 3) (COS421 3) (COS424 3) (COS425 3) (COS432 3) (COS433 3) (COS435 3) (COS436 3)
 (COS450 3) (COS492 3) (COS493 1)
 (MAT151 4) (MAT215 3) (MAT210 4) (MAT230 4) (MAT240 4) (MAT245 4) (MAT251 4) (MAT352 4)
 (SYS214 3) (SYS352 3) (SYS401 3) (SYS402 3) (SYS403 3) (SYS411 3)) )
