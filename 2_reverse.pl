% reverse(L1, L2): L2 is a reversed L1
% prototypes (i,i), (i,o), (o,i).

reverse(L1, L2) :- reverse(L1, [], L2).

reverse([], Res, Res) :- !.
reverse([X|R1], Acc, L3) :- reverse(R1, [X|Acc], L3).