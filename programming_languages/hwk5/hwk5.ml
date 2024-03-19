(*********** HW05 ***********)
(*
Student names: 
Student IDs:
Sources: 


For each exercise below, create an OCaml function that will perform the specified
task (given the constraints below). The function definitions have been given
to you. Run each function against at least 3 of your own test cases to verify
correctness. Include in each function's comment section the test cases that you
checked and their results. 

This homework assignment is intended to give you practice with OCaml to the extent
that we have covered in class through 2/28/24. Please do not use more advanced
OCaml features that have not been covered yet. The intent of these exercises are
to give you practice with higher-order functions as well as additional general
experience with OCaml. At this point, you should be writing in a style indicative
of functional programming (as opposed to an imperative style). To receive full
credit for these excercises, you must follow these rules:
1.) Avoid using if statements, for loops, while loops.
2.) For each function, use one or more of the following in a meaningful way:
    map, foldr, foldl
3.) Do not use recursion or helper functions 
4.) Show the test cases that you used in comments

Please submit one file to Gradescope named HW05.ml. Please
make a copy of this assignment file to use as your starting point. Do not
change the function names. Please uncomment out all of your functions before
submitting. As part of the grading process, we will be adding function calls to
the end of your submitted file and running it. If your functions are commented
out or you have changed the function names or signatures, your functions will
not receive credit. 

A few operators that might be helpful in this exercise that you may not have 
used is previous assignments:
&& - logical and
|| - logical or
<> - not equal (equality check)
@ - list append

If you think that you need to use functionality that we haven't covered in class,
please post a question to Piazza.
*) 

(* The following line is needed for grading purposes. Do not remove it. *)
exception NotImplemented of string;;

(* Exercise 1 ------------------------------------------------ *)
(*
	let squarelist -- 

	Write a function of type int list -> int list that takes a list 
        of integers and returns the list of the squares of those integers. For
	example, if you evaluate squarelist [l,2,3,4] you should get [l,4,9,16].
*) 

let squarelist = List.map (fun x -> x*x);;


assert(squarelist [1;2] = [1;4]);;
assert(squarelist [] = []);;
assert(squarelist [0;-1;3] = [0;1;9]);;

(* Exercise 2 ------------------------------------------------ *)
(*
	let multpairs -- 

	Write a function of type (int * int) list -> int list that takes a pair
	of integers and returns a list of the products of each pair. For example,
	if you evaluate multpairs [(l,2),(3,4)] you should get [2,12].
*)


let multpairs = List.map (fun (a,b) -> a*b);;


assert(multpairs [(1,2)] = [2]);;
assert(multpairs [(0,5); (3,2)] = [0;6]);;
assert(multpairs [] = []);;

(* Exercise 3 ------------------------------------------------ *)
(*
	let inclist -- 

	Write a function of type int list -> int -> int list that takes a list
	of integers and an integer increment, and returns the same list of
	integers but with the integer increment added to each one. For example,
	if you evaluate inclist [l,2,3,4] 10 you should get [11,12,13,14]. Note
	that the function is curried.
*)


let inclist lst inc = List.map (fun x -> x + inc) lst;;


assert(inclist [2;3;4] 1 = [3;4;5]);;
assert(inclist [6;2] (-4) = [2;-2]);;
assert(inclist [] 3 = []);;

(* Exercise 4 ------------------------------------------------ *)
(*
   let bor --
   
   Write a function bor of type bool list -> bool that takes a list of boolean
   values and returns the logical OR of all of them. If the list is empty, your
   function should return false.
*)


let bor lst = List.fold_right (fun x acc -> x || acc) lst false;;


assert(bor [] = false);;
assert(bor [false;false;false] = false);;
assert(bor [false; false; true; true; false] = true);;

(* Exercise 5 ------------------------------------------------ *)
(*
   let lconcat --
   
   Write a function lconcat of type 'a list list -> 'a list that takes a list
   of lists as input and returns the list formed by appending the input lists
   together in order. For example, if the input is [[1,2],[3,4,5,6],[7]], your
   function should return [1,2,3,4,5,6,7].
*)


let lconcat lst = List.fold_left (fun acc x -> acc @ x) [] lst;;



assert(lconcat [[1];[2]] = [1;2]);;
assert(lconcat [['a'];['b';'c']] = ['a';'b';'c']);;
assert(lconcat [] = []);;


(* Exercise 6 ------------------------------------------------ *)
(*
   let append --

   Write a function append of type 'a list -> 'a list -> 'a list that lakes two
   lists and returns the result of appending the second one onto the end of the
   first. For example, append [l,2,3] [4,5,6] should evaluate to [l,2,3,4,5,6].
   Do not use predefined appending utilities, like the @ operator.
*)


let append lst1 lst2 = List.fold_right (fun x acc -> x::acc) lst1 lst2;;


assert(append [1] [2] = [1;2]);;
assert(append ['a';'b';'c';] [] = ['a';'b';'c']);;
assert(append [] [] = []);; 

(* Exercise 7 ------------------------------------------------ *)
(*
   let convert --

   Write a function convert of type ('a * 'b) list -> 'a list * 'b list, 
   that converts a list of pairs into a pair of lists, preserving the order 
   of the elements. For example, convert [(1,2),(3,4),(5,6)] should evaluate
   to ([l,3,5],[2,4,6]).
  *)


let convert lst = List.fold_right (fun (a,b) (acc_a, acc_b) -> (a::acc_a, b::acc_b)) lst ([],[]);;
  


assert(convert [] = ([], []));;
assert(convert [(1,2)] = ([1],[2]));;
assert(convert [('a',1);('b',2);('c',3)] = (['a';'b';'c'],[1;2;3]));; 

(* Exercise 8 ------------------------------------------------ *)
(*
   let mymap --

   Define a function mymap with the same type and behavior as map, but without
   using map.
*)


let rec mymap f = function 
  | [] -> []
  | x :: xs -> ((f x) :: mymap f xs);;


assert(mymap (fun x -> x+1) [1;2;3] = [2;3;4]);;
assert(mymap (fun x -> true) ['a';'b';'c'] = [true;true;true]);;
assert(mymap (string_of_int) [1;2;3] = ["1";"2";"3"]);;

(* Exercise 9 ------------------------------------------------ *)
(*
   let tparity --
   
   Examine the following function that is written in Python. It is written 
   in a very imperative style. Determine what this function does, then write
   an equivalent function in OCaml. Write the OCaml function using a 
   functional style. 
   Avoid using: if statements, for loops, while loops, or calling tparity
   You should use one of: map, foldr, foldl 

	def tparity(b_list):
		parity = True
		for each in b_list:
			if each:
				parity = not parity
		return parity
*)


let tparity lst = List.fold_right (fun x acc -> if x then not acc else acc) lst true;;


assert(tparity [true] = false);;
assert(tparity [] = true);;
assert(tparity [true;false;false;true;false;true;true] = true);;
