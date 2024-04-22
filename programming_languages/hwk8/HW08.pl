:- use_module(library(clpfd)).

%Both Heights and Colors are represented as lists between 1 and 8, the Colors list is then converted to Letters using the print_rook logic at the bottom.
solve_unique_rooks(Colors, Heights) :-
    Size = 8,
    create_board(Colors, Size),
    create_board(Heights, Size),
    apply_constraints(Colors), % Unique Colors column-wise and row-wise
    apply_constraints(Heights), % Unique Heights column-wise and row-wise
    unique_combinations(Colors, Heights, Combinations),
    all_distinct(Combinations), % Unique Color/Heights combinations for the entire board
    maplist(label, Colors),
    maplist(label, Heights).

create_board(Board, Size) :-
    length(Board, Size),
    maplist(same_length_fill(Size), Board).

%This forces instantiation of the values in both colors and heights
same_length_fill(Size, Row) :-
    length(Row, Size),
    Row ins 1..Size.

%Enforces uniqueness both column-wise and row-wise with regard to Heights and Colors individually.
apply_constraints(Board) :-
    maplist(all_distinct, Board),
    transpose(Board, Transposed),
    maplist(all_distinct, Transposed).

%Generates 64 unique encoded pairs from the Colors and Heights boards that are then enforced through all_distinct.
unique_combinations(Colors, Heights, Combinations) :-
    append(Colors, FlatColors),
    append(Heights, FlatHeights),
    maplist(encode_pair, FlatColors, FlatHeights, Combinations).

%using this encoding step forces each pair to be distinct giving us A1 -> A8, B1 -> B8 etc..
encode_pair(Color, Height, Encoded) :-
    Encoded #= Color * 10 + Height.


%the logic below simply prints the results from above.

print_rooks(Colors, Heights) :-
    maplist(print_row, Colors, Heights).

print_row(ColorRow, HeightRow) :-
    maplist(print_rook, ColorRow, HeightRow),
    nl.

print_rook(Color, Height) :-
    color(Color, Character),
    format('(~w,~w) ', [Character, Height]).

color(1, 'A'). color(2, 'B'). color(3, 'C'). color(4,'D'). color(5,'E'). color(6,'F'). color(7,'G'). color(8,'H').


% TO TEST:

% ?- solve_unique_rooks(Colors, Heights), print_rooks(Colors, Heights).
                                 


