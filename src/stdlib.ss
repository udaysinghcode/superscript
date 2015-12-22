

(= identity (fn (e) e));;

(= length (fn (l)
  (if (is l '()) 0 
    {1 + (length (tail l))})));;

/*
(= nth (fn (n l)
  (if (or (is l '()) {n < 0}) (exception "nth: index out of bounds.")
    (if (is n 0) (head l)
      (nth {n - 1} (tail l))))));;*/

(= map (fn (f l)
  (if (is l '()) '()
    (cons (f (head l)) (map f (tail l))))));;


(= fold_left (fn (f a l) 
  (if (is l '()) a 
    (fold_left f (eval '(f a (head l))) (tail l)))));;

(= fold_right (fn (f l a)
  (if (is l '()) (eval '(identity a))
    (eval '(f (head l) (fold_right f (tail l) a))))));;

(= filter (fn (p l)
  (list (fold_right (fn (x y) (if (p x) (cons x y) y)) l '()))));;



(= intersperse (fn (e l) 
  (if (or (is l '()) (is (tail l) '())) l 
    (cons (head l) (cons e (intersperse e (tail l)))))));;

(= stringify_list (fn (f l) 
  (++ "[" (fold_left ++ "" (intersperse "," (map f l))) "]")));;

(= print_list (fn (f l)
  (prn (stringify_list f l))));;

