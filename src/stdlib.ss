/* ~&&~&*~ Superscript Standard Library ~&~&~*~~ */

/* identity takes an expression e and returns it. */
(= identity (fn (e) e));;

/* length takes a list l and returns its length. */
(= length (fn (l)
  (if (is l '()) 0 
    {1 + (length (tail l))})));;

/* nth takes an int n and a list l and returns the nth element of the list. */
(= nth (fn (n l)
  (if (or (is l '()) {n < 0}) (exception "nth: index out of bounds.")
    (if (is n 0) (head l)
      (nth {n - 1} (tail l))))));;

/* first takes a list l and returns the first element. */
(= first (fn (l) (nth 0 l)));;

/* second takes a list l and returns the second element. */
(= second (fn (l) (nth 1 l)));;

/* third takes a list l and returns the third element. */
(= third (fn (l) (nth 2 l)));;

/* fourth takes a list l and returns the fourth element. */
(= fourth (fn (l) (nth 3 l)));;

/* fifth takes a list [l] and returns the fifth element. */
(= fifth (fn (l) (nth 4 l)));;

/* sixth takes a list l and returns the sixth element. */
(= sixth (fn (l) (nth 5 l)));;

/* seventh takes a list and returns the seventh element. */
(= seventh (fn (l) (nth 6 l)));;

/* eighth takes a list and returns the eighth element. */
(= eighth (fn (l) (nth 7 l)));;

/* ninth takes a list and returns the ninth element. */
(= ninth (fn (l) (nth 8 l)));;

/* tenth takes a list and returns the tenth element. */
(= tenth (fn (l) (nth 9 l)));;

/* last takes a list and returns the last element. */
(= last (fn (l) (nth (- (length l) 1) l)));;

/* map takes a function f and a list l. It performs the function
   on each element of the list, and returns a list of the results. */
(= map (fn (f l)
  (if (is l '()) '()
    (cons (f (head l)) (map f (tail l))))));;

/* fold_left takes a function f, list a, and list l. It performs the
   function f on each element of list l, starting from the left,
   and stores the results in the accumulator list a.  It returns a. */
(= fold_left (fn (f a l) 
  (if (is l '()) a 
    (fold_left f (eval '(f a (head l))) (tail l)))));;

/* fold_right takes a function f, list l, and list a. It performs
   the function f on each element of list l, starting from the right,
   and stores the results in the accumulator list a. It returns a. */
(= fold_right (fn (f l a)
  (if (is l '()) (eval '(identity a))
    (eval '(f (head l) (fold_right f (tail l) a))))));;

(= filter (fn (p l)
  (list (fold_right (fn (x y) (if (p x) (cons x y) y)) l '()))));;

(= partition 
  (fn (p l) 
    (fold_right 
       (fn (x y) 
	   '(
		(if (p x) 
		   (cons x (first y)) 
		   (first y)) 
		(if (p x) 
		   (second y) 
		   (cons x (second y)))
	    )
	) 
	l 
	'( '()  '()  )
    )
  )
);;

/* append takes an element a, and a list b, and returns a list
   where a is appended onto the front of b. */
(= append (fn (a b) 
  (if (is a '()) 
    b 
    (cons (head a) (append (tail a) b)))));;

/* reverse takes a list l, and returns a list that is l reversed. */
(= reverse (fn (l) 
  (if (is l '()) 
    l 
    (append (reverse (tail l)) (cons (head l) '())))));;

/* drop takes an int i and list l. It drops the first i elements
   from the front of the list, and returns the resulting list. */
(= drop (fn (i l) 
  (if (< i 1) 
    l 
    (drop (- i 1) (tail l)))));;

/* take takes an int i and a list l. It returns a list containing
   the first i elements of the list l. */
(= take (fn (i l) 
  (if (or (not (> i 0)) (is l '())) 
    '() 
    (cons (head l) (take (- i 1) (tail l))))));;

(= take1 (fn (lst num)
             (if (> num 0)
               (cons (head lst) (take1 (tail lst) (- num 1)))
               '())));;

/* intersperse takes an expression and a list. It inserts the
   expression between each pair of elements in the list,
   and returns the resulting list. */
(= intersperse (fn (e l) 
  (if (or (is l '()) (is (tail l) '())) 
    l 
    (cons (head l) (cons e (intersperse e (tail l)))))));;

/* stringify_list takes a function f and list l. The function f should
   be an anonymous function declaration which can transform each element
   of the list l into a string. The transformed list is stringified, with
   commas separating the elements, and returned as a string. */
(= stringify_list (fn (f l) 
  (++
    "[" 
    (fold_left ++ "" (intersperse "," (map f l))) 
    "]")));;

/* print_list takes a function f and list l. The function f should be an
   anonymous function declaration which can transform each element of the list l
   into a string.  The transformed list is stringified, and this string is printed. */
(= print_list (fn (f l)
  (prn (stringify_list f l))));;

###ENDSTDLIB###
