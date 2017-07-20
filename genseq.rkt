#lang typed/racket

;; interface

(struct (a) Seq ([first : (-> (U False a))]
                 [rest : (-> (Seq a))]
                 [cons : (-> a (Seq a) (Seq a))]))

(: sfirst (All (a) (-> (Seq a) (U False a))))
(define (sfirst s) ((Seq-first s)))

(: srest (All (a) (-> (Seq a) (Seq a))))
(define (srest s) ((Seq-rest s)))

(: scons (All (a) (-> a (Seq a) (Seq a))))
(define (scons x s)
  ((Seq-cons s) x s))

;; algorithms

(: sreduce (All (a b) (-> (-> b a b)
                          b
                          (Seq a)
                          b)))
(define (sreduce rfn start sq)
  (let ([f (sfirst sq)])
    (if f
        (sreduce rfn (rfn start f) (srest sq))
        start)))

(: smap (All (a b) (-> (-> a b)
                         (Seq a)
                         (-> (Seq b) (Seq b)))))
(define (smap mfn s)
  ;; helper map which calls reduce
  
  (: smap1 (All (a b) (-> (-> a b)
                         (Seq a)
                         (Seq b)
                         (Seq b))))
  (define (smap1 mfn s esb)
    (sreduce (λ ([r : (Seq b)]
                 [x : a])
               (scons (mfn x) r))
             esb
             s))

  (λ ([esb : (Seq b)]) : (Seq b)
    (smap1 mfn s esb)))
  
;; implementation - list

(: list->seq (All (a) (-> (Listof a) (Seq a))))
(define (list->seq l)
  (let ([consf (λ ([x : a]
                   [s : (Seq a)])
                 (list->seq (cons x (seq->list s))))]
        [empty-consf (λ () #{(list->seq empty) :: (Seq a)})])
    (if (empty? l)
        (Seq
         (λ () #f)
         empty-consf
         consf)
        (Seq
         (λ () (car l))
         (λ () (list->seq (cdr l)))
         consf))))

(: seq->list (All (a) (-> (Seq a) (Listof a))))
(define (seq->list s)
  (let ([x : (U a False) (sfirst s)])
    (if x
        (cons x (seq->list (srest s)))
        empty)))

(define-syntax-rule (empty-list-seq type)
  (list->seq #{empty :: (Listof type)}))

;; implementation - vector

(: vector->seq (All (a) (-> (Vectorof a) (Seq a))))
(define (vector->seq v)
  (let ([consf (λ ([x : a]
                   [y : (Seq a)])
                 (vector->seq (vector-append (seq->vector y) (vector x))))]
        [empty-consf (λ () #{(vector->seq #()) :: (Seq a)})])
    (if (= (length (vector->list v)) 0)
        (Seq
         (λ () #f)
         empty-consf
         consf)
        (Seq
         (λ () (vector-ref v 0))
         (λ () (vector->seq (list->vector (cdr (vector->list v)))))
         consf))))

(: seq->vector (All (a) (-> (Seq a) (Vectorof a))))
(define (seq->vector s)
  (let ([x (sfirst s)])
    (if x
        (vector-append (vector x)
                       (seq->vector (srest s)))
        (vector))))

(define-syntax-rule (empty-vector-seq type)
  (vector->seq #{#[] :: (Vectorof type)}))
