(define-foreign-library libwiringPi
  (:unix "libwiringPi.so"))

(use-foreign-library libwiringPi)

;;;; Core function

;; Initialization of the wiringPi
(defcfun "wiringPiSetupGpio" :int)

;; Set the mode of the GPIO pin
(defcfun "pinMode" :void (pin :int) (mode :int))

;; GPIO pin output control
(defcfun "digitalWrite" :void (pin :int) (value :int))

;; Waiting process
(defcfun "delay" :void (howlong :uint))

;; Set the state when nothing is connected to the terminal
(defcfun "pullUpDnControl" :void (pin :int) (pud :int))

;; Read the status of the GPIO pin
(defcfun "digitalRead" :int (pin :int))

;;;; I2C Library

;; Initialization of the I2C systems.
(defcfun "wiringPiI2CSetup" :int (fd :int))

;; Writes 8-bit data to the instructed device register.
(defcfun "wiringPiI2CWriteReg8" :int (fd :int) (reg :int) (data :int))

;; It reads the 16-bit value from the indicated device register.
(defcfun "wiringPiI2CReadReg16" :int (fd :int) (reg :int))

;;;; SPI library

;; SPI initialization
(defcfun "wiringPiSPISetup" :int (channel :int) (speed :int))

;; SPI initialization (Mode setting)
(defcfun "wiringPiSPISetupMode" :int (channel :int) (speed :int) (mode :int))

;; Execute concurrent write / read transactions on the selected SPI bus
(defcfun "wiringPiSPIDataRW" :int (channel :int) (data :pointer) (len :int))

;;;; PWM library

;; PWMジェネレータは、「balanced」と「mark:space」の2つのモードで動作します。
;; 「mark:space」モードは伝統的ですが、RaspberryPiのデフォルトモードは「balanced」です。
;; パラメータを指定すると、モードを切り替えることができます。
;; PWM_MODE_BALまたはPWM_MODE_MS。
(defcfun "pwmSetMode" :void (mode :int))

;; PWMジェネレータのレンジレジスタを設定します。 デフォルトは1024です。
(defcfun "pwmSetRange" :void (range :uint))

;; この関数では、PWMクロックの除数を設定します。
(defcfun "pwmSetClock" :void (divisor :int))

;; 指定されたピンのPWMレジスタに値を書き込みます。
;; ラズベリーパイには1つのオンボードPWMピン、ピン1（BMC_GPIO 18、物理12）があり、範囲は0〜1024です。
;; 他のPWMデバイスは、他のPWM範囲を有することができる。
;; この機能は、SysモードのときにPiのオンボードPWMを制御することができません。
(defcfun "pwmWrite" :void (pin :int) (value :int))
