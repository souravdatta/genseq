#lang typed/racket/base

(module+ test
  (require typed/rackunit))

;; Notice
;; To install (from within the package directory):
;;   $ raco pkg install
;; To install (once uploaded to pkgs.racket-lang.org):
;;   $ raco pkg install <<name>>
;; To uninstall:
;;   $ raco pkg remove <<name>>
;; To view documentation:
;;   $ raco docs <<name>>
;;
;; For your convenience, we have included a LICENSE.txt file, which links to
;; the GNU Lesser General Public License.
;; If you would prefer to use a different license, replace LICENSE.txt with the
;; desired license.
;;
;; Some users like to add a `private/` directory, place auxiliary files there,
;; and require them in `main.rkt`.
;;
;; See the current version of the racket style guide here:
;; http://docs.racket-lang.org/style/index.html

;; Code here

(module+ test
  (require "genseq-core.rkt")
  (require "lists.rkt")
  (require "extras.rkt")

  (check-equal? (seq->list null-seq) '())
  (check-equal? (seq->list (s/cons 1 (s/cons 2 (s/cons 3 null-seq)))) '(1 2 3))
  (check-equal? (seq->list (s/map (λ ([x : Integer]) (+ x 1)) (list->seq '(1 2 3)))) '(2 3 4))
  (check-equal? (s/reduce (λ ([start : Integer]
                              [next : Integer]) (+ start next))
                          (list->seq '(1 2 3 4))
                          0) 10)
  (check-equal? (seq->list (s/filter odd? (list->seq '(1 7 2 5 9 10 22 17)))) '(1 7 5 9 17))
  (check-equal? (seq->list (s/take 5 positive-numbers)) '(1 2 3 4 5))
  (check-equal? (seq->list (s/take 5 nonnegative-numbers)) '(0 1 2 3 4))
  (check-equal? (seq->list (s/take 5 negative-numbers)) '(-1 0 1 2 3))
  (check-equal? (seq->list (s/take-while odd? (list->seq '(3 5 1 2 4 7)))) '(3 5 1))
  
  )

(require "genseq-core.rkt")
(provide (all-from-out "genseq-core.rkt"))


