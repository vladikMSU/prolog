flatten_tree(T, R) :- flat(T, [], R).

flat(nil, Res, Res) :- !.
flat(tree(nil, nil, X), Res, [X|Res]) :- !.
flat(tree(L, R, X), Acc, Res) :- flat(R, Acc, Res1), flat(L, [X|Res1], Res).