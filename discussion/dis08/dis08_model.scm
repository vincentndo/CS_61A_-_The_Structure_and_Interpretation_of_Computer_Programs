(define (fib n) ;;define the function fib and variable n
  (fib-iter 1 0 n)) ;;?? no idea

(define (fib-iter a b count) ;;define function fib-iter, variables a, b and count
  (if (= count 0) ;;if the count is equal to 0, 
    b ;;return b
    (fib-iter (+ a b) a (- count 1)))) 

(fib 10)