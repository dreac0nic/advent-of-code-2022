;;;; advent-of-code-2022.asd

(asdf:defsystem #:advent-of-code-2022
  :author "spenser <spenser.m.bray@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :depends-on (#:arrows #:dexador #:cl-cookie #:cl-ppcre #:lquery #:cl-graph #:uiop)
  :serial t
  :components ((:file "package")
               (:file "utility")
               (:file "advent-of-code-2022")
               (:file "day-01")
               (:file "day-02"))
  :description "A collection of solutions to the Advent of Code 2022"
  :long-description
  #.(uiop:read-file-string
     (uiop:subpathname *load-pathname* "README.md")))
