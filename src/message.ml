(* Adapted from
	Andrej Bauer's Poly - message.ml,
	with minor changes by Michelle Zheng  *)

(** Error messages for Lexing *)

open Lexing

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

let string_of_position {pos_fname=fname; pos_lnum=lnum; pos_bol=bol; pos_cnum=cn} =
  let col_offset = cn - bol in
    if fname = "" then
      "Character " ^ string_of_int col_offset
    else
      "File \"" ^ fname ^ "\", line " ^ string_of_int lnum ^ ", character " ^ string_of_int col_offset

let string_of msg pos  = string_of_position pos ^ ":\n" ^ msg

let syntax_error {lex_curr_p=pos} = string_of "Syntax error" pos

let report = print_endline
