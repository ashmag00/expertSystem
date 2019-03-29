;Init and main function
(setf board nil)

(defun tic-tac-toe ()

  (setf board (make-array '(3 3) :initial-element nil))
  (format t "Who goes first? (h or c)")
  (let ((p (read-line)))
  (cond
    ((string-equal p "h") (setf currentPlayer 1))
    ((string-equal p "c") (setf currentPlayer 2))
    ((t) (setf currentPlayer 1))
    ))
  (format t "Memoization on? (y or n)")
  (let ((p (read-line)))
  (cond
    ((string-equal p "y") (setf memoization t))
    ((string-equal p "n") (setf memoization nil))
    ((t) (setf memoization t))
    ))
  ;Game Loop
  (do ((x 0 (+ x 1))) ((or (detectWin board) (detectDraw board)) 'done)
    (if (equal currentPlayer 1)
     (multiple-value-bind (a b) (askForMove) (setf (aref board a b) currentPlayer))
     (multiple-value-bind (a b) (aiMove) (setf (aref board a b) currentPlayer)))
    (showBoard)
    (setf currentPlayer (switchPlayer currentPlayer))
    
    ))
;Detect a finished board
(defun detectWin (board)
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
(defun detectDraw (board)
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
(defun switchPlayer (player)
    (if (equal 1 player)
      2
      1))

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
  (makeMyboard)
  (let ((currentNode (make-node :gameBoard (copyBoard) :score 0 :children ())) (myPlayer currentPlayer)) 
    (buildTree myBoard myPlayer currentNode 0)
    ;pick child with best score
    )
  )

;Build a search tree for possible game states
(defun buildTree (myBoard player currentNode depth)
  ;if memoization is on, search tree here, if node is found make that node the current node and return
  (format t "~A~%" depth)
  (multiple-value-bind (w p) (detectWin myBoard)
    (if w
      (if (equal p 1)
        ;(setf (node-children currentNode) (cons (make-node :gameBoard (copyBoard) :score -1 :children ()) (node-children currentNode)))
        (setf (node-score currentNode) -1)
        ;(setf (node-children currentNode) (cons (make-node :gameBoard (copyBoard) :score 1 :children ()) (node-children currentNode))))
        (setf (node-score currentNode) 1))
      (if (detectDraw myBoard)
       ;(setf (node-children currentNode) (cons (make-node :gameBoard (copyBoard) :score 0 :children ()) (node-children currentNode)))
        (setf (node-score currentNode) 0)
        (progn
          (do ((i 0 (+ i 1))) ((equal i 3) 'done)
            (do ((j 0 (+ j 1))) ((equal j 3) 'done)
              (if (equal (aref myBoard i j) nil)
                (progn
                  (setf (aref myBoard i j) (switchPlayer player))
                  (setf (node-children currentNode) (cons (make-node :gameBoard (copyBoard) :score nil :children ()) (node-children currentNode)))
                  (format t "~A~%" myBoard)
                  (buildTree myBoard (switchPlayer player) (car (node-children currentNode)) (+ 1 depth))
                  (format t "~A~%" myBoard)
                  (hashToBoard (node-gameBoard currentNode))
                  ; (setf (node-score currentNode) (nodeScore currentNode 0)))
                  )))))))))

;return the score of a node
(defun nodeScore (myNode total)
  (if (not (equal (node-score myNode) nil))
    (+ (node-score myNode) total)
    ;sum score of children
    (dolist (x (node-children myNode) total)
        (+ (nodeScore x total) total))))

#|
(defun copyBoard ()
  (let ((a 0))
    (do ((i 0 (+ i 1))) ((equal i 3) a)
        (do ((j 0 (+ j 1))) ((equal j 3) 'done)
            (setf a (+ (* 10 a) (if (equal (aref myBoard i j) nil) 0 (aref myBoard i j)))))))
|#
(defun copyBoard ()
  (let ((a ""))
    (do ((i 0 (+ i 1))) ((equal i 3) a)
        (do ((j 0 (+ j 1))) ((equal j 3) 'done)
            (setf a (concatenate 'string a (if (equal (aref myBoard i j) nil) "-" (format nil "~A" (aref myBoard i j)))))))))

#|
(defun hashToBoard (hashNum)
  (format t "~A~%" hashNum)
	(let ((hash (int-to-list hashNum)))
	(do ((i 0 (+ i 1))) ((equal i 3) 'done)
    	(do ((j 0 (+ j 1))) ((equal j 3) 'done)
			(setf (aref myBoard i j) (if (equal (nth (+ (* i 3) j) hash) 0) nil (nth (+ (* i 3)) hash)))))))
|#

(defun hashToBoard (hashNum)
	(let ((hash (string-to-list hashNum)))
	(do ((i 0 (+ i 1))) ((equal i 3) 'done)
    	(do ((j 0 (+ j 1))) ((equal j 3) 'done)
			(setf (aref myBoard i j) (if (equal (nth (+ (* i 3) j) hash) -3) nil (nth (+ (* i 3)) hash)))))))


#|
;Found at stackoverflow
(defun int-to-list (int)
  (assert (>= int 0) nil "Argument must be non-negative")
  (if (= int 0) (list 0)
      (loop with result = nil
         while (> int 0) do
           (multiple-value-bind (divisor remainder)
               (floor int 10)
             (push remainder result)
             (setf int divisor))
         finally (return result))))
|#

(defun string-to-list (str)
  (let ((lst nil)(ch nil))
    (do ((i 0 (+ i 1))) ((equal i 3) 'done)
      (do ((j 0 (+ j 1))) ((equal j 3) 'done)
        (setf ch (- (char-int (aref str (+ (* i 3) j))) 48))
        (setf lst (append lst 
                          (if (eql ch -3)
                            (list nil)
                            (list ch))))))
    lst))

(defun makeMyboard ()
	(setf myBoard (make-array '(3 3) :initial-element nil))
	(do ((i 0 (+ i 1))) ((equal i 3) 'done)
    	(do ((j 0 (+ j 1))) ((equal j 3) 'done)
			(setf (aref myBoard i j) (aref board i j)))))
