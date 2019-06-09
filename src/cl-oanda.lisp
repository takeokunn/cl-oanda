(defpackage cl-oanda
    (:use :cl)
    (:import-from :cl-oanda.base
        :http-get
        :http-post
        :http-put
        :http-patch
        :http-delete)
    (:export
        ;; rate
        :get-instruments
        :get-prices
        :get-candles
        ;; account
        :get-account
        :post-account
        :show-account
        ;; orders
        :get-account-orders
        :post-account-orders
        :show-account-order
        :patch-account-order
        :delete-account-order
        ;; trades
        :get-account-trades
        :show-account-trade
        :patch-account-trade
        :delete-account-trade
        ;; positions
        :get-account-positions
        :show-account-position
        :delete-account-position
        ;; transactions
        :get-account-transactions
        :show-account-transactions
        :get-account-all-transactions))
(in-package :cl-oanda)

;;;;;;;;;;;;;;;;;;;;;
;;      rates      ;;
;;;;;;;;;;;;;;;;;;;;;

;; url: http://developer.oanda.com/docs/jp/v1/rates/

;; TODO: Fix
(defun get-instruments (&key accountId (fields "") (instruments ""))
    "銘柄リストを取得する"
    (http-get :path "/v1/instruments"
        :query `(("accountId" . ,accountId)
                    ("fields" . ,fields)
                    ("instruments" . ,instruments))))

;; TODO: fix
(defun get-prices (&key instruments (since ""))
    "現在のレートを取得する"
    (http-get :path "/v1/prices"
        :query `(("instruments" . ,instruments)
                    ("since" . ,since))))

;; TODO: fix
(defun get-candles (&key instrument
                       (granularity "")
                       (count "")
                       (start "")
                       (end "")
                       (candleFormat "")
                       (includeFirst "")
                       (dailyAlignment "")
                       (alignmentTimezone "")
                       (weeklyAlignment ""))
    "銘柄の過去データの取得"
    (http-get :path "/v1/candles"
        :query `(("instrument" . ,instrument)
                    ("granularit" . ,granularity)
                    ("count" . ,count)
                    ("start" . ,start)
                    ("end" . ,end)
                    ("candleFormat" . ,candleFormat)
                    ("includeFirst" . ,includeFirst)
                    ("dailyAlignment" . ,dailyAlignment)
                    ("alignmentTimezone" . ,alignmenttimezone)
                    ("weeklyAlignment" . ,weeklyAlignment))))


;;;;;;;;;;;;;;;;;;;;;;
;;     account      ;;
;;;;;;;;;;;;;;;;;;;;;;

;; url: http://developer.oanda.com/docs/jp/v1/accounts/

;; TODO: Fix
(defun get-account (&key (username ""))
    "ユーザーのアカウントを取得する"
    (http-get :path "/v1/accounts"
        :query `(("username" . ,username))))


;; TODO: fix
(defun post-account (&key (currency ""))
    "テストアカウントの作成"
    (http-post :path "/v1/accounts"
        :content `(("currency" . ,currency))))

;; TODO: fix
(defun show-account (&key account-id)
    "アカウント情報の取得"
    (http-get :path (concatenate 'string "/v1/accounts/" account-id)))

;;;;;;;;;;;;;;;;;;;;;;
;;      orders      ;;
;;;;;;;;;;;;;;;;;;;;;;

;; url: http://developer.oanda.com/docs/jp/v1/orders/

;; TODO: fix
(defun get-account-orders (&key account-id (max-id "") (count "") (instrument "") (ids ""))
    "特定の口座における注文を取得する"
    (http-get :path (concatenate 'string "/v1/accounts/" account-id "/orders")
        :query `(("maxId" . ,max-id)
                    ("count" . ,count)
                    ("instrument" . ,instrument)
                    ("ids" . ,ids))))

