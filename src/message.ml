(** Error messages for Lexing & Parsing *)

open Printf
open Lexing
open Parsing

exception LexingErr of string

let print_position lexbuf msg =
  let start = lexeme_start_p lexbuf in
   let finish = lexeme_end_p lexbuf in 
    (fprintf stderr "Line %d: char %d..%d: %s: \"%s\" \n" 
	start.pos_lnum
	(start.pos_cnum - start.pos_bol) 
	(finish.pos_cnum - finish.pos_bol) 
	msg
	(Lexing.lexeme lexbuf)) 

(** [lexer_from_channel fname ch] returns a lexer stream which takes
    input from channel [ch]. The input filename (for reporting errors) is
    set to [fname].
*)
let lexer_from_channel fname ch =
  let lex = Lexing.from_channel ch in
  let pos = lex.lex_curr_p in
    lex.lex_curr_p <- { pos with pos_fname = fname; pos_lnum = 1; } ;
    lex

(** [lexer_from_string str] returns a lexer stream which takes input
    from a string [str]. The input filename (for reporting errors) is set to
    [""]. *)
let lexer_from_string str =
  let lex = Lexing.from_string str in
  let pos = lex.lex_curr_p in
    lex.lex_curr_p <- { pos with pos_fname = ""; pos_lnum = 1; } ;
    lex

