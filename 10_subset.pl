% subset(M1, M2): M1 is a subset of set M2
% prototypes - (i,i), (o,i) ND

% modified
delete_one(X, [X|R], R).
delete_one(X, [Y|R1], [Y|R2]) :- delete_one(X, R1, R2).


subset([], _).
subset([X|R], M2) :- member(X, M2), delete_one(X, M2, M3), subset(R, M3).