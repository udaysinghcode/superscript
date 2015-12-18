
let get_stdlib = String.concat "" [
"(= identity (fn (x) x));;";
"(= map (fn (f l) (if (is (tail l) '()) (cons (f (head l)) '()) (cons (f (head l)) (map f (tail l))))));;";
"(= fold_left (fn (f a l) (if (is l '()) a (fold_left f (eval '(f a (head l))) (tail l)) )));;";
"(= fold_right (fn (f l a) (if (is l '()) (eval '(identity a)) (eval '(f (head l) (fold_right f (tail l) a))))));;";
"(= append (fn (a b) (if (is a '()) b (cons (head a) (append (tail a) b)))));;";
"(= length (fn (l) (if (is l '()) 0 (+ 1 (length (tail l))))));;";
"(= zipwith (fn (f a b) (if (or (is a '()) (is b '())) '() (cons (f (head a) (head b)) (zipwith f (tail a) (tail b))))));;";
"(= zip (fn (a b) (zipwith (fn (x y) (cons x (cons y '()))) a b)));;";
"(= nth (fn (n l) (if (is n 0) (head l) (nth (- n 1) (tail l))) ));;";
"(= first (fn (l) (nth 0 l)));;";
"(= second (fn (l) (nth 1 l)));;";
"(= third (fn (l) (nth 2 l)));;";
"(= fourth (fn (l) (nth 3 l)));;";
"(= fifth (fn (l) (nth 4 l)));;";
"(= sixth (fn (l) (nth 5 l)));;";
"(= seventh (fn (l) (nth 6 l)));;";
"(= eighth (fn (l) (nth 7 l)));;";
"(= ninth (fn (l) (nth 8 l)));;";
"(= tenth (fn (l) (nth 9 l)));;";
"(= last (fn (l) (nth (- (length l) 1) l)));;";
"(= reverse (fn (l) (if (is l '()) l (append (reverse (tail l)) (cons (head l) '())))));;";
"(= member (fn (e l) (if (is l '()) false (if (boolean (eval '(is (head l) e))) true (member e (tail l))))));;";
"(= intersperse (fn (e l) (if (or (is l '()) (is (tail l) '())) l (cons (head l) (cons e (intersperse e (tail l)))))));;";
"(= print_list (fn (f l) (prn (++ \"[\"(fold_left ++ \"\" (intersperse \",\" (map f l))) \"]\"))));;";
]
