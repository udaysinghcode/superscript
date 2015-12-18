let generate_stdlib_func fname = 
  match fname with
    "map" -> "(= map (fn (f l) (if (is (tail l) '()) (cons (f (head l)) '()) (cons (f (head l)) (map f (tail l))))));;"
  | "fold_left" -> "(= fold_left (fn (f a l) (if (is l '()) a (fold_left f (f a (head l)) (tail l)) )));;"
  | "append" -> "(= append (fn (a b) (if (is a '()) b (cons (head a) (append (tail a) b)))));;"
  | "length" -> "(= length (fn (l) (if (is l '()) 0 (+ 1 (length (tail l))))));;"
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
  | "reverse" -> "(= reverse (fn (l) (if (is l '()) l (append (reverse (tail l)) (cons (head l) '())))));;"
  | _ -> ""






