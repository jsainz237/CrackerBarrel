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

% play game for all positions starting at position 0 to the Max position the user passed
go(Max):- 
	Max < 15,
	numlist(0, Max, Iterations),
	maplist(playGame(), Iterations),
	!.

% run makeMoves and printBoard for board for all starting positions specified
playGame(N):- 
    format("=== ~w === ~n~n", [N]),
    numlist(0, 14, InitialList),
    select(N, InitialList, Filled),
    makeMoves([N], Filled, [], Board),
    printBoard(Board, [N]).

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
	maplist(\X^I^(member(X, Free) -> I = '.'; I = 'x'), Board,
		[Hole1,Hole2,Hole3,Hole4,Hole5,Hole6,Hole7,Hole8,Hole9,Hole10,Hole11,Hole12,Hole13,Hole14,Hole15]),
	format('    ~w        ~n', [Hole1]),
	format('   ~w ~w      ~n', [Hole2,Hole3]),
	format('  ~w ~w ~w    ~n', [Hole4,Hole5,Hole6]),
	format(' ~w ~w ~w ~w  ~n', [Hole7,Hole8,Hole9,Hole10]),
	format('~w ~w ~w ~w ~w~n~n', [Hole11,Hole12,Hole13,Hole14,Hole15]).
 
% print method that 
printBoard([move(Start, Middle, End) | Tail], Free) :-
	numlist(0,14, Board),
	maplist(\X^I^(member(X, Free) -> I = '.'; I = 'x'), Board,
		[Hole1,Hole2,Hole3,Hole4,Hole5,Hole6,Hole7,Hole8,Hole9,Hole10,Hole11,Hole12,Hole13,Hole14,Hole15]),
	format('    ~w        ~n', [Hole1]),
	format('   ~w ~w      ~n', [Hole2,Hole3]),
	format('  ~w ~w ~w    ~n', [Hole4,Hole5,Hole6]),
	format(' ~w ~w ~w ~w  ~n', [Hole7,Hole8,Hole9,Hole10]),
	format('~w ~w ~w ~w ~w~n~n', [Hole11,Hole12,Hole13,Hole14,Hole15]),
	select(End, Free, Free1),
	printBoard(Tail,  [Start, Middle | Free1]).