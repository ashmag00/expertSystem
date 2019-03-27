;Init and main function
(defun tic-tac-toe ()
  (setf board (make-array '(3 3) :initial-element nil))
  (setf currentPlayer 1)
  ;TODO: Who plays first?
  ;Game Loop
  (do ((x 0 (+ x 1))) ((or (detectWin) (detectDraw)) 'done)
    (if (equal currentPlayer 1)
     (multiple-value-bind (a b) (askForMove) (setf (aref board a b) currentPlayer))
     (multiple-value-bind (a b) (aiMove) (setf (aref board a b) currentPlayer)))
    (showBoard)
    (switchPlayer)))
;Detect a finished board
(defun detectWin ()
  (setf win nil)
  (setf winner nil)
  ;check rows
  (do ((i 0 (+ i 1))) ((or (equal i 3) (equal win t)) win)
    (if (not (equal (aref board i 0) nil))
      (if (and (equal (aref board i 0) (aref board i 1)) (equal (aref board i 1) (aref board i 2)))
        (progn (setf win t)
               (setf winner (aref board i 0))))))
  ;check columns
  (do ((i 0 (+ i 1))) ((or (equal i 3) (equal win t)) win)
    (if (not (equal (aref board 0 i) nil))
      (if (and (equal (aref board 0 i) (aref board 1 i)) (equal (aref board 1 i) (aref board 2 i)))
        (progn (setf win t)
               (setf winner (aref board 0 i))))))
  ;check diagonal
  (if (not (equal (aref board 0 0) nil))
    (if (and (equal (aref board 0 0) (aref board 1 1)) (equal (aref board 1 1) (aref board 2 2)))
      (progn (setf win t)
             (setf winner (aref board 0 0)))))
  (if (not (equal (aref board 0 2) nil))
    (if (and (equal (aref board 0 2) (aref board 1 1)) (equal (aref board 1 1) (aref board 2 0)))
      (progn (setf win t)
             (setf winner (aref board 0 2)))))
  ;return
  (values win winner))
(defun detectDraw ()
  (setf draw t)
  (do ((i 0 (+ i 1))) ((or (equal i 3) (not draw)) draw)
    (do ((j 0 (+ j 1))) ((or (equal j 3) (not draw)) draw)
        (if (equal nil (aref board i j))
          (setf draw nil)))))

;Retrieve input data from player
(defun askForMove ()
  (format t "Enter move 'ROW COLUMN': ")
  (let ((x(read-line)))
  (values (- (char-int (char x 0)) 48) (- (char-int (char x 2)) 48))))

;Determine which player just made a move
(defun switchPlayer ()
    (if (equal 1 currentPlayer)
      (setf currentPlayer 2)
      (setf currentPlayer 1)))

;Print out board
(defun showBoard ()
  (format t "~A|~A|~A~%" (aref board 0 0)(aref board 0 1)(aref board 0 2))
  (format t "-----------~%")
  (format t "~A|~A|~A~%" (aref board 1 0)(aref board 1 1)(aref board 1 2))
  (format t "-----------~%")
  (format t "~A|~A|~A~%" (aref board 2 0)(aref board 2 1)(aref board 2 2)))

;AI
;Node struct for the tree
(defstruct node gameBoard score children)
;AI movement decision
(defun aiMove ()
  (buildTree (board currentPlayer)))
;Build a search tree for possible game states
(defun buildTree (myBoard player)
  (multiple-value-bind (w p) (detectWin)
    (if w
      (if (equal p 1)
        (make-node :gameBoard myBoard :score -1 :children ())
        (make-node :gameBoard myBoard :score 1 :children ()))
      (if (detectDraw)
        (make-node :gameBoard myBoard :score 0 :children ())
        (progn
          (setf curNode (make-node :gameBoard myBoard :score nil :children nil))
          (do ((i 0 (+ i 1))) ((equal i 3) 'done)
            (do ((j 0 (+ j 1))) ((equal j 3) 'done)
              (if (equal (aref myBoard i j) nil)
                ;TODO: FIXME!!!!
                (curNode-children (cons (buildTree)))
