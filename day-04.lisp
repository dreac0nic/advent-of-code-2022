;;;; day-04.lispo

(in-package #:day-04)



(defvar *example-input*
  "2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8")


(defun process-input (input)
  (mapcar (lambda (pairs)
            (register-groups-bind (left-min left-max right-min right-max)
                ("(\\d+)-(\\d+),(\\d+)-(\\d+)" pairs)
              (cons (cons (parse-integer left-min) (parse-integer left-max))
                    (cons (parse-integer right-min) (parse-integer right-max)))))
          (split "\\n" input)))


(defun range-size (range)
  (- (cdr range) (car range)))


(defun range-contains (left-range right-range)
  "Tests if the left range contains the right one"
  (and (<= (cdr right-range) (cdr left-range))
       (>= (car right-range) (car left-range))))


(defun range-overlaps (left-range right-range)
  (and (<= (car right-range) (cdr left-range))
       (>= (cdr right-range) (car left-range))))



;;; Part One
(defun count-fully-contained-pairs (input)
  (loop for (left-pair . right-pair) in (process-input input)
        when (if (> (range-size right-pair) (range-size left-pair))
                 (range-contains right-pair left-pair)
                 (range-contains left-pair right-pair))
          sum 1))


;;; Part Two
(defun count-overlapped-pairs (input)
  (loop for (left-pair . right-pair) in (process-input input)
        when (range-overlaps left-pair right-pair)
          sum 1))
