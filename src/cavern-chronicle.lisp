(in-package :cavern-chronicle)

(defun update ()
  )

(defun draw (renderer)
  (sdl2:set-render-draw-color renderer 40 40 40 255)
  (sdl2:render-clear renderer)
  (sdl2:render-present renderer))

(defun play ()
  (let ((window-width 640)
        (window-height 480)
        (window-bpp 32)
        (start-time (sdl2:get-ticks)))
    (sdl2:with-init (:everything)
      (sdl2:hide-cursor)
      (f:with-ttf-init
        (sdl2:with-window (window :w window-width :h window-height :flags '(:shown))
          (sdl2:with-renderer (renderer window :flags '(:accelerated :presentvsync))
            (let ((screen (sdl2:create-rgb-surface window-width window-height window-bpp)))
              (declare (ignore screen))
              (sdl2:with-event-loop (:method :poll)
                (:keydown (:keysym keysym)
                          (print keysym))
                (:keyup (:keysym keysym)
                        (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
                          (sdl2:push-event :quit)))
                (:idle ()
                       (update)
                       (draw renderer)
                       (let ((elapsed-time (- (sdl2:get-ticks) start-time)))
                         (declare (ignore elapsed-time)))
                       (setf start-time (sdl2:get-ticks)))
                (:quit ()
                       t)))))))))
