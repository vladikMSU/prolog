% union(M1, M2, M3): M3 is a set which is a union of sets M1 and M2
% prototypes - (i,i,i), (i,i,o)

delete_one(_, [], []).
delete_one(E, [E|R], R).
delete_one(E, [X|R1], [X|R2]) :- delete_one(E, R1, R2).

union([], [], []).
union(M1, M2, [X|RM3]) :- member(X, M1), delete_one(X, M1, NewM1), delete_one(X, M2, NewM2), union(NewM1, NewM2, RM3), !.
union(M1, M2, [X|RM3]) :- member(X, M2), delete_one(X, M1, NewM1), delete_one(X, M2, NewM2), union(NewM1, NewM2, RM3), !.


% TODO mabe make (i,i,o) generate all the permutations representing this set