% example tree for copy-paste: 
% tree(tree(nil, nil, f), tree(tree(nil, nil, p), tree(nil, nil, r), k), g).
%       g
%      / \
%     f  k
%       / \
%      p   r


% #12. tree_depth(T, N): N is the depth of tree T
% prototypes - (i,i), (i,o)

tree_depth(nil, 0).
tree_depth(tree(L, R, _), N) :- tree_depth(L, NL),tree_depth(R, NR), N is max(NL, NR)+1.




% #13. sub_tree(T1, T2): T2 is the subtree of tree T1
% prototypes - (i,i), (i,o) ND

sub_tree(tree(L, R, X), tree(L, R, X)).
sub_tree(tree(L, _, _), L) :- dif(L, nil).
sub_tree(tree(_, R, _), R) :- dif(R, nil).
sub_tree(tree(L, R, _), T2) :- sub_tree(L, T2); sub_tree(R, T2).

% TODO fix a lot of duplicate answers




% #14. flatten_tree(T, L): L is the flattened tree T
% prototypes - (i,i), (i,o)

flat(nil, Res, Res) :- !.
flat(tree(nil, nil, X), Res, [X|Res]) :- !.
flat(tree(L, R, X), Acc, Res) :- flat(R, Acc, Res1), flat(L, [X|Res1], Res).

flatten_tree(T, R) :- flat(T, [], R).




% #15. substitute(T1, V, T, T2): T2 is a tree which was built from tree T1 by replacing all the values V with the term T
% prototypes - (i,i,i,i), (i,i,i,o), (i,i,o,i), (i,o,i,i),(o,i,i,i)

substitute(nil, _, _, nil).
substitute(tree(L1, R1, V), V, T, tree(L2, R2, T)) :- !, substitute(L1, V, T, L2), substitute(R1, V, T, R2).
substitute(tree(L1, R1, X), V, T, tree(L2, R2, X)) :- substitute(L1, V, T, L2), substitute(R1, V, T, R2).