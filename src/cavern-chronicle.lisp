(in-package :cavern-chronicle)

(defun boring-entrypoint ()
  (let ((start-time (sdl2:get-ticks)))
    (sdl2:with-init (:everything)
      (sdl2:hide-cursor)
      (f:with-ttf-init
        (sdl2:with-window (window :w +screen-width+ :h +screen-height+ :flags '(:shown)) ; could add :fullscreen here
          (sdl2:with-renderer (renderer window :flags '(:accelerated :presentvsync))
            (event-loop (make-game renderer) start-time)))))))

(defun event-loop (game start-time)
  ;; TODO: rewrite from iterative loop to recursive function so we can hotpatch
  (sdl2:with-event-loop (:method :poll)
    (:keydown (:keysym keysym)
              (print keysym))
    (:keyup (:keysym keysym)
            (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
              (sdl2:push-event :quit)))
    (:idle ()
           (update game)
           (draw game (graphics game) 0 0)
           (let ((elapsed-time (- (sdl2:get-ticks) start-time)))
             (declare (ignore elapsed-time))
             #++(f:out elapsed-time))
           ;; put it at the end so we include the time needed to process events
           (setf start-time (sdl2:get-ticks)))
    (:quit ()
           (graphics-destroy (graphics game))
           t)))
