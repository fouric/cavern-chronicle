(in-package :cavern-chronicle)

(defparameter +screen-width+ 640)
(defparameter +screen-height+ 480)
(defparameter +bits-per-pixel+ 32)

(defclass graphics ()
  ((screen :accessor screen :initarg :screen)))

(defun make-graphics ()
  (make-instance 'graphics :screen (sdl2:create-rgb-surface +screen-width+ +screen-height+ +bits-per-pixel+)))

(defun graphics-destroy (graphics)
  (declare (ignore graphics))
  )