;; TODO: fix
(defun post-account-orders (&key account-id instrument units side type expiry price
                               (lowerBound "")
                               (upperBound "")
                               (stopLoss "")
                               (takeProfit "")
                               (trailingStop ""))
    "新しい注文を作成する"
    (http-post :path (concatenate 'string "/v1/accounts/" account-id "/orders")
        :content `(("instrument" . ,instrument)
                    ("units" . ,units)
                    ("side" . ,side)
                    ("type" . ,type)
                    ("expiry" . ,expiry)
                    ("price" . ,price)
                    ("lowerBound" . ,lowerBound)
                    ("upperBound" . ,upperBound)
                    ("stopLoss" . ,stopLoss)
                    ("takeProfit" . ,takeProfit)
                    ("trailingStop" . ,trailingStop))))

;; TODO: fix
(defun show-account-order (&key account-id order-id)
    "注文に関する情報を取得する"
    (http-get :path (concatenate 'string "/v1/accounts/" account-id "/orders/" order-id)))


;; TODO: fix
(defun patch-account-order (&key account-id order-id
                               (units "")
                               (price "")
                               (expiry "")
                               (lower-bound "")
                               (upper-bound "")
                               (stop-loss "")
                               (take-profit "")
                               (trailing-stop ""))
    "既存の注文を変更する"
    (http-patch :path (concatenate 'string "/v1/accounts/" account-id "/orders/" order-id)
        :content `(("units" . ,units)
                      ("price" . ,price)
                      ("expiry" . ,expiry)
                      ("lowerBound" . ,lower-bound)
                      ("upperBound" . ,upper-bound)
                      ("stockLoss" . ,stop-loss)
                      ("takeProfit" . ,take-profit)
                      ("trailingStop" . ,trailing-stop))))

;; TODO: fix
(defun delete-account-order (&key account-id order-id)
    "注文をキャンセルする"
    (http-delete :path (concatenate 'string "/v1/accounts/" account-id "/orders/" order-id)))

;;;;;;;;;;;;;;;;;;;;;;
;;      trades      ;;
;;;;;;;;;;;;;;;;;;;;;;

;; url: http://developer.oanda.com/docs/jp/v1/trades/

;; TODO: fix
(defun get-account-trades (&key account-id (max-id "") (count "") (instrument "") (ids ""))
    "未決済チケットのリストを取得する"
    (http-get :path (concatenate 'string "/v1/accounts/" account-id "/trades")
        :query `(("maxId" . ,max-id)
                    ("count" . ,count)
                    ("instrument" . ,instrument)
                    ("ids" . ,ids))))

;; TODO: fix
(defun show-account-trade (&key account-id trade-id)
    "特定のチケットに関する情報を取得する"
    (http-get :path (concatenate 'string "/v1/accounts/" account-id "/trades/" trade-id)))

;; TODO: fix
(defun patch-account-trade (&key account-id trade-id (stop-loss "") (take-profit "") (trailing-stop ""))
    "既存のチケットを変更する"
    (http-patch :path (concatenate 'string "/v1/accounts/" account-id "/trades/" trade-id)
        :content `(("stopLoss" . ,stop-loss)
                      ("takeProfit" . ,take-profit)
                      ("trailingStop" . , trailing-stop))))


;; TODO: fix
(defun delete-account-trade (&key account-id trade-id)
    "特定のチケットに関する情報を取得する"
    (http-delete :path (concatenate 'string "/v1/accounts/" account-id "/trades/" trade-id)))


;;;;;;;;;;;;;;;;;;;;;;
;;    positions     ;;
;;;;;;;;;;;;;;;;;;;;;;

;; url: http://developer.oanda.com/docs/jp/v1/positions/

;; TODO: fix
(defun get-account-positions (&key account-id)
    "全ての未決済ポジションのリストを取得する"
    (http-get :path (concatenate 'string "/v1/accounts/" account-id "/positions")))

;; TODO: fix
(defun show-account-position (&key account-id instrument)
    "特定の銘柄に対するポジションを取得する"
    (http-get :path (concatenate 'string "/v1/accounts/" account-id "/positions/" instrument)))

;; TODO: fix
(defun delete-account-position (&key account-id instrument)
    "特定の銘柄に対するポジションを取得する"
    (http-delete :path (concatenate 'string "/v1/accounts/" account-id "/positions/" instrument)))

;;;;;;;;;;;;;;;;;;;;;;
;;   transactions   ;;
;;;;;;;;;;;;;;;;;;;;;;

;; url: http://developer.oanda.com/docs/jp/v1/transactions/

;; TODO: fix
(defun get-account-transactions (&key account-id (max-id "") (min-id "") (count "") (instrument "") (ids ""))
    "トランザクションの履歴を取得する"
    (http-get :path (concatenate 'string "/v1/accounts/" account-id "/transactions")
        :query `(("maxId" . ,max-id)
                    ("minId" . ,min-id)
                    ("count" . ,count)
                    ("instrument" . ,instrument)
                    ("ids" . ,ids))))

;; TODO: fix
(defun show-account-transactions (&key account-id transaction-id)
    "トランザクションの履歴を取得する"
    (http-get :path (concatenate 'string "/v1/accounts/" account-id "/transactions/" transaction-id)))


;; TODO: fix
(defun get-account-all-transactions (&key account-id)
    "アカウントの完全な履歴を取得する"
    (http-get :path (concatenate 'string "/v1/accounts/" account-id "/alltransactions")))
