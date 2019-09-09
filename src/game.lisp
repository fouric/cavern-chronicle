(in-package :cavern-chronicle)

(defparameter +tile-size+ 32)

(defclass game ()
  ((graphics :accessor graphics :initarg :graphics)
   (sprite :accessor sprite :initarg :sprite)))

(defun make-game (renderer)
  (let ((graphics (make-graphics renderer)))
    (make-instance 'game :graphics graphics :sprite (make-sprite graphics (f:resource "assets/sprites.png" 'cavern-chronicle) 0 0 +tile-size+ +tile-size+))))

(defmethod update ((game game))
  (declare (ignore game)))

(defmethod draw ((game game) graphics x y)
  (declare (ignore x y))
  (let ((renderer (renderer graphics)))
    (sdl2:set-render-draw-color renderer 0 0 0 255)
    (sdl2:render-clear renderer)
    (draw (sprite game) (graphics game) 0 0)
    (sdl2:render-present renderer)))
