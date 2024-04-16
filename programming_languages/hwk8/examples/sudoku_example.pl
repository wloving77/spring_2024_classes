/*

%
%  A straightforward sudoku solver for a 4-by-4 puzzle
%  Example from: https://github.com/melissamangos/sudoku/blob/master/sudoku.pl
%

% Main predicate, calles other predicates
sudoku(R1C1, R1C2, R1C3, R1C4, R2C1, R2C2, R2C3, R2C4, R3C1, R3C2, R3C3, R3C4, R4C1, R4C2, R4C3, R4C4) :- solved(R1C1, R1C2, R1C3, R1C4, R2C1, R2C2, R2C3, R2C4, R3C1, R3C2, R3C3, R3C4, R4C1, R4C2, R4C3, R4C4),
	printsudoku(R1C1, R1C2, R1C3, R1C4),
	printsudoku(R2C1, R2C2, R2C3, R2C4),
	printsudoku(R3C1, R3C2, R3C3, R3C4),
	printsudoku(R4C1, R4C2, R4C3, R4C4).

% Helps to print the values
printsudoku(A, B, C, D) :- write(' '), write(A), write('  '), write(B), write('  '), write(C), write('  '), write(D), nl.

% Solves the puzzle by making sure the values are all different
solved(R1C1, R1C2, R1C3, R1C4, R2C1, R2C2, R2C3, R2C4, R3C1, R3C2, R3C3, R3C4, R4C1, R4C2, R4C3, R4C4) :-
	different(R1C1, R1C2, R1C3, R1C4), % First row
	different(R2C1, R2C2, R2C3, R2C4), % Second row
	different(R3C1, R3C2, R3C3, R3C4), % Third row
	different(R4C1, R4C2, R4C3, R4C4), % Fourth row
	different(R1C1, R2C1, R3C1, R4C1), % First column
	different(R1C2, R2C2, R3C2, R4C2), % Second column
	different(R1C3, R2C3, R3C3, R4C3), % Third column
	different(R1C4, R2C4, R3C4, R4C4), % Fourth column
	different(R1C1, R1C2, R2C1, R2C2), % Top Left block
	different(R1C3, R1C4, R2C3, R2C4), % Top Right block
	different(R3C1, R3C2, R4C1, R4C2), % Bottom Left block
	different(R3C3, R3C4, R4C3, R4C4). % Bottom Right block

% Determine if each square in either a row, column, or block are
% different
different(A, B, C, D) :- num(A), num(B), num(C), num(D), A\=B, A\=C, A\=D, B\=C, B\=D, C\=D.

% Initialize numbers
num(1). num(2). num(3). num(4).
*/

/*
% Sample query
sudoku(
	4, _, _, _,
	_, 3, _, _,
	_, _, 1, _,
	_, 1, _, 2).
*/


%
%  An efficient 9-by-9 Sudoku solver using clpfd
%  https://www.swi-prolog.org/pldoc/man?section=clpfd-sudoku
%
/*
:- use_module(library(clpfd)).

sudoku(Rows) :-
        length(Rows, 9), maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins 1..9,
        maplist(all_distinct, Rows),
        transpose(Rows, Columns),
        maplist(all_distinct, Columns),
        Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
        blocks(As, Bs, Cs),
        blocks(Ds, Es, Fs),
        blocks(Gs, Hs, Is).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocks(Ns1, Ns2, Ns3).

problem(1, [[_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,3,_,8,5],
            [_,_,1,_,2,_,_,_,_],
            [_,_,_,5,_,7,_,_,_],
            [_,_,4,_,_,_,1,_,_],
            [_,9,_,_,_,_,_,_,_],
            [5,_,_,_,_,_,_,7,3],
            [_,_,2,_,1,_,_,_,_],
            [_,_,_,_,4,_,_,_,9]]).
*/
% Samle query -
% problem(1, Rows), sudoku(Rows), maplist(portray_clause, Rows).
%