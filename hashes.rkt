#lang typed/racket

(require "genseq-core.rkt")
(require "lists.rkt")


(: hash->seq (All (a b) (-> (HashTable a b) (Seq (Pairof a b)))))
(define (hash->seq hs)
  (list->seq (hash->list hs)))

(: seq->hash (All (a b) (-> (Seq (Pairof a b)) (HashTable a b))))
(define (seq->hash seq)
  (make-immutable-hash (seq->list seq)))

(: seq->mutable-hash (All (a b) (-> (Seq (Pairof a b)) (Mutable-HashTable a b))))
(define (seq->mutable-hash seq)
  (make-hash (seq->list seq)))

(: seq->mutable-hasheqv (All (a b) (-> (Seq (Pairof a b)) (Mutable-HashTable a b))))
(define (seq->mutable-hasheqv seq)
  (make-hasheqv (seq->list seq)))

(: seq->mutable-hasheq (All (a b) (-> (Seq (Pairof a b)) (Mutable-HashTable a b))))
(define (seq->mutable-hasheq seq)
  (make-hasheq (seq->list seq)))

(: seq->immutable-hash (All (a b) (-> (Seq (Pairof a b)) (Immutable-HashTable a b))))
(define (seq->immutable-hash seq)
  (make-immutable-hash (seq->list seq)))

(: seq->immutable-hasheqv (All (a b) (-> (Seq (Pairof a b)) (Immutable-HashTable a b))))
(define (seq->immutable-hasheqv seq)
  (make-immutable-hasheqv (seq->list seq)))

(: seq->immutable-hasheq (All (a b) (-> (Seq (Pairof a b)) (Immutable-HashTable a b))))
(define (seq->immutable-hasheq seq)
  (make-immutable-hasheq (seq->list seq)))

