:- use_module(lambda).

% moves that are allowed to be made over a certain peg (i.e. From, Over, To)
move(Frm, 1, To):- member([Frm, To], [[0, 3], [3, 0]]).
move(Frm, 2, To):- member([Frm, To], [[0, 5], [5, 0]]).
move(Frm, 3, To):- member([Frm, To], [[1, 6], [6, 1]]).
move(Frm, 4, To):- member([Frm, To], [[1, 8], [8, 1]]).
move(Frm, 4, To):- member([Frm, To], [[2, 7], [7, 2]]).
move(Frm, 5, To):- member([Frm, To], [[2, 9], [9, 2]]).
move(Frm, 6, To):- member([Frm, To], [[3, 10], [10, 3]]).
move(Frm, 7, To):- member([Frm, To], [[3, 12], [12, 3]]).
move(Frm, 7, To):- member([Frm, To], [[4, 11], [11, 4]]).
move(Frm, 8, To):- member([Frm, To], [[4, 13], [13, 4]]).
move(Frm, 8, To):- member([Frm, To], [[5, 12], [12, 5]]).
move(Frm, 9, To):- member([Frm, To], [[5, 14], [14, 5]]).
move(Frm, 4, To):- member([Frm, To], [[3, 5], [5, 3]]).
move(Frm, 7, To):- member([Frm, To], [[6, 8], [8, 6]]).
move(Frm, 8, To):- member([Frm, To], [[7, 9], [9, 7]]).
move(Frm, 11, To):- member([Frm, To], [[10, 12], [12, 10]]).
move(Frm, 12, To):- member([Frm, To], [[11, 13], [13, 11]]).
move(Frm, 13, To):- member([Frm, To], [[12, 14], [14, 12]]).

% pass 0 and 5 when user runs go() method
go():-go(0, 5).

% run makeMoves and printBoard for board position 0 through 5
go(N, M):- 
    N < M,
    format("=== ~w === ~n~n", [N]),
    numlist(0, 14, InitialList),
    select(N, InitialList, Filled),
    makeMoves([N], Filled, [], Board),
    printBoard(Board, [N]),
    K is N+1,
    go(K, M).

% reset board when all moves have been make
makeMoves(_, [_], Moves, Board):-
	reverse(Moves, Board).

% recursively makes moves depending on which are available to make
makeMoves(Open, Filled, Moves, Board):-
	select(Start, Filled, Filled_1),
	select(Over, Filled_1, Filled_2),
	select(End, Open, Open_1),
	move(Start, Over, End),
	makeMoves([Start, Over | Open_1], [End | Filled_2], [move(Start, Over, End) | Moves], Board).

% print method for when there are no more moves left.
printBoard([], Free) :-
	numlist(0,14, Board),
	maplist(\X^I^(member(X, Free) -> I = '.'; I = 'x'), Board, [I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n~n', [I11,I12,I13,I14,I15]).
 
% print method that 
printBoard([move(Start, Middle, End) | Tail], Free) :-
	numlist(0,14, Board),
	maplist(\X^I^(member(X, Free) -> I = '.'; I = 'x'), Board, [I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n~n', [I11,I12,I13,I14,I15]),
	select(End, Free, Free1),
	printBoard(Tail,  [Start, Middle | Free1]).