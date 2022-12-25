;;;; package.lisp

(defpackage #:advent-of-code-2022
  (:use #:cl #:arrows #:cl-cookie #:lquery)
  (:export :get-puzzle-input :submit-answer))


(defpackage #:utility
  (:use #:cl)
  (:export :single? :append1 :map-int :filter :most :compose :disjoin :conjoin :curry :curry :rcurry :always :clamp))


(defpackage #:day-01
  (:use #:cl #:utility #:arrows #:advent-of-code-2022 #:cl-ppcre))


(defpackage #:day-02
  (:use #:cl #:utility #:arrows #:advent-of-code-2022 #:cl-ppcre))


(defpackage #:day-03
  (:use #:cl #:utility #:arrows #:advent-of-code-2022 #:cl-ppcre))


(defpackage #:day-04
  (:use #:cl #:utility #:arrows #:advent-of-code-2022 #:cl-ppcre))


(defpackage #:day-05
  (:use #:cl #:utility #:arrows #:advent-of-code-2022 #:cl-ppcre))


(defpackage #:day-06
  (:use #:cl #:utility #:arrows #:advent-of-code-2022 #:cl-ppcre))


(defpackage #:day-07
  (:use #:cl #:utility #:arrows #:advent-of-code-2022 #:cl-ppcre))
