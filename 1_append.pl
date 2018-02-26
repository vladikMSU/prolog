% append(L1, L2, L3): L3 is a result of concatenation of L1 and L2
% prototypes - (i,i,i), (i,i,o), (i,o,i),  (o,i,i), (o,o,i) ND*

append([], L2, L2).
append([X|R1], L2, [X|R3]):-append(R1,L2,R3).

% * here and after - indeterminate