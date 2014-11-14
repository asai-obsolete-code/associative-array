#|
  This file is a part of associative-array project.
  Copyright (c) 2014 guicho
|#

(in-package :cl-user)
(defpackage associative-array
  (:use :cl :alexandria :iterate)
  (:export :associative-array
           :associative-array-dimension
           :associative-array-dimensions
           :aaref))
(in-package :associative-array)

;; blah blah blah.

;;; assoc-array

(defstruct (associative-array (:constructor %associative-array))
  (dimensions 1 :type fixnum :read-only t)
  (%tables (vector (make-hash-table :test 'eq))
           :type (array hash-table 1)
           :read-only t) 
  (%array (make-array 0 :adjustable t :fill-pointer 0)
          :type (array t *)
          :read-only t))


(defun associative-array (dimensions)
  (%associative-array :dimensions dimensions
                      :%tables (iter (with tables = (make-array dimensions))
                                     (for i below dimensions)
                                     (setf (aref tables i) (make-hash-table :test 'eq))
                                     (finally (return tables)))
                      :%array (make-array (make-list dimensions :initial-element 0)
                                          :adjustable t)))

(defun aaref (associative-array &rest subscripts)
  (apply #'aref
         (associative-array-%array associative-array)
         (map 'list #'gethash
              subscripts
              (associative-array-%tables associative-array))))

(defun (setf aaref) (new-value associative-array &rest subscripts)
  (with-accessors ((%a associative-array-%array)) associative-array
    (apply #'(setf aref)
           new-value
           %a
           (map 'list
                (lambda (thing hash i)
                  (or (gethash thing hash)
                      (let* ((dimensions (array-dimensions %a))
                             (old (array-dimension %a i)))
                        (incf (nth i dimensions))
                        (adjust-array %a dimensions :initial-element nil)
                        (setf (gethash thing hash) old))))
                subscripts
                (associative-array-%tables associative-array)
                (iota (associative-array-dimensions associative-array))))))

(defun associative-array-dimension (associative-array dimension)
  (hash-table-keys 
   (aref (associative-array-%tables associative-array) dimension)))
