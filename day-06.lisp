;;;; day-06.lisp

(in-package #:day-06)



(defvar *example-input-1* "bvwbjplbgvbhsrlpgdmjqwftvncz")
(defvar *example-input-2* "nppdvjthqldpwncqszvftbrmjlhg")
(defvar *example-input-3* "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
(defvar *example-input-4* "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")



(defun process-input (input)
  (coerce input 'list))



;;; Part One
(defun detect-dupe-marker (input)
  (loop for (a b c d) on (process-input input)
        for index from 4
        if (= 4
              (length (->> (adjoin a '())
                           (adjoin b)
                           (adjoin c)
                           (adjoin d))))
          return index))


;;; Part Two
(defun detect-message-start (input)
  "FOR BRUTE FORCE AND FOR PROSPERITY"
  (loop for (a b c d e f g h i j k l m n) on (process-input input)
        for index from 14
        if (= 14
              (length (->> (adjoin a '())
                           (adjoin b)
                           (adjoin c)
                           (adjoin d)
                           (adjoin e)
                           (adjoin f)
                           (adjoin g)
                           (adjoin h)
                           (adjoin i)
                           (adjoin j)
                           (adjoin k)
                           (adjoin l)
                           (adjoin m)
                           (adjoin n))))
          return index))
