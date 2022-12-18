;;;; day-02.lispo

(in-package #:day-02)



(defvar *example-input* "A Y
B X
C Z")


(defun process-input (input-string)
  (mapcar (lambda (rps-round)
            (register-groups-bind (his yours)
                ("([ABC]) ([XYZ])" rps-round)
              (cons (case (first (coerce his 'list))
                      (#\A :rock)
                      (#\B :paper)
                      (#\C :scissors))
                    (case (first (coerce yours 'list))
                      (#\X :rock)
                      (#\Y :paper)
                      (#\Z :scissors)))))
          (split "\\n" input-string)))


;;; Part One
(defparameter *throw-weight* (list (cons :rock 1)
                                   (cons :paper 2)
                                   (cons :scissors 3)))


(defun score-round (round)
  (destructuring-bind (his . yours)
      round
    (+ (cdr (assoc yours *throw-weight*))
       (cond
         ((equal his yours) 3)
         ((and (equal yours :rock) (equal his :scissors)) 6)
         ((and (equal yours :paper) (equal his :rock)) 6)
         ((and (equal yours :scissors) (equal his :paper)) 6)
         (:else 0)))))


(defun total-score (input)
  (apply #'+
         (mapcar #'score-round
                 (process-input input))))


;;; Part Two
(defun process-input-part-2 (input-string)
  (mapcar (lambda (rps-round)
            (register-groups-bind (his yours)
                ("([ABC]) ([XYZ])" rps-round)
              (cons (case (first (coerce his 'list))
                      (#\A :rock)
                      (#\B :paper)
                      (#\C :scissors))
                    (case (first (coerce yours 'list))
                      (#\X :lose)
                      (#\Y :draw)
                      (#\Z :win)))))
          (split "\\n" input-string)))


(defun play-round (round)
  (destructuring-bind (his . outcome)
      round
    (+ (1+ (mod (+ (case his
                     (:rock 0)
                     (:paper 1)
                     (:scissors 2))
                   (case outcome
                     (:lose -1)
                     (:draw 0)
                     (:win 1)))
                3))
       (case outcome
         (:lose 0)
         (:draw 3)
         (:win 6)))))


(defun total-score-with-strategy (input)
  (->> (process-input-part-2 input)
       (mapcar #'play-round)
       (apply #'+)))
