#|
  This file is a part of cl-oanda project.
|#

(defsystem "cl-oanda"
    :version "0.1.0"
    :author "takeokunn"
    :license "GPLv3"
    :depends-on (:dexador :quri)
    :components ((:module "src"
                     :components
                     ((:file "cl-oanda" :depends-on ("base"))
                         (:file "base"))))
    :description "oanda api client"
    :long-description
    #.(read-file-string
          (subpathname *load-pathname* "README.markdown"))
    :in-order-to ((test-op (test-op "cl-oanda-test"))))
