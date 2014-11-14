#|
  This file is a part of associative-array project.
  Copyright (c) 2014 guicho
|#


(in-package :cl-user)
(defpackage associative-array.test-asd
  (:use :cl :asdf))
(in-package :associative-array.test-asd)


(defsystem associative-array.test
  :author "guicho"
  :license ""
  :depends-on (:associative-array
               :fiveam)
  :components ((:module "t"
                :components
                ((:file ""))))
  :perform (load-op :after (op c) (PROGN
 (EVAL (READ-FROM-STRING "(fiveam:run! :associative-array)"))
 (CLEAR-SYSTEM C))))
