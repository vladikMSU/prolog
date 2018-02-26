% delete_one(X, L1, L2): L2 is L1 without any entrance of X
% prototypes (i,i,i), (i,i,o) ND, (i,o,i) ND, (o,i,i), (o,i,o) ND

delete_one(_, [], []) :- !.
delete_one(X, L1, L2) :- delete_one1(X,L1, L2).

delete_one1(X, [X|R], R).
delete_one1(X, [Y|R1], [Y|R2]) :- delete_one1(X, R1, R2).

% TODO fix similar andswers when consequtive Xs