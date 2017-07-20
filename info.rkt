#lang info
(define collection "genseq")
(define deps '("base"
               "typed-racket-lib"
               "typed-racket-more"
               "rackunit-lib"))
(define build-deps '("scribble-lib" "racket-doc"))
(define scribblings '(("scribblings/genseq.scrbl" ())))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(sourav))
