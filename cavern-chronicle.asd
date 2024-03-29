;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(defpackage #:cavern-chronicle-asd
  (:use :cl :asdf))

(in-package :cavern-chronicle-asd)

(defsystem cavern-chronicle
  :name "cavern-chronicle"
  :version "0.0.0"
  :maintainer "fouric"
  :author "fouric"
  :license "All rights reserved"
  :description "reimplementation of \"reconstructing cave story\" in common lisp"

  :serial t
  :depends-on (:sdl2 :sdl2-image :fouric)
  :pathname "src"
  :components ((:file "game")
               (:file "package")
               (:file "graphics")
               (:file "sprite")
               (:file "animated-sprite")
               (:file "cavern-chronicle")))
