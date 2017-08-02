#lang typed/racket

(provide null-seq
         null-seq?
         Seq
         Collection
         s/as-seq
         s/first
         s/rest
         s/cons
         s/reduce
         s/map)
         
(struct empty-seq ())

(: null-seq empty-seq)
(define null-seq (empty-seq))

(: null-seq? (-> Any Boolean))
(define null-seq? empty-seq?)

(define-type (Seq a) (U empty-seq (Pairof a (-> (Seq a)))))

(define-type (Collection a) (Object (seq (-> (Seq a)))))

(: s/as-seq (All (a) (-> (Collection a) (Seq a))))
(define (s/as-seq c) (send c seq))

(: s/first (All (a) (-> (Seq a) a)))
(define (s/first s)
  (if (empty-seq? s)
      (error "Sequence is empty")
      (car s)))

(: s/rest (All (a) (-> (Seq a) (Seq a))))
(define (s/rest s)
  (if (empty-seq? s)
      (error "Sequence is empty")
      ((cdr s))))

(define-syntax-rule (s/cons x y)
  (cons x (λ () y)))

(: s/reduce (All (a b) (-> (-> b a b)
                         (Seq a)
                         b
                         b)))
(define (s/reduce rfn seq start)
  (if (empty-seq? seq)
      start
      (s/reduce rfn (s/rest seq) (rfn start (s/first seq)))))

(: s/map (All (a b) (-> (-> a b)
                        (Seq a)
                        (Seq b))))
(define (s/map mfn seq)
  (if (null-seq? seq)
      null-seq
      (cons (mfn (s/first seq))
            (λ () : (Seq b)
              (s/map mfn (s/rest seq))))))

(: s/take (All (a) (-> Nonnegative-Integer (Seq a) (Seq a))))
(define (s/take n seq)
  (if (= n 0)
      null-seq
      (s/cons (s/first seq) (s/take (abs (- n 1)) (s/rest seq)))))




  