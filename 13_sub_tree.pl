sub_tree(tree(L, R, X), tree(L, R, X)).
sub_tree(tree(L, _, _), L).
sub_tree(tree(_, R, _), R).
sub_tree(tree(L, R, _), T2) :- sub_tree(L, T2); sub_tree(R, T2).