% number(X, N, L): X is Nth element of L
% prototypes - (i,i,i), (i,o,i), (o,i,i), (o,o,i) ND

number(X, 1, [X|_]).
number(X, N, [_|R]) :- number(X, N1, R), N is N1+1.

% TODO fix always false path