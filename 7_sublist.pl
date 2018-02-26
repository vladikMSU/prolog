% sublist(L1, L2): L1 is a sublist of L2 (any nonempy sequence of L2 elemnts in initial order)
% prototypes (i,i), (o,i) ND

sublist([], []).
sublist([X|R1], [X|R2]) :- sublist(R1, R2).
sublist(L1, [_|R2]) :- sublist(L1, R2).

% TODO this implementation counts empty list as a sublist, maybe should be changed