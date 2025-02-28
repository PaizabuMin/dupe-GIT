#lang racket
(provide (all-defined-out))

;; TODO: Add other forms of expression to the type and structure
;; definitions

;; type Expr = (Lit Datum)
;;           | (Prim1 Op1 Expr)
;;           | (If Expr Expr Expr)
;;           | (Cond [Listof CondClause] Expr)
;;           | (Case Expr [Listof CaseClause] Expr)

;; type CondClause = (Clause Expr Expr)
;; type CaseClause = (Clause [Listof Datum] Expr)

;; type Datum = Integer
;;            | Boolean

;; type Op1 = 'add1  | 'sub1
;;          | 'zero? | 'abs
;;          | '-     | 'not

(struct Lit (d)        #:prefab)
(struct Prim1 (p e)    #:prefab)
(struct If (e1 e2 e3)  #:prefab)
(struct Cond (cs e)    #:prefab)
(struct Case (e cs el) #:prefab)
(struct Clause (p b)   #:prefab)
