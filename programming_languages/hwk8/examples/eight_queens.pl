
nocheck(_, []).
nocheck(X/Y, [X1/Y1 | Rest]) :-
    X =\= X1,
    Y =\= Y1,
    abs(Y1-Y) =\= abs(X1-X),
    nocheck(X/Y, Rest).

legal([]).
legal([X/Y | Rest]) :-
    legal(Rest),
    member(X,[1,2,3,4,5,6,7,8]),
    member(Y,[1,2,3,4,5,6,7,8]),
    nocheck(X/Y, Rest).

eightqueens(X) :-
    X = [_/_,_/_,_/_,_/_,_/_,_/_,_/_,_/_],
    legal(X).


/*
nocheck(_, []).
nocheck(X/Y, [X1/Y1 | Rest]) :-
    %X =\= X1,
    Y =\= Y1,
    abs(Y1-Y) =\= abs(X1-X),
    nocheck(X/Y, Rest).

legal([]).
legal([X/Y | Rest]) :-
    legal(Rest),
    %member(X,[1,2,3,4,5,6,7,8]),
    member(Y,[1,2,3,4,5,6,7,8]),
    nocheck(X/Y, Rest).

eightqueens(X) :-
    X = [1/_,2/_,3/_,4/_,5/_,6/_,7/_,8/_],
    legal(X).
*/


/*
:- use_module(library(clpfd)).

n_queens(N, Qs) :-
	length(Qs, N),
	Qs ins 1..N,
    safe_queens(Qs).

safe_queens([]).
safe_queens([Q|Qs]) :-
	safe_queens(Qs, Q, 1),
	safe_queens(Qs).

safe_queens([], _, _).
safe_queens([Q|Qs], Q0, D0) :-
	Q0 #\=  Q,
	abs(Q0 - Q) #\= D0,
	D1 #=  D0 + 1,
	safe_queens(Qs, Q0, D1).
*/

/* example runs
?- n_queens(8, Qs), labeling([ff], Qs).
?- n_queens(24, Qs), labeling([ff], Qs).
?- n_queens(100, Qs), labeling([ff], Qs).
*/


