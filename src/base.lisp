(defpackage cl-oanda.base
    (:use :cl)
    (:export :http-get
        :http-post
        :http-put
        :http-patch
        :http-delete))
(in-package :cl-oanda.base)

(defvar *SANDBOX-URL* "http://api-sandbox.oanda.com")
(defvar *FXTRADE-URL* "https://api-fxtrade.oanda.com")
(defvar *FXTRADE-PRACTICE-URL* "https://api-fxpractice.oanda.com")

(defmacro generate-header (token)
    `(let ((content-type (cons "Content-Type" "application/x-www-form-urlencoded")))
         (cond ((eq ,token "") (list content-type))
             (t (list content-type
                    (cons "Authorization" (concatenate 'string "Bearer " ,token)))))))

(defmacro generate-url (path &optional query)
    `(quri:make-uri
         :defaults *FXTRADE-URL*
         :path ,path
         :query ,query))

(defmacro base-response (&body body)
    `(multiple-value-bind (response status) ,@body
         (values response status)))

(defun http-get (&key path query (token ""))
    (base-response (dex:get (generate-url path query)
                       :headers (generate-header token))))

(defun http-post (&key path content (token ""))
    (base-response (dex:post (generate-url path)
                       :headers (generate-header token)
                       :content content)))

(defun http-put (&key path (token ""))
    (base-response (dex:put (generate-url path)
                       :headers (generate-header token))))

(defun http-patch (&key path content (token ""))
    (base-response (dex:patch (generate-url path)
                       :headers (generate-header token)
                       :content content)))

(defun http-delete (&key path (token ""))
    (base-response (dex:delete (generate-url path)
                       :headers (generate-header token))))
