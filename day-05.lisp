;;;; day-05.lisp

(in-package #:day-05)



(defvar *example-input*
  "    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2")



(defun process-input (input)
  (destructuring-bind (stacks movements)
      (split "\\n\\n" input)
    (cons (loop with layers = (reverse (split "\\n" stacks))
                with stacks-count = (length (split "   " (car layers)))
                with box-stacks = (make-array stacks-count :initial-element nil)
                for box-layer in (cdr layers)
                do (loop for index from 0 below stacks-count
                         for box-index = 1 then (+ 1 (* index 4))
                         while (< box-index (length box-layer))
                         ;if (not (char= (aref box-layer box-index) #\SPACE))
                         do (push (aref box-layer box-index) (aref box-stacks index)))
                finally (return box-stacks))
          (mapcar (lambda (order)
                    (register-groups-bind ((#'parse-integer count from to))
                        ("move (\\d+) from (\\d+) to (\\d+)" order)
                      (->> nil
                           (acons :count count)
                           (acons :from (1- from))
                           (acons :to (1- to)))))
                  (split "\\n" movements)))))


;;; Part One
(defun execute-rearrangement (stacks movements)
  (if (not movements)
      stacks
      (if (> (cdr (assoc :count (car movements))) 0)
          (progn
            (push (pop (aref stacks (cdr (assoc :from (car movements)))))
                  (aref stacks (cdr (assoc :to (car movements)))))
            (decf (cdr (assoc :count (car movements))))
            (execute-rearrangement stacks movements))

          (execute-rearrangement stacks (cdr movements)))))


(defun build-message (stacks)
  (map 'string
       (lambda (stack)
         (car stack))
       stacks))


(defun find-stack-top-message (input)
  (destructuring-bind (stacks . movements)
      (process-input input)
    (-> (execute-rearrangement stacks movements)
        build-message)))


;;; Part Two
(defun execute-rearrangement-9001 (stacks movements)
  (if (not movements)
      stacks
      (let ((move (car movements)))
        (loop for box in (reverse (loop repeat (cdr (assoc :count move))
                                        collect (->> move
                                                     (assoc :from)
                                                     cdr
                                                     (aref stacks)
                                                     pop)))
              do (->> move
                      (assoc :to)
                      cdr
                      (aref stacks)
                      (push box)))
        (execute-rearrangement-9001 stacks (cdr movements)))))


(defun find-stack-top-message-9001 (input)
  (destructuring-bind (stacks . movements)
      (process-input input)
    (-> (execute-rearrangement-9001 stacks movements)
        build-message)))
