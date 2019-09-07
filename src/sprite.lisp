(in-package :cavern-chronicle)

(defclass sprite ()
  ((source-path :accessor source-path :initarg :source-path)
   (source-x :accessor source-x :initarg :source-x)
   (source-y :accessor source-y :initarg :source-y)
   (source-w :accessor source-w :initarg :source-w)
   (source-h :accessor source-h :initarg :source-h)
   (width :accessor width :initarg :width)
   (height :accessor height :initarg :height)
   (sheet :accessor sheet :initarg :sheet)
   (source-rect :accessor source-rect :initarg :source-rect)))

(defun make-sprite (source-path source-x source-y width height)
  (let ((sprite (make-instance 'sprite :source-path source-path
                                       :source-x source-x
                                       :source-y source-y
                                       :source-w width
                                       :source-h height
                                       :source-rect (sdl2:make-rect source-x source-y width height)))
        (sheet (sdl2-image:load-image source-path)))
    (setf (sheet sprite) sheet)
    (sb-ext:finalize sprite (lambda () (sdl2:free-surface sheet)))
    sprite))

(defgeneric draw (self graphics x y))
(defmethod draw ((sprite sprite) graphics x y)
  (blit-surface graphics (sheet sprite) (source-rect sprite) (sdl2:make-rect x y (source-w sprite) (source-h sprite))))
