% delete_first(X, L1, L2): L2 is L1 without first entrance of X
% prototypes - (i,i,i), (i,i,o), (i,o,i), (o,i,i), 

delete_first(X, [X|R1], R1) :- !.
delete_first(X, [Y|R1], [Y|R2]) :- delete_first(Y, R1, R2).

% TODO not including case when L1 is empty list