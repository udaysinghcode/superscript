let generate_stdlib_func fname = 
  match fname with
    "map" -> "(= map (fn (f l) (if (is (tail l) '()) (cons (f (head l)) '()) (cons (f (head l)) (map f (tail l))))));;"
  | "fold_left" -> "(= fold_left (fn (f a l) (if (is l '()) a (fold_left f (eval '(f a (head l))) (tail l)) )));;"
  | "fold_right" -> "(= fold_right (fn (f l a) (if (is l '()) (eval '((fn (x) x) a)) (eval '(f (head l) (fold_right f (tail l) a))))));;"
  | "append" -> "(= append (fn (a b) (if (is a '()) b (cons (head a) (append (tail a) b)))));;"
  | "length" -> "(= length (fn (l) (if (is l '()) 0 (+ 1 (length (tail l))))));;"
  | "zipwith" -> "(= zipwith (fn (f a b) (if (or (is a '()) (is b '())) '() (cons (f (head a) (head b)) (zipwith f (tail a) (tail b))))));;"
  | "zip" -> "(= zip (fn (a b) (zipwith (fn (x y) (cons x (cons y '()))) a b)));;"
  | "nth" -> "(= nth (fn (n l) (if (is n 0) (head l) (nth (- n 1) (tail l))) ));;"
  | "first" -> "(= first (fn (l) (nth 0 l)));;"
  | "second" -> "(= first (fn (l) (nth 1 l)));;"
  | "third" -> "(= first (fn (l) (nth 2 l)));;"
  | "fourth" -> "(= first (fn (l) (nth 3 l)));;"
  | "fifth" -> "(= first (fn (l) (nth 4 l)));;"
  | "sixth" -> "(= first (fn (l) (nth 5 l)));;"
  | "seventh" -> "(= first (fn (l) (nth 6 l)));;"
  | "eighth" -> "(= first (fn (l) (nth 7 l)));;"
  | "ninth" -> "(= first (fn (l) (nth 8 l)));;"
  | "tenth" -> "(= first (fn (l) (nth 9 l)));;"
  | "last" -> "(= last (fn (l) (nth (- (length l) 1) l)));;"
  | "reverse" -> "(= reverse (fn (l) (if (is l '()) l (append (reverse (tail l)) (cons (head l) '())))));;"
  | "member" -> "(= member (fn (e l) (if (is l '()) false (if (boolean (eval '(is (head l) e))) true (member e (tail l))))));;"
  | _ -> ""




