% sort(L1, L2): L2 is a list of sorted by not descending elements from L1
% prototypes - (i,i), (i,o)

insert(X, [Y|R1], [Y|R2]) :- X > Y, insert(X, R1, R2).
insert(X, [Y|R], [X, Y | R]) :- X =< Y.
insert(X, [], [X]).


mysort(L1, Res) :- mysort(L1, [], Res).

mysort([], Res, Res).
mysort([X|Rem], Acc, Res) :- insert(X, Acc, NewAcc), mysort(Rem, NewAcc, Res).


/*
delete_first(X, [X|R1], R1) :- !.
delete_first(X, [Y|R1], [Y|R2]) :- delete_first(Y, R1, R2).

% dont know what sort algorithm this procedure implements, maybe insert
% but it must be very very slow :)

mysort([], []).
mysort([X], [X]).
mysort(L, [X, Y | R]) :- member(X, L), delete_first(X, L, L1), member(Y, L1), X =< Y, mysort(L1, [Y|R]).
*/