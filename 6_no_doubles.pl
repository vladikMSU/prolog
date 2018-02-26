% no_doubles(L1, L2): L2 is L1 with repetitions deleted (if the element is met several times all its entrances are removed)
% prototypes (i,i), (i,o)

delete_all(_, [], []) :- !.
delete_all(X, [X|R1], L2) :- delete_all(X, R1, L2), !, not(member(X,L2)).
delete_all(X, [Y|R1], [Y|R2]) :- delete_all(X, R1, R2).

no_doubles([], []).
no_doubles([X|R1], L2) :- member(X, R1), delete_all(X, [X|R1], Tmp), no_doubles(Tmp, L2), !.
no_doubles([X|R1], [X|R2]) :- not(member(X, R1)), no_doubles(R1, R2).

/*
% no_doubles(L1, L2): L2 is L1 with repetitions deleted (if the element is met several times only one its entrance is left)
% prototypes (i,i), (i,o) ND

delete_one(_, [], []) :- !.
delete_one(X, L1, L2) :- delete_one1(X,L1, L2).

delete_one1(X, [X|R], R).
delete_one1(X, [Y|R1], [Y|R2]) :- delete_one1(X, R1, R2).

remove_conseq([], []).
remove_conseq([X,X|R], [X|Res]).

no_doubles([], []).
no_doubles([X,X|R1], Res) :- no_doubles([X|R1], Res).
no_doubles([X|R1], Res) :- member(X, R1), delete_one(X, [X|R1], L2), no_doubles(L2, Res).
no_doubles([X|R1], [X|R2]) :- not(member(X, R1)), no_doubles(R1, R2).
*/
% TODO fix A LOT OF multiple similar answers