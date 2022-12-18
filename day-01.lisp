;;;; day-01.lispo

(in-package #:day-01)



(defvar *example-input* "1000
2000
3000

4000

5000
6000

7000
8000
9000

10000")


(defun process-input (input-string)
  (mapcar (lambda (calorie-collection)
            (mapcar #'parse-integer
                    (split "\\n" calorie-collection)))
          (split "\\n\\n" input-string)))


;;; Part One
(defun most-calories (input)
  (loop for elf-rations in (process-input input)
        maximize (apply #'+ elf-rations)))


;;; Part Two
(defun sum-of-top-3-calories (input)
  (loop with leaderboard = '(0 0 0)
        for elf-rations in (process-input input)
        do (setf leaderboard (cdr (sort (cons (apply #'+ elf-rations) leaderboard) #'<)))
        finally (return (apply #'+ leaderboard))))
