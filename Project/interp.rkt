#lang racket
(provide interp)
(require "ast.rkt")
(require "interp-prim.rkt")

;; type Value =
;; | Integer
;; | Boolean

;; Expr -> Value
(define (interp e)
  (match e
    [(Lit d) d]
    [(Prim1 p e)
     (interp-prim1 p (interp e))]
    ;; TODO: Handle cond
    [(Cond cs e)
     (match cs
       ['() (interp e)]
       [(cons (Clause test expr) cls)
         (if (interp test) (interp expr) (interp (Cond cls e)))])]
    ;; TODO: Handle case
    [(Case e cs l)
     (match cs
       ['() (interp l)]
       [(cons (Clause dats e2) cls)
         (if (val-equal dats e) (interp e2) (interp (Case e cls l)))])]
    [(If e1 e2 e3)
     (if (interp e1)
         (interp e2)
         (interp e3))]))

;;[List of Datum] Expr -> Boolean 
(define (val-equal dats e)
  (match dats
    ['() #f]
    [(cons dat rest)
      (if (equal? dat (interp e)) #t (val-equal rest e))]))

