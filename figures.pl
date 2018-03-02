:- use_module(library(pce)).

start :-
    new(DW, dialog('Geometric puzzle')),
    send(DW, height(250)),
    send(DW, width(500)),
    new(Picture, picture),
    send(Picture, width(140)),
    send(Picture, height(140)),
    new(Answers, picture),
    send(Answers, width(150)),
    send(Answers, height(120)),
    new(Group,dialog_group(puzzle)),
    new(Text, text),
    new(Num, menu('Answer')),
    new(Gr,dialog_group(answers)),
    send_list(Group, append,
        [Picture, button('Easy',   and(message(Picture, clear),
                                       message(Answers, clear),
                                       message(@prolog, game, 1, Picture, Answers, Gr, Num, Text))),
                  button('Normal', and(message(Picture, clear),
                                       message(Answers, clear),
                                       message(@prolog, game, 2, Picture, Answers, Gr, Num, Text))),
                  button('Hard',   and(message(Picture, clear),
                                       message(Answers, clear),
                                       message(@prolog, game, 3, Picture, Answers, Gr, Num, Text)))
        ]),
    send(DW, display, Group, point(15, 0)),
    send(DW, display, Gr,    point(250, 10)),
    new(One,   text('1')),
    new(Two,   text('2')),
    new(Three, text('3')),
    send(Gr, display, Answers, point(15, 0)),
    send(Gr, display, Text,    point(10, 175)),
    send(Gr, display, One,     point(0, 10)),
    send(Gr, display, Two,     point(0, 60)),
    send(Gr, display, Three,   point(0, 110)),
    send(DW, open).

game(Level, Picture, Answers, Gr, Num, Text) :-
    send(Num, clear),
    send_list(Num, append, [1,2,3]),
    send(Text, clear),
    gener([red, green, blue], [triangle, circle, square], Picture, AnsC, AnsS, Level),
    gen_answer([red, green, blue], [triangle, circle, square], [[AnsC, AnsS]], AnsC, AnsS, Answers, 3, Ind),
    send(Gr, display, Num, point(0, 150)),
    send(Gr, display, button('Submit', message(@prolog, check_submission, Ind, Num?selection, Text)), point(100, 175)).

gener(C, S, Pic, AnsC, AnsS, Level) :-
    random_permutation(C, Colours),
    random_permutation(S, Shapes),
    paintRaw(Colours, Shapes, Pic, 5, 10),
    gener2nd(Colours, Shapes, Colours2, Shapes2, [], [], C, S, Pic),
    gener3rd(Colours, Shapes, Colours2, Shapes2, C, S, [], [], Pic, AnsC, AnsS, Level).

paintRaw([], [], _, _, _).
paintRaw([Col|ColsRest], [Sh|ShapesRest], Picture, X, Y) :-
    analyse(Col, Sh, Picture, X, Y),
    paintRaw(ColsRest, ShapesRest, Picture, X + 50, Y).

analyse(Col, triangle, Pic, X, Y) :-
    create_triangle(Col, Pic, X, Y).
analyse(Col, circle, Pic, X, Y) :-
    create_circle(Col, Pic, X, Y).
analyse(Col, square, Pic, X, Y) :-
    create_box(Col, Pic, X, Y).

create_triangle(Col, Pic, X, Y) :-
    new(Triangle, path),
    send_list(Triangle, append, [point(X,Y+30), point(X+15,Y), point(X+30,Y+30)]),
    send(Triangle, fill_pattern, colour(Col)),
    send(Pic, display, Triangle).

create_circle(Col, Pic, X, Y) :-
    new(Cir, circle(30)),
    send(Cir,fill_pattern, colour(Col)),
    send(Pic, display, Cir, point(X, Y)).

create_box(Col, Pic, X, Y) :-
    new(Sq, box(30, 30)),
    send(Sq, fill_pattern, colour(Col)),
    send(Pic, display, Sq, point(X, Y)).



take_one(E, [E|_]).
take_one(E, [_|T]) :- take_one(E, T).

gener2nd([], [], C, S, C, S, _, _, Pic) :- 
    paintRaw(C, S, Pic, 5, 50).
gener2nd([C| Col], [S| Sh], C2, S2, NewC, NewS, C1, S1, Pic) :-
    take_one(EC, C1),
    dif(EC, C),
    take_one(ES, S1),
    dif(ES, S),
    not(member(EC, NewC)),
    not(member(ES, NewS)),
    append(NewC, [EC], NewC1),
    append(NewS, [ES], NewS1),
    gener2nd(Col, Sh, C2, S2, NewC1, NewS1, C1, S1, Pic).

gener3rd([], [], [], [], _, _, [C1,C2|C], [S1,S2|S], Pic, C, S, 1) :-
    paintRaw([C1,C2], [S1,S2], Pic, 5, 90).
gener3rd([], [], [], [], _, _, [C1|C], [S1|S], Pic, C, S, 2) :-
    paintRaw([C1], [S1], Pic, 5, 90).
gener3rd([], [], [], [], _, _, C, S, _, C, S, 3).
gener3rd([C1|Cs1], [S1|Ss1], [C2|Cs2], [S2|Ss2], Colours, Shapes, C3, S3, Pic, A, B, Level) :-
    take_one(EC, Colours),
    dif(EC, C1),
    dif(EC, C2),
    take_one(ES, Shapes),
    dif(ES, S1),
    dif(ES, S2),
    append(C3, [EC], NewC),
    append(S3, [ES], NewS),
    gener3rd(Cs1, Ss1, Cs2, Ss2, Colours, Shapes, NewC, NewS, Pic, A, B, Level).


gen_answer(_, _, Res, AnsC, AnsS, Pic, 1, Ind) :- 
    random_permutation(Res, Res1),
    paint(Res1, Pic, 0, 0),
    nth1(Ind, Res1, [AnsC,AnsS]).
gen_answer(Colours, Shapes, Res, AnsC, AnsS, Pic, N, Ind):-
    random_permutation(Colours, C),
    random_permutation(Shapes, S),
    make_set(C, S, [], [], Col, Sh, AnsC),
    not(member([Col, Sh], Res)),
    append(Res, [[Col, Sh]], Res1),
    N1 is N - 1,
    gen_answer(Colours, Shapes, Res1, AnsC, AnsS, Pic, N1, Ind).

make_set(_, _, C, S, C, S, []).
make_set(Colours, Shapes, ResCol, ResSh, Col, Sh, [_|AnsC]) :-
    take_one(C, Colours),
    take_one(S, Shapes),
    not(member(C, ResCol)),
    not(member(S, ResSh)),
    append([C], ResCol, ResCol1),
    append([S], ResSh, ResSh1),
    make_set(Colours, Shapes, ResCol1, ResSh1, Col, Sh, AnsC).

paint([], _, _, _).
paint([[C, S]| T], Pic, X, Y) :-
    paintRaw(C, S, Pic, X, Y),
    paint(T, Pic, X, Y + 50).

check_submission(Ind, Ind, Text) :-
    send(Text, clear),
    send(Text, append, 'Yes!').
check_submission(Ind, _, Text) :-
    send(Text, clear),
    send(Text, append, 'No, '),
    send(Text, append, Ind).