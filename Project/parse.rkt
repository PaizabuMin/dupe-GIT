#lang racket
(provide parse)
(require "ast.rkt")

;; S-Expr -> Expr
(define (parse s)
  (match s
    [(? datum?)          (Lit s)]
    [(list (? op1? o) e) (Prim1 o (parse e))]
    [(list 'if e1 e2 e3)
     (If (parse e1) (parse e2) (parse e3))]
    [(list 'case e cs ...)
     (let ([else (last cs)])
       (if (equal? (first else) 'else)
        (Case (parse e) (map (λ (c)
                     (match c
                       [(list test expr)
                         (Clause test (parse expr))]
                       [_ (error "Ivalid Clause" c)]))
                   (drop-right cs 1))
        (parse (last else)))
        (error "Parse-Case error: Ivalid else")))]
    [(list 'cond cs ...)
     (let ([else (last cs)])
       (if (equal? (first else) 'else)
        (Cond (map (λ (c)
                     (match c
                       [(list test expr) (Clause (parse test) (parse expr))]
                       [_ (error "Ivalid Clause" c)]))
                   (drop-right cs 1))
        (parse (last else)))
        (error "Parse-Cond error: Ivalid else")))]
    [_ (error "Parse error")]))

;; Any -> Boolean
(define (datum? x)
  (or (exact-integer? x)
      (boolean? x)))

(define (op1? x)
  (memq x '(add1
            sub1
            zero?
            abs
            -
            not)))



