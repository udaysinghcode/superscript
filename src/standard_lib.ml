let generate_stdlib_func fname = 
  match fname with
    "map" -> "(= map (fn (f l) (if (is (tail l) '()) (cons (f (head l)) '()) (cons (f (head l)) (map f (tail l))))));;"
  | "fold_left" -> "(= fold_left (fn (f a l) (if (is l '()) a (fold_left f (f a (head l)) (tail l)) )));;"
  | "length" -> "(= length (fn (l) (if (is l '()) 0 (+ 1 (length (tail l))))));;"
  | "get" -> "(= get (fn (n l) (if (is n 0) (head l) (get (- n 1) (tail l))) ));;"
  | _ -> ""






