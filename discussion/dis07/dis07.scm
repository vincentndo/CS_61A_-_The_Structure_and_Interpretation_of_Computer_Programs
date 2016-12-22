(define (concat a b)
  '____YOUR_SOLUTION_HERE____
  (cond
    ( (null? b) a )
    ( (null? a) b )
    ( else (cons (car a) (concat (cdr a) b)) )
  )
)

(concat '(1 2 3) '(2 3 4))
;(1 2 3 2 3 4)
(concat '(1 2 3) '())
;(1 2 3)


(define (map fn lst)
  (if (null? lst)
    nil
  (cons (fn (car lst)) (map fn (cdr lst)))))

(define (deep-apply fn nested-list)
  '____YOUR_SOLUTION_HERE____
  (cond
    ( (null? nested-list) nil )
    ( (number? nested-list) (fn nested-list) )
    ( else (cons (deep-apply fn (car nested-list)) (deep-apply fn (cdr nested-list))) )
  )
)

(deep-apply (lambda (x) (* x x)) '(1 2 3))
;(1 4 9)
(deep-apply (lambda (x) (* x x)) '(1 ((4) 5) 9))
;(1 ((16) 25) 81)
(deep-apply (lambda (x) (* x x)) 2)
;4