;;;; package.lisp

(defpackage #:advent-of-code-2022
  (:use #:cl #:arrows #:cl-cookie #:lquery)
  (:export :get-puzzle-input :submit-answer))


(defpackage #:utility
  (:use #:cl)
  (:export :single? :append1 :map-int :filter :most :compose :disjoin :conjoin :curry :curry :rcurry :always :clamp))


(defpackage #:day-01
  (:use #:cl #:utility #:arrows #:advent-of-code-2021 #:cl-ppcre))
