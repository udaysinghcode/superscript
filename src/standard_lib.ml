
let get_stdlib = String.concat "" [

  "(= identity (fn (x) x));;";

  "(= length (fn (l) (if (is l '()) 0 (+ 1 (length (tail l))))));;";

  "(= nth (fn (n l) (if (is n 0) (head l) (nth (- n 1) (tail l))) ));;"; (* change this *)

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

  "(= make (fn (n f) (if (> n 0) (if (> n 1) (cons (f n) (make f (- n 1))) '((f 1))) '())));;";

  "(= map (fn (f l) (if (is (tail l) '()) (cons (f (head l)) '()) (cons (f (head l)) (map f (tail l))))));;";

  "(= fold_left (fn (f a l) (if (is l '()) a (fold_left f (eval '(f a (head l))) (tail l)) )));;";

  "(= fold_right (fn (f l a) (if (is l '()) (eval '(identity a)) (eval '(f (head l) (fold_right f (tail l) a))))));;";

  "(= filter (fn (f l) (fold_right (fn (x y) (if (f x) (cons x y) y)) l '())));;";

  "(= partition (fn (f l) (fold_right (fn (x y) '((if (f x) (cons x (first y)) (first y)) (if (f x) (second y) (cons x (second y))))) l '('() '()))));;";

  "(= append (fn (a b) (if (is a '()) b (cons (head a) (append (tail a) b)))));;";

  "(= take (fn (i l) (if (or (not (> i 0)) (is l '())) '() (cons (head l) (take (- i 1) (tail l))))));;";

  "(= drop (fn (i l) (if (< i 1) l (drop (- i 1) (tail l)))));;";

  "(= zipwith (fn (f a b) (if (or (is a '()) (is b '())) '() (cons (f (head a) (head b)) (zipwith f (tail a) (tail b))))));;";

  "(= zipwith3 (fn (f a b c) (if (or (or (is a '()) (is b '())) (is c '())) '() (cons (f (head a) (head b) (head c)) (zipwith3 f (tail a) (tail b) (tail c))))));;";

  "(= zip (fn (a b) (zipwith (fn (x y) (cons x (cons y '()))) a b)));;";

  (*"(= zip3 (fn (a b c) (zipwith (fn (x y z) (cons x (cons y (cons z '())))) a b c)));;"; *)

  "(= unzip (fn (l) (fold_right (fn (x y) '((cons (first x) (first y)) (cons (second x) (second y)))) l '('() '()))));;";

  "(= reverse (fn (l) (if (is l '()) l (append (reverse (tail l)) (cons (head l) '())))));;";

  "(= member (fn (e l) (if (is l '()) false (if (boolean (eval '(is (head l) e))) true (member e (tail l))))));;";

  "(= intersperse (fn (e l) (if (or (is l '()) (is (tail l) '())) l (cons (head l) (cons e (intersperse e (tail l)))))));;";

  "(= stringify_list (fn (f l) (++ \"[\" (fold_left ++ \"\" (intersperse \",\" (map f l))) \"]\")));;";

  "(= print_list (fn (f l) (prn (stringify_list f l))));;";


]