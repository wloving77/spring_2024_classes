/* *********** HW09 ***********
Student name: i.e. Tony Bennett  - put names here
Student ID: i.e. mst3k  - put IDs here
Sources: - any websites, books, etc. other than course slides

For each exercise below, create a Prolog program that will perform the
specified task (given the constraints below). For each, you may end up
writing just a single fact, a single rule, or a combination of facts
and rules. 

For each program, create your own tests. After you have passed all of
your tests, comment them out and leave them with their related 
program. Once you have all of the programs completed, you may find it
helpful to run the test(all) rule include at the end of this file. It
should help to insure that all programs are included and runnable.

This homework assignment is intended to give you practice with the very
basics of Prolog. The parts of Prolog that can be used for HW07 are
given below. If you think that you need to use additional functionality
that is not included, please post a question to Piazza. To receive
credit for these exercises, you must follow these rules:
1.) Only use the parts of the Prolog language that are included in the
"Acceptable" list.
2.) Make sure that all predicates are uncommented and ready to be
queried. This is needed for feedback from the autochecker.

Please submit one file named HW07.pl.
Please make a copy of this assignment file to use as your starting
point. Do not change names of predicates.

Parts of Prolog that are ACCEPTABLE for use in HW07:
integer constants, real constants, atoms, variables, consult, true,
false, append, not, +, -, *, /, [], (), =, _,  ;, ., ,, ?-, |, :-.

Parts of Prolog that are NOT acceptable for use in HW07 include:
member, select, nth0, length, reverse, sort, assert, retract, as 
well as anything that has not been covered in class as of 4/3/24.
I realize this is restrictive, but it helps to make sure that you 
get practice using the parts of Prolog that are most important right
now.
*/


/* Exercise 1 ------------------------------------------------

third --
Define a predicate, third, so that third(X,Y) says that Y is the third
element of the list X. The predicate should fail if X has fewer than
three elements. (Hint: this can be expressed as a fact.)
*/

third([_,_,Y|_], Y).



/* Exercise 2 ------------------------------------------------

firstPair --
Define a predicate, firstPair, so firstPair(X) succeeds if and only if
X is a list of at least two elements, with the first element the same
as the second element. (Hint: this can be expressed as a fact.)
*/

firstPair([X,X|_]).


/* Exercise 3 ------------------------------------------------

del3 --
Define a predicate, del3, so that del3(X,Y) says that the
list Y is the same as the list X but with the third element
deleted. The predicate should fail if X has fewer than three
elements. (Hint: this can be expressed as a fact.)
*/

del3([X,Y,_|Tail], [X,Y|Tail]).



/* Exercise 4 ------------------------------------------------

dupList --
Define a predicate, dupList, dupList(X,Y) says that X is a list
and Y is the same list, but with each element of X repeated twice
in a row. For example if X is [1,3,2], Y should be [1,1,3,3,2,2].
If X is [], Y should be []. Check that your predicate works in
both directions, that is, check that it works on queries like
dupList(X, [l,1,3,3,2,2]) as well as on queries like
dupList([1,3,2],Y).
*/

dupList([], []).
dupList([X|Xs], [X,X|Ys]) :- dupList(Xs,Ys).


/* Exercise 5 ------------------------------------------------

isDuped --
Define a predicate, isDuped, so that isDuped(Y) succeeds if and
only if Y is a list of the form of the lists Y in Exercise 4.
That is, the predicate should succeed if and only if the first
and second elements are equal, and the third and fourth elements
are equal, and so on to the end of the list. It should fail for
all odd-length lists.
*/

isDuped([]).
isDuped([X,X|Tail]) :- isDuped(Tail).



/* Exercise 6 ------------------------------------------------

oddSize --
Define a predicate, oddSize, so that oddSize(X) says that X is
a list whose length is an odd number. (Hint: You do not need
to compute the actual length, or do any integer arithmetic.)
*/

oddSize([_]).
oddSize([_,_|Tail]) :- oddSize(Tail).

/* Exercise 7 ------------------------------------------------

evenSize --
Define a predicate, evenSize, so that evenSize(X) says that X
is a list whose length is an even number. (Hint: You do not
need to compute the actual length, or do any integer arithmetic.)
*/

evenSize([_,_]).
evenSize([_,_|Tail]) :- evenSize(Tail).


/* Exercise 8 ------------------------------------------------

prefix --
Define a predicate, prefix, so that prefix(X,Y) says that X is
a list that is a prefix of Y. That is, each element of X is
equal to (unifies with) the corresponding element of Y, but Y
may contain additional elements after that. Check that your
predicate works when X is uninstantiated: given a query like
prefix(X,[l,2,3]), it should find all the prefixes of the
list [1,2,3].
*/


prefix([],_).
prefix([X|Xs], [X|Ys]) :- prefix(Xs,Ys).


/* --- Some testing that may be helpful to you ---------------- 

test(all):-
    
third([4,5,6,7,8,9],6), write('--- 11 ---'),
not(third([4,5,6,7,8,9],[6])), write('--- 12 ---'),
not(third([4,5,1,9],5)), write('--- 13 ---'),
    
firstPair([9,9,3,4,6,2]), write('--- 21 ---'),
not(firstPair([])), write('--- 22 ---'),
not(firstPair([9,3,4,6,2])), write('--- 23 ---'),

del3([8,7,5,4],[8,7,4]), write('---  31 ---'),

dupList([],[]), write('--- 41 ---'),
dupList([6,8,3],[6,6,8,8,3,3]), write('--- 42 ---'),

isDuped([7,7,5,5,8,8,2,2]), write('--- 51 ---'),
    
oddSize([1]), write('--- 61 ---'),

evenSize([]), write('--- 71 ---'),
evenSize([9,7,5,4,1,2,3,7]), write('--- 72 ---'),

prefix([5,2,1],[5,2,1]), write('--- 81 ---'),
prefix([5,2,1],[5,2,1,1,2,3,4]), write('--- DONE ---'),!.


*/


