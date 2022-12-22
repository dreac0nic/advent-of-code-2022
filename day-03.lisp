;;;; day-03.lispo

(in-package #:day-03)



(defvar *example-input* "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw")


(defun char-upcase-p (char)
  (and (characterp char)
       (equal char
              (char-upcase char))))


(defun process-input (input)
  (mapcar (lambda (rucksack)
            (mapcar (lambda (item)
                      (- (char-code item)
                         (if (char-upcase-p item) 38 96)))
                    (coerce rucksack 'list)))
          (split "\\n" input)))


;;; Part One
(defun sum-duplicate-items (input)
  (loop for rucksack in (process-input input)
        sum (loop with found-items = nil
                  with divider = (/ (length rucksack) 2)
                  for item in rucksack
                  for index from 0
                  if (< index divider)
                    do (setf found-items (adjoin item found-items))
                  else
                    do (when (find item found-items)
                         (return item))
                  finally (return 0))))


;;; Part Two
(defun collect-groups (rucks)
  (loop for rucks-iter = rucks then (cdddr rucks-iter)
        while rucks-iter
        for a = (car rucks-iter)
        for b = (cadr rucks-iter)
        for c = (caddr rucks-iter)
        collect (list a b c)))


(defun sum-identity-badges (input)
  (loop for group in (collect-groups (process-input input))
        sum (first (reduce #'intersection group))))
