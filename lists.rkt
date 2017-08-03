#lang typed/racket

(require "genseq-core.rkt")


(: list->seq (All (a) (-> (Listof a) (Seq a))))
(define (list->seq ls)
  (if (empty? ls)
      null-seq
      (s/cons (first ls)
              (list->seq (rest ls)))))

(: seq->list (All (a) (-> (Seq a) (Listof a))))
(define (seq->list seq)
  (if (null-seq? seq)
      '()
      (cons (s/first seq)
            (seq->list (s/rest seq)))))

(provide (all-defined-out))
