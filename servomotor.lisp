;; Load packages
(load "packages.lisp" :external-format :utf-8)

(in-package :cl-iot)

;; Load wrapper API
(load "libwiringPi.lisp" :external-format :utf-8)

;; サーボモータに接続したGPIOの端子番号を指定
(defconstant +servo-pin+ 18)

;; サーボモータを動かす角度を指定する
(defconstant +set-degree+ -90.0)

;; GPIO pin mode
(defconstant +pwm-output+ 2)

;; Main Function
(defun main ()
  (let (move-deg)
    ;; GPIO初期化
    (wiringPiSetupGpio)
    ;; 各種GPIOモード設定 (全部OUTPUT)
    (pinMode +servo-pin+ +pwm-output+)
    ;; サーボモータに合わせたPWM波形の設定を行う
    (pwmSetMode 0)
    (pwmSetRange 1024)
    (pwmSetClock 375)
    ;; 指定した角度が動作範囲内の場合のみサーボモータを制御
    (if (and (<= +set-degree+ 90) (>= +set-degree+ -90))
        (progn
          ;; 角度から送り出すPWMのパルス幅を算出する
          (setf move-deg (+ 81.0 (/ 41.0 (* 90.0 +set-degree+))))
          ;; サーボモータにPWMを送り、サーボモータを動かす
          (pwmWrite +servo-pin+ move-deg)))))

;; 実行！！
(main)
