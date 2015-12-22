open Ast;;
open Generator;;
open Scanner;;
open Unix;;

let load_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  (s) ;;

 let rec funct foo =
  try 
    let l = input_line foo in 
    match l with 
    | _ -> l::(funct foo)
  with End_of_file -> [] ;;


let write stuff =
  let oc = open_out "a.js" in
    output_string oc stuff;
    close_out oc;
;;

let tests = [
 ("prn function should log to stdout", "(prn \"Hello World!\");;", [], "Hello World!") ;
 ("string_of_int function should make string from int", "(prn (string_of_int 10));;", [], "10") ;
 ("string_of_boolean function should make string from boolean", "(pr (string_of_boolean true));;(pr (string_of_boolean false));;", [], "truefalse") ;
 ("type function should return type of string", "(prn (type \"Hello\"));;", [], "string") ;
 ("type function should return type of int", "(prn (type 10));;", [], "int") ;
 ("type function should return type of float", "(prn (type 2.2));;", [], "float") ;
 ("type function should return type of boolean", "(prn (type true));;", [], "boolean") ;
 ("type function should return type of list", "(prn (type '(10 20)));;", [], "list") ;
 ("type function should return type of function", "(prn (type (fn (x) (prn x))));;", [], "function") ;
 ("assignment operator", "(= foo \"Hello\");;(prn foo);;", [], "Hello") ;
 ("user defined functions", "(= foo (fn (x) (prn x)));;(foo \"Bar\");;", [], "Bar") ;
 ("curly infix arithmetic expression", "(prn (string_of_int {5 + 3}));;", [], "8") ;
 ("+ operator with no args should return 0", "(prn (string_of_int (+)));;", [], "0") ;
 ("* operator with no args should return 1", "(prn (string_of_int (*)));;", [], "1") ;
 ("prefix integer add", "(prn (string_of_int (+ 1 2 3 4)));;", [], "10") ;
 ("prefix integer sub", "(prn (string_of_int (- 10 2 3)));;", [], "5") ;
 ("prefix integer mult", "(prn (string_of_int (* 1 2 3 4)));;", [], "24") ;
 ("prefix integer div", "(prn (string_of_int (/ 10 2 (- 5))));;", [], "-1") ;
 ("prefix float add", "(prn (string_of_float (+. .1 .2 .3 .4)));;", [], "1") ;
 ("prefix float sub", "(prn (string_of_float (-. 5.0 .2 .3)));;", [], "4.5") ;
 ("prefix float mult", "(prn (string_of_float (*. 1. 2. 3. 4.)));;", [], "24") ;
 ("prefix float div", "(prn (string_of_float (/. 10. 2. (-.5.))));;", [], "-1") ;
 ("comparing ints with is func", "(pr (string_of_boolean (is 1 1)));;(pr (string_of_boolean (is 1 2)));;", [], "truefalse") ;
 ("comparing floats with is func", "(pr (string_of_boolean (is 1.0 1.)));;(pr (string_of_boolean (is .1 .2)));;", [], "truefalse") ;
 ("comparing bools with is func", "(pr (string_of_boolean (is true true)));;(pr (string_of_boolean (is false true)));;", [], "truefalse") ;
 ("comparing strings with is func", "(pr (string_of_boolean (is \"hello\" \"world\")));;(pr (string_of_boolean (is \"world\" \"world\")));;", [], "falsetrue") ;  
 ("empty list should be nil", "(prn (string_of_boolean (is '() nil)));;", [], "true") ;
 ("head function should return head of list", "(prn (head '(\"foo\" \"bar\")));;", [], "foo") ;
 ("tail function should return tail of list", "(prn (head (tail '(\"foo\" \"bar\"))));;", [], "bar") ;
 ("++ operator concatenates strings", "(prn (++ \"foo\" \"bar\" \"orange\"));;", [], "foobarorange") ;
 ("< operator should compare ints", "(pr (string_of_boolean (< 9 10)));;(pr (string_of_boolean (< 11 10)));;", [], "truefalse") ;
 ("if statements", "(if true (pr \"foo\") (pr \"bar\"));;(if false (pr \"foos\") (pr \"bars\"));;", [], "foobars") ;
 ("get first element (int) of list", "(prn (string_of_int (head \'(1 2 3 4 5 6 7 8 9 10))));;", [], "1");  
 ("multiple expressions", "( prn \"hello\" );; ( prn \"world\" );;  ( prn \"people\");;", [], "hello\nworld\npeople");
 ("set add equal to anon func then call it", "(= add (fn (x y) (+ x y) )) ;;(prn (string_of_int (add 1 3)));; ", [],  "4");
 ("print the 5 mod 6", "(prn (string_of_int (mod 5 6)));;", [], "5");
 ("logical AND of true and false","(prn (string_of_boolean (and true false)));;", [], "false");
 ("setting and testing inequality", "(= a \"a\");; (prn (string_of_boolean (is \"a\" a)));;", [], "true");
 ("testing relational comparison operators", "(prn (string_of_boolean (> 2 4)));;", [], "false");
 ("testing string concatenation", "(prn (++ \"hello\" \" \" \"world\" ));;", [], "hello world");
 ("testing cons function", "(prn (head (cons \"a\" \'(\"b\" \"c\"))));;", [], "a");
 ("testing if function", "(prn (if false \"b\" \"c\"));;", [], "c");
 ("print out float with string_of_float", "(prn (string_of_float 3.5));;", [], "3.5");
 ("print out result of infix expr","(prn (string_of_int {3+ 5}));;", [], "8");
 ("print out int with string_of_int","(prn (string_of_int 3));;", [], "3");
 ("print out sum of list ","(prn (string_of_int (+ 3 4 2 5 3 2 5)));;", [], "24");
 ("print out list using print_list","(print_list string '(\"a\" \"b\" \"c\" \"d\"));;", [], "[a,b,c,d]");
 ("should print 'letter a'", "(= a \"letter a\");; (prn a);;", [], "letter a");
 ("using curly infix expressions", "(prn (string_of_int {3 + 5}));;", [], "8");
 ("handle printing negative return value","(prn (string_of_int {7 - 9}));;", [], "-2"); 
 ("converting int returned from function to string", "(= square (fn (x) (* x x)));;  (prn (string_of_int (square 5) ));;", [], "25");
 ("print function's return value, using infix", "(= square (fn (x) {x * x}));;  (prn (string_of_int (square 5) ));;", [], "25");
 ("printing return of assignment (int)", "(prn (string_of_int (= x 3)));;", [], "3");
 ("printing return of assignment (float)", "(prn (string_of_float {x = 3.5}));;", [], "3.5");
 ("use string_of_boolean to print", "(pr (string_of_boolean true));;(pr (string_of_boolean false));;", [], "truefalse");
 ("use string_of_boolean with prn", "(prn (string_of_boolean true));;(prn (string_of_boolean false));;", [], "true\nfalse");  (************************)
 ("print the type 'string'", "(prn (type {x = \"a string\"}));;", [], "string");
 ("print the type of return value of assignment", "(prn (type {x = 50}));;", [], "int");
 ("print type of an list", "(prn (type '() ));;", [], "list");
 ("print type of var after assingment", "(= a 2);; (prn (type a));;", [], "int");
 ("print type of float", "(prn (type 3.5));;", [], "float");
 ("print type of function", "(prn (type (fn (x y) (/(+ x y) 2)) ));;", [], "function");
 ("use head and tail, basic case", "(= foo '(1 0));; (if true (prn (string_of_int (head foo))) (prn (string_of_int (head (tail foo)))));;", [], "1");
 ("assing var to result of sum, then print", "(= foo (+ 1 2 3 4 5));; (prn (string_of_int foo));;", [], "15");
 ("print boolean", "(= foo true);; (prn (string_of_boolean foo));;", [], "true");
 ("print second element using head and tail","(= foo '(\"a\" \"b\" \"c\"));; (prn (string(head (tail foo))));;", [], "b");
 ("define fibonacci function", "(= fib (fn (x) (if (is x 0) 0 (if (is x 1) 1 {(fib {x - 1}) + (fib {x -2} )}))));; (prn (string_of_int (fib 5)));;", [], "5");
 ("print infix mixed operations", "(prn (string_of_int {5 + 3 + 6 * 7 - 4 / 2}));;", [], "48");
 ("print mixed infix and prefix", "(prn (string_of_int (+ {5 + 3 + 6 * 7 - 4 / 2} (/ 100 5 20) (* {1 - 3} 3))));;", [], "43");
 ("mixed operations", "(= foo '(\"a\" \"b\"));; (prn (++ (string_of_int {5 + 3 + 6 * 7 - 4 / 2}) (string (head foo)) (string_of_int (* {1 - 3} 3))));;", [], "48a-6");
 ("print result of infix sum", "(prn (string_of_int {1 + 2 + 3 + 4}));;", [], "10");
 ("print result of infix subtraction", "(prn (string_of_int {10 - 2 - 3}));;", [], "5");
 ("print result of infix multiplication", "(prn (string_of_int {1 * 2 * 3 * 4}));;", [], "24");
 ("print result of infix float summation", "(prn (string_of_float {.1 +. .2 +. .3 +. .4 }));;", [], "1");
 ("print float summation", "(prn (string_of_float {5.0 -. .2 -. .3 }));;", [], "4.5");
 ("print result of infix float multiplication", "(prn (string_of_float { 1. *. 2. *. 3. *. 4.}));;", [], "24");
 ("using if", "(if  true (prn \"a\") (prn \"b\"));;", [], "a");
 ("assing var to list and print", "(= a '(1 2 3 4));; (prn (string_of_boolean (is a a)));;", [], "true");
 ("check for empty list equality", "(= x '(1));; (prn (string_of_boolean (is (tail x) '())));;", [], "true");
 ("appending object to head of list", "(= x '( \"1\"));; (prn (string (head (cons (head x) '(\"a\" \"b\")))));;", [], "1");
 ("def roundabout concat function, use in roundabout way", "(= concat (fn (x y) (if (is x '()) y (if (is (concat (tail x) y) y) (cons (head x) y) (cons (head x) (concat (tail x) y))))));;  (prn (string (head (tail (tail (tail (tail(concat '(\"1\" \"2\" \"3\") '(\"1\" \"LAST\")))))))));;", [], "LAST") ;

 (***************************************STANDARD LIBRARY TESTS **********************************************************************************************)

 ("Testing stdlib function: identity", "(= x '(1 2 3 4 ));; (prn (string_of_boolean (is x (identity x))));;", [], "true") ;
 ("Testing stdlib function: length", "(= x '(1 2 3 4 ));; (prn (string_of_int (length x )));;", [], "4") ;
 ("Testing stdlib function: nth", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (nth 5 x)));;", [], "6") ;
 ("Testing stdlib function: first", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (first x)));;", [], "1") ;
 ("Testing stdlib function: second", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (second x)));;", [], "2") ;
 ("Testing stdlib function: third", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (third x)));;", [], "3") ;
 ("Testing stdlib function: fourth", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (fourth x)));;", [], "4") ;
 ("Testing stdlib function: fifth", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (fifth x)));;", [], "5") ;
 ("Testing stdlib function: sixth", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (sixth x)));;", [], "6") ;
 ("Testing stdlib function: seventh", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (seventh x)));;", [], "7") ;
 ("Testing stdlib function: eigth", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (eighth x)));;", [], "8") ;
 ("Testing stdlib function: ninth", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (ninth x)));;", [], "9") ;
 ("Testing stdlib function: tenth", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (tenth x)));;", [], "10") ;
 ("Testing stdlib function: map", "(= newprn (fn (x) (prn (string_of_int (int x)))));; (= x '(1 2 3 4 5 6 7 8 9 10));; (map newprn x);;", [], "1\n2\n3\n4\n5\n6\n7\n8\n9\n10") ;
 ("Testing stdlib function: fold_left", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (int (fold_left + 0 x))));;", [], "55") ;
 ("Testing stdlib function: fold_right", "(= x '(1 2 3 4 5 6 7 8 9 10));; (prn (string_of_int (int (fold_right + x 0 ))));;", [], "55") ;
 ("Testing stdlib function: filter", "(= fx (fn (x) (> x 3)));;  (= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string_of_int (int (head (filter fx x)))));;", [], "4") ;
 ("Testing stdlib function: partition", "(= less (fn (x) (< x 5)) );; (= x '(1 2 3 4 5 6 7 8 9 10));; (print_list format_int2d  (list (partition less x)));;", [], "[[1,2,3,4],[5,6,7,8,9,10]]") ;   
 ("Testing stdlib function: append", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (string (head (tail (tail (tail (tail(append '(\"1\" \"2\" \"3\") '(\"1\" \"LAST\")))))))));;", [], "LAST") ; 
 ("Testing stdlib function: take", "(= x '(1 2 3 4 5 6 7 8 9 10));; (print_list format_int (list (take 5 x)));; ", [], "[1,2,3,4,5]") ;  
 ("Testing stdlib function: drop", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (print_list format_int (list (drop 5 x)));;", [], "[6,7,8,9,10]") ;  
 ("Testing stdlib function: zipwith", "(print_list format_int (zipwith (fn (x y) (+ x y)) '(1 2 3 4) '(5 6 7 8)));;", [], "[6,8,10,12]") ; 
 ("Testing stdlib function: zipwith3", "(print_list format_int (zipwith3 (fn (x y z) (+ x y z)) '(1 2 3 4) '(5 6 7 8) '(10 11 12 13)));;", [], "[16,19,22,25]") ;  
 ("Testing stdlib function: reverse", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (print_list format_int (reverse x));;", [], "[10,9,8,7,6,5,4,3,2,1]") ;
 ("Testing stdlib function: member", "(= x '(1 2 3 4 5 6 7 8 9 10));; (prn (string_of_boolean (member 10 x)));; ", [], "true") ;
 ("Testing stdlib function: intersperse", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (print_list format_int (intersperse 0 x));;", [], "[1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10]") ;
 ("Testing stdlib function: stringify_list", "(= x '(1 2 3 4 5 6 7 8 9 10));;  (prn (stringify_list format_int x));;", [], "[1,2,3,4,5,6,7,8,9,10]") 

] ;;

let unsuccess = ref 0 ;;


List.iter (fun (desc, input, ast, expout) ->
  let stdlib = load_file "stdlib.ss" in 
  let lexbuf = Lexing.from_string (stdlib ^ input) in 
  try 
    let expression = Parser.program Scanner.token lexbuf in
    if (ast = expression || ast = []) then 
      let prog = Generator.generate_prog expression in  
      write prog; 
      let actout = String.concat "\n" (funct (Unix.open_process_in "node a.js")) in
      if  expout = actout then print_string "" else
       print_endline (String.concat "" ["\027[38;5;1m"; desc; ": "; input; "... UNSUCCESSFUL Compilation....\ninput: "; input; "\nexpected out: "; expout; "\nActual out: "; actout; "\027[0m"]);
    else (print_endline (String.concat "" ["\027[38;5;1m"; desc; ": "; input; "\027[0m"]) ; unsuccess := !unsuccess+1 ) ;
  with 
    | _ -> print_endline (String.concat "" ["**START REPORT**\n" ; "Parse Error:\ninput:";input ;"\n**END REPORT**"]) ; unsuccess := !unsuccess+1) tests ;;


if !unsuccess = 0 then print_endline "ALL SUCCESSFUL" else exit 1 ;;