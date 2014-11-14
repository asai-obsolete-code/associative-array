#|
  This file is a part of associative-array project.
  Copyright (c) 2014 guicho
|#

(in-package :cl-user)
(defpackage :associative-array.test
  (:use :cl
        :associative-array
        :fiveam))
(in-package :associative-array.test)



(def-suite :associative-array)
(in-suite :associative-array)

;; run test with (run! test-name) 
;;   test as you like ...

(test associative-array
  (defparameter a (associative-array 2))
  (setf (aaref a :one :one) 1)
  (setf (aaref a :one :two) 2)
  (setf (aaref a :three :two) 6)
  (setf (aaref a :four :two) 8)
  (associative-array-dimension a 0)
  (associative-array-dimension a 1))

