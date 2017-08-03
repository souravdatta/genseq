#lang typed/racket

(require "genseq-core.rkt")
(require "lists.rkt")

(require math/number-theory)


(: to-inf-from (-> Integer (Seq Integer)))
(define (to-inf-from n)
  (s/cons n (to-inf-from (+ n 1))))

(: nonnegative-numbers (Seq Integer))
(define nonnegative-numbers (to-inf-from 0))

(: negative-numbers (Seq Integer))
(define negative-numbers (to-inf-from (- 1)))

(: positive-numbers (Seq Integer))
(define positive-numbers (to-inf-from 1))

(: prime-numbers (Seq Integer))
(define prime-numbers (s/filter prime? positive-numbers))

(provide to-inf-from
         nonnegative-numbers
         negative-numbers
         positive-numbers
         prime-numbers)
