;Init and main function
(defun tic-tac-toe ()
  (setf board (make-array '(3 3) :initial-element nil))
  ;TODO: Who plays first?
  ;Game Loop
  (do ((x 0 (+ x 1))) ((detectWin) 'done)
    (setf (aref board (askForMove)) (retrievePlayer))
    (showBoard)))
;Detect a finished board
(defun detectWin ()
  (setf win nil)
  ;check rows
  (do ((i 0 (+ i 1))) ((or (equal i 3) (equal win t)) win)
    (if (not (equal (aref board i 0) nil))
      (if (and (equal (aref board i 0) (aref board i 1)) (equal (aref board i 1) (aref board i 2)))
        (setf win t))))
  ;check columns
  (do ((i 0 (+ i 1))) ((or (equal i 3) (equal win t)) win)
    (if (not (equal (aref board 0 i) nil))
      (if (and (equal (aref board 0 i) (aref board 1 i)) (equal (aref board 1 i) (aref board 2 i)))
        (setf win t))))
  ;check diagonal
  (if (not (equal (aref board 0 0) nil))
    (if (and (equal (aref board 0 0) (aref board 1 1)) (equal (aref board 1 1) (aref board 2 2)))
      (setf win t)))
  (if (not (equal (aref board 0 2) nil))
    (if (and (equal (aref board 0 2) (aref board 1 1)) (equal (aref board 1 1) (aref board 2 0)))
      (setf win t)))
  ;return
  win)
        

;Retrieve input data from player
(defun askForMove ()
  (format t "Enter move 'ROW COLUMN': ")
  (read-from-string (read-line))
;Determine which player just made a move
;(defun retrievePlayer)
;Print out board
;(defun showBoard)
