substitute(nil, _, _, nil).
substitute(tree(L1, R1, V), V, T, tree(L2, R2, T)) :- !, substitute(L1, V, T, L2), substitute(R1, V, T, R2).
substitute(tree(L1, R1, X), V, T, tree(L2, R2, X)) :- substitute(L1, V, T, L2), substitute(R1, V, T, R2).