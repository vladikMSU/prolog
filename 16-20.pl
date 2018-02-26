% graph
edge(d,e,9).
edge(a,b,3).
edge(b,f,1).
edge(f,d,2).
edge(a,c,4).
edge(c,d,2).

% doubly link
newedge(X, Y, N) :- edge(X, Y, N); edge(Y, X, N).
newedge(X, Y) :- edge(X, Y, _); edge(Y, X, _).



% TASK #16
% path(X, Y, P): P - path between X and Y (in form of list of edges)
% prototypes - all (i/o, i/o, i/o); indeterm for all prototypes

path(X, Y, P) :- path(X, Y, [X], P).

path(X, Y, Visited, [X,Y]) :- newedge(X, Y), not(member(Y, Visited)).
path(X, Y, Visited, [X|L]) :- newedge(X, Z), not(member(Z, Visited)), path(Z, Y, [Z|Visited], L).







% TASK #17
% min_path(X, Y, P): P - path between X and Y with minimal cost
% prototypes - (i,i,i), (i,i,o), ; determined

my_list_min([PX | R], Min) :- my_list_min(R, PX, Min).

my_list_min([], [P, _], P).
my_list_min([[P, X] | R], [_, MinX], Min) :- X =< MinX, !, my_list_min(R, [P,X], Min).
my_list_min([_ | R], MinPX, Min) :- my_list_min(R, MinPX, Min).


cost([X, Y | R], C) :- newedge(X, Y, N), cost([Y | R], C1), C is C1+N.
cost([_], 0).

min_path(X, Y, MP) :- findall([P, C], (path(X, Y, P), cost(P, C)), PCs), my_list_min(PCs, MP).






% TASK #18
% short_path(X, Y, P): P - path with least edges involved

short_path(X, Y, P) :- bfs(Y, [[X]], P).

consed(A,B,[B|A]).

bfs(Y, [[Y|R] | _], P) :- !, reverse([Y|R], P).
bfs(Y, [VisCur|VisRem], P) :-
    VisCur = [Cur| _], % current path
    findall(X, (newedge(Cur, X), not(member(X, VisCur))), Xs), % find all new directions where path can be continued
    maplist(consed(VisCur), Xs, VisCurExtended), % get list of extended pathes
    append(VisRem, VisCurExtended, UpdatedVis), % add extended pathes to the end
    bfs(Y, UpdatedVis, P).

%length([X | R], Len) :- length(R, Len1), Len = Len1 + 1.
%length([], -1).

%short_path(X, Y, SP) :- findall([P, L], (path(X, Y, P), length(P, L)), PLs), my_list_min(PLs, SP).







% TASK #19
% cyclic: true if there is a cycle in a graph

cyclic :- newedge(X, Y), newedge(Y, Z), dif(X,Z), cyclic(X, [Z,Y]), !.

cyclic(X, [X|_]) :- !.
cyclic(X, Vis) :- Vis=[Y|_], newedge(Y, Z), not(member(Z, Vis)), cyclic(X, [Z|Vis]).






% TASK #20
% is_connected: true if any two edges have path between them

not_connected :- newedge(X, _), newedge(Y, _), dif(X, Y), not(path(X, Y, _)). 

is_connected :- not(not_connected).