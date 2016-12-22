(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.
(define (map proc items)
  ;'replace-this-line
  (cond
    ( (null? items) nil )
    ( else (cons (proc (car items)) (map proc (cdr items))) )
  )
)

(define (cons-all first rests)
  ;'replace-this-line
  (cond
    ( (null? rests) nil )
    ( else (cons (append (list first) (car rests)) (cons-all first (cdr rests))) )
  )
)

(define (zip pairs)
  ;'replace-this-line
  (cond
    ( (null? pairs) '(() ()) )
    ( else (cons (cons (car (car pairs)) (car (zip (cdr pairs)))) (cons (cons (car (cdr (car pairs))) (car (cdr (zip (cdr pairs))))) nil)) )
  )
)

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  ;'replace-this-line
  (define (enumerate_helper counter s)
    (cond
      ( (null? s) nil)
      ( else (cons (list counter (car s)) (enumerate_helper (+ counter 1) (cdr s))) )
    )
  )
  (enumerate_helper 0 s)
)
  ; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  ;'replace-this-line
  (cond
    ( (= total 0) '(()) )
    ( (null? denoms) nil )
    ( (< total (car denoms)) (list-change total (cdr denoms)) )
    ( else (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms))
              (list-change total (cdr denoms))
           )
    )
  )
)
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         ;'replace-this-line
          expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         ;'replace-this-line
          expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           ;'replace-this-line
            (cons form (cons params (let-to-lambda body)))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           ; 'replace-this-line
            (cons (list 'lambda (car (zip values)) (let-to-lambda (car body))) (map let-to-lambda (cadr (zip values))))
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         ; 'replace-this-line
          (map let-to-lambda expr)
         ; END PROBLEM 19
         )))
