move(state(J3, J5), state(3, J5), fill3) :- J3 < 3.
move(state(J3, J5), state(J3, 5), fill5) :- J5 < 5.
move(state(J3, J5), state(0, J5), empty3) :- J3 > 0.
move(state(J3, J5), state(J3, 0), empty5) :- J5 > 0.
move(state(J3, J5), state(NewJ3, NewJ5), pour3to5) :-
    J3 > 0,
    J5 < 5,
    Transfer is min(J3, 5 - J5),
    NewJ3 is J3 - Transfer,
    NewJ5 is J5 + Transfer.
move(state(J3, J5), state(NewJ3, NewJ5), pour5to3) :-
    J5 > 0,
    J3 < 3,
    Transfer is min(J5, 3 - J3),
    NewJ5 is J5 - Transfer,
    NewJ3 is J3 + Transfer.
solve(Path) :-
    between(1, 10, L),
    dfs(state(0,0), [], Path, L).
dfs(state(_, 4), Moves, Path, L) :-
    reverse([state(_, 4)|Moves], Path).
dfs(State, Moves, Path, L) :-
    L > 0,
    move(State, NextState, Action),
    \+ member(NextState, Moves),
    dfs(NextState, [State|Moves], Path, L - 1).
