% delete_all(X, L1, L2): L2 is L1 without all entrances of X
% prototypes - (i,i,i), (i,i,o), (o,i,i)

delete_all(_, [], []) :- !.
delete_all(X, [X|R1], L2) :- delete_all(X, R1, L2), !, not(member(X,L2)).
delete_all(X, [Y|R1], [Y|R2]) :- delete_all(X, R1, R2).

% TODO change to also have prototype (o,i,o) ND