(define (find s predicate)
  'YOUR-CODE-HERE
  (cond
    ( (null? s) #f )
    ( (predicate (car s)) (car s) )
    ( else (find (cdr-stream s) predicate) )
  )
)

(define (scale-stream s k)
  'YOUR-CODE-HERE
  (cond
    ( (null? s) s )
    ( else (cons-stream (* (car s) k) (scale-stream (cdr-stream s) k)) )
  )
)

(define (has-cycle s)
  'YOUR-CODE-HERE
  (define (helper s-tail)
    (cond
      ( (null? s-tail) #f )
      ( (eq? s s-tail) #t )
      ( else (helper (cdr-stream s-tail)) )
    )
  )
  (helper (cdr-stream s))
)

(define (has-cycle-constant s)
  'YOUR-CODE-HERE
  (define (helper s-tail)
    (cond
      ( (null? s-tail) #f )
      ( (eq? s s-tail) #t )
      ( else (helper (cdr-stream s-tail)) )
    )
  )
  (helper (cdr-stream s))
)
