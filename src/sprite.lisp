(in-package :cavern-chronicle)

(defclass sprite ()
  ((source-path :accessor source-path :initarg :source-path)
   (source-x :accessor source-x :initarg :source-x)
   (source-y :accessor source-y :initarg :source-y)
   (source-w :accessor source-w :initarg :source-w)
   (source-h :accessor source-h :initarg :source-h)
   (width :accessor width :initarg :width)
   (height :accessor height :initarg :height)
   (texture :accessor texture :initarg :texture )
   (source-rect :accessor source-rect :initarg :source-rect)))

(defun make-sprite (graphics source-path source-x source-y width height)
  (let* ((sprite (make-instance 'sprite :source-path source-path
                                        :source-x source-x
                                        :source-y source-y
                                        :source-w width
                                        :source-h height
                                        :source-rect (sdl2:make-rect source-x source-y width height)))
         (surface (sdl2-image:load-image source-path))
         (texture (sdl2:create-texture-from-surface (renderer graphics) surface)))
    (sdl2:free-surface surface)
    (setf (texture sprite) texture)
    (sb-ext:finalize sprite (lambda () (sdl2:destroy-texture texture)))
    sprite))

(defgeneric draw (self graphics x y))
(defmethod draw ((sprite sprite) graphics x y)
  (sdl2:render-copy (renderer graphics) (texture sprite) :source-rect (source-rect sprite) :dest-rect (sdl2:make-rect x y (source-w sprite) (source-h sprite))))
