(* 
The purpose of this homework is to get practice with basic OCaml, but especially 
pattern matching and lists. Some functions will need to be recursive. Please use
pattern matching where possible. As this assignment was produced with our course
content in mind, please limit your use of OCaml functionality to what we have 
been covering in class.

Given below ar 2 versions of a function that you may refer to. The first version 
uses the 'function' syntax, and the second uses the 'with' syntax. For this 
assignment, try to use the 'function' syntax (the first example). If needed, you 
may use the 'with' syntax style. 

This function, is_first, takes an element and a list and determines if the element
is the same as the first member of the list. These examples are here to help you 
with syntax and style. 


let is_first = function
| (_, []) -> false
| (a, x::_) -> a = x;;

let is_first (a,lst)  = 
  match lst with
  | [] -> false
  | x::_ -> a = x;;

is_first(1,[1;2;3]);;
is_first(1,[3;2;1]);;

*)

(*
* Return the list of all elements of list that are < e.
*  
* val less : 'a * 'a list -> 'a list 
*)

let rec less = function
  | (_, []) -> []
  | (e, x::xs) -> if x < e then [x] @ less(e, xs) else less(e, xs);;

(*
* Write a tail-recursive version of `less`.
*  
* val less_tail : 'a * 'a list -> 'a list 
*)


let rec less_tail_helper(acc, e, lst) =
  match lst with 
  | [] -> acc
  | x::xs -> if x < e then less_tail_helper(acc @ [x], e, xs) else less_tail_helper(acc, e, xs);;


let rec less_tail(e, lst) = less_tail_helper([], e, lst);; 

(*
* Returns true if and only if list `list` contains adjacent equal elements.
*  
* val repeats : 'a list -> bool 
*)


let rec repeats = function 
  | [] -> false 
  | (a::[]) -> false
  | (a::b::cs) -> (a=b) || repeats(b::cs);;


(*
* Returns the value of polynomial `polynomial` at x.
* 
* We represent a polynomial as a list of float coefficients,
* with the constant coefficient first.
* 
* For example: 3x^2 + 5x + 1 would be represented as the list [1.0; 5.0; 3.0],
* and `eval 2.0 [1.0; 5.0; 3.0]` should evaluate to 23.0. 
* 
* For missing terms, 0.0 will be used. 
* i.e. x^3 - 2x is represented as the list [0.0; -2.0; 0.0; 1.0]
* val eval : float * float list -> float 
*)


let rec eval_helper = function
  | (x,p,[]) -> 0.0
  | (x,p,c::cs) -> ((x ** p) *. c) +. eval_helper(x,p+.1.,cs);;

let rec eval(x,coefficients) = eval_helper(x,0.0,coefficients);;


(*
* Returns true if e is a member of list list.
*
* val is_member : 'a * 'a list -> bool
*)

let rec is_member = function 
  | (e, []) -> false
  | (e, x::xs) -> e=x || is_member(e,xs);;


(* --- The following questions all build on each other --- *)

(*
 * Removes all the elements after the first occurrence of `e`
 * if it is in the list `list`, otherwise returns the empty list. 
 *
 * val remove_after_e : 'a * 'a list -> 'a list 
 *)
 
 
let rec remove_after_e = function
  | (_, []) -> []
  | (e, x::xs) -> if x=e then [x] else [x] @ remove_after_e(e, xs);;
 

(*
 * Removes the first occurrence of `e` from the list `list`
 * if `a` is in the list, otherwise returns the unmodified list.
 *  
 * val remove_first : 'a * 'a list -> 'a list 
 *)

 
let rec remove_first = function 
  | (_, []) -> []
  | (e, x::xs) -> if x=e then xs else [x] @ remove_first(e, xs);;


(*
 * Removes all the occurrences of e from the list list
 * if e is in the list, otherwise returns the unmodified list.
 *  
 * val remove_all : 'a * 'a list -> 'a list 
 *)

let rec remove_all = function
  | (_, []) -> []
  | (e, x::xs) -> if x=e then remove_all(e, xs) else [x] @ remove_all(e,xs);;

(*
 * Removes all the elements of list `list` where `(test_fn element)`
 * returns false, otherwise returns the unmodified list.
 *
 * *** Don't use List.filter
 *
 * val remove_if_not : ('a -> bool) * 'a list -> 'a list 
 *)
 
 
let rec remove_if_not = function
  | (_, []) -> []
  | (fn, x::xs) -> if fn(x) then [x] @ remove_if_not(fn,xs) else remove_if_not(fn,xs);; 
 
