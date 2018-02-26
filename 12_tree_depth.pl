tree_depth(nil, 0).
tree_depth(tree(L, R, _), N) :- tree_depth(L, NL),tree_depth(R, NR), N is max(NL, NR)+1.