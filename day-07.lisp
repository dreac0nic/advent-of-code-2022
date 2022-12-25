;;;; day-07.lisp

(in-package #:day-07)



(defvar *example-input* "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k")



(defun build-system-tree (script)
  (loop with file-system = '((:name . "/")
                             (:type . :dir)
                             (:links . nil))
        with wd = nil
        with breadcrumbs = nil
        for context in script
        for command = (cdr (assoc :command context))
        for directory = (cdr (assoc :directory context))
        for output = (cdr (assoc :output context))
        do (cond
             ((string= command "cd")
              (cond
                ((string= directory "/")
                 (setf wd file-system
                       breadcrumbs nil))

                ((string= directory "..")
                 (setf wd (pop breadcrumbs)))

                (t
                 (let ((target-directory (find directory (cdr (assoc :links wd))
                                               :key
                                               (lambda (element)
                                                 (cdr (assoc :name element)))
                                               :test #'string=)))
                   (if target-directory
                       (progn
                         (push wd breadcrumbs)
                         (setf wd target-directory))
                       (format t "~&Could not find directory ~A!~%" directory))))))
             ((string= command "ls")
              (when wd
                (setf (cdr (assoc :links wd))
                      (mapcar (lambda (node)
                                (case (cdr (assoc :type node))
                                  (:dir (->> '()
                                             (acons :name (cdr (assoc :name node)))
                                             (acons :type :dir)
                                             (acons :links nil)))
                                  (:file (->> '()
                                              (acons :name (cdr (assoc :name node)))
                                              (acons :type :file)
                                              (acons :size (cdr (assoc :size node)))))))
                              output)))))
        finally (return file-system)))


(defun process-input (input)
  (let (commands)
    (do-register-groups (command parameters)
        ((create-scanner "^\\$ (cd|ls)\\s*\\n?((?:[\\/A-Za-z0-9. ]+\\n?)+)$"
                         :multi-line-mode t)
         input)
      (setf commands
            (cons (cond
                    ((string= command "cd")
                     (->> '()
                          (acons :command command)
                          (acons :directory parameters)))
                    ((string= command "ls")
                     (->> '()
                          (acons :command command)
                          (acons :output
                                 (loop for node in (split "\\n" parameters)
                                       collect (register-groups-bind (dir-name (#'parse-integer size) file-name)
                                                   ("dir (\\w+)|(\\d+) ([A-Za-z0-9.]+)" node)
                                                 (cond
                                                   (dir-name
                                                    (->> '()
                                                         (acons :name dir-name)
                                                         (acons :type :dir)))
                                                   ((and size file-name)
                                                    (->> '()
                                                         (acons :name file-name)
                                                         (acons :type :file)
                                                         (acons :size size))))))))))
                  commands)))
    (build-system-tree (reverse commands))))


;;; Part One
(defun file-size (file)
  (case (cdr (assoc :type file))
    (:file (cdr (assoc :size file)))
    (:dir (loop for file-link in (cdr (assoc :links file))
                sum (file-size file-link)))))


(defun collect-dirs (file)
  (when (eql :dir (cdr (assoc :type file)))
    (cons file
          (loop for node in (cdr (assoc :links file))
                if (eql :dir (cdr (assoc :type node)))
                  append (collect-dirs node)))))


(defun sum-10k-dirs (input)
  (loop for dir in (collect-dirs (process-input input))
        for size = (file-size dir)
        if (<= size 100000)
          sum size))


;;; Part Two
(defun identify-file (input)
  (let* ((total-disk-space 70000000)
         (space-required 30000000)
         (file-system (process-input input))
         (target-size (- space-required (- total-disk-space (file-size file-system)))))
    (loop with smallest-size = nil
          for dir in (collect-dirs file-system)
          for size = (file-size dir)
          if (and (>= size target-size)
                  (or (null smallest-size)
                      (< size smallest-size)))
            do (setf smallest-size size)
          finally (return smallest-size))))
