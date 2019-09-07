(in-package :cavern-chronicle)

(defparameter +screen-width+ 640)
(defparameter +screen-height+ 480)
(defparameter +bits-per-pixel+ 32)

(defclass graphics ()
  ((screen :accessor screen :initarg :screen)
   (renderer :accessor renderer :initarg :renderer)))

(defun make-graphics (renderer)
  (make-instance 'graphics :screen (sdl2:create-rgb-surface +screen-width+ +screen-height+ +bits-per-pixel+)
                           :renderer renderer))

(defun graphics-destroy (graphics)
  (sdl2:free-surface (screen graphics)))

(defun blit-surface (graphics surface source dest)
  (sdl2:blit-surface surface source (screen graphics) dest))
