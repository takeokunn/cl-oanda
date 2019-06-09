#|
  This file is a part of cl-oanda project.
|#

(defsystem "cl-oanda-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("cl-oanda"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "cl-oanda"))))
  :description "Test system for cl-oanda"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
