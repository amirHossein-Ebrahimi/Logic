/* Propositional Logic */
/* Expertions and Formula with two atom p, q */

/*Atoms*/
m_atom(p).
m_atom(q).

/*connectetive */
connectetive(and).
connectetive(or).
connectetive(arrow).
connectetive(neg).

total(X) :- m_atom(X); connectetive(X).

% experations
experation(X) :- total(X).
experation((X, Y)) :- experation(X), experation(Y).

% Formula
formula(X) :- m_atom(X).
% formula((X, (Y, Z))) :- connectetive(Y), formula(X), formula(Z).
formula([X, Y, Z]) :- connectetive(Y), formula(X), formula(Z).
formula([neg, X]) :- formula(X).

/*  Validity and Soundness  === Validity fot top atoms*/
% p and ~q are True
valid_1(X) :- (X = p), not(X = q), m_atom(X).
valid_1([X, Y]) :- (X = neg), formula([X, Y]), not(valid_1(Y)).
valid_1([X, Y, Z]) :- (Y = and), formula([X, Y, Z]), valid_1(X), valid_1(Z).
valid_1([X, Y, Z]) :- (Y = or), formula([X, Y, Z]), valid_1(X); valid_1(Z).
valid_1([X, Y, Z]) :- (Y = arrow), formula([X, Y, Z]), valid_1([neg, X]); valid_1(Z).

% q and ~p are True
valid_2(X) :- (X = q), not(X = p), m_atom(X).
valid_2([X, Y]) :- (X = neg), formula([X, Y]), not(valid_2(Y)).
valid_2([X, Y, Z]) :- (Y = and), formula([X, Y, Z]), valid_2(X), valid_2(Z).
valid_2([X, Y, Z]) :- (Y = or), formula([X, Y, Z]), valid_2(X); valid_2(Z).
valid_2([X, Y, Z]) :- (Y = arrow), formula([X, Y, Z]), valid_2([neg, X]); valid_2(Z).

% ~p and ~q are True
valid_3(X) :- not(X = p), not(X = q), m_atom(X).
valid_3([X, Y]) :- (X = neg), formula([X, Y]), not(valid_3(Y)).
valid_3([X, Y, Z]) :- (Y = and), formula([X, Y, Z]), valid_3(X), valid_3(Z).
valid_3([X, Y, Z]) :- (Y = or), formula([X, Y, Z]), valid_3(X); valid_3(Z).
valid_3([X, Y, Z]) :- (Y = arrow), formula([X, Y, Z]), valid_3([neg, X]); valid_3(Z).

% p or q are True
valid_4(X) :- (X = p), (X = q).
valid_4([X, Y]) :- (X = neg), formula([X, Y]), not(valid_4(Y)).
valid_4([X, Y, Z]) :- (Y = and), formula([X, Y, Z]), valid_4(X), valid_4(Z).
valid_4([X, Y, Z]) :- (Y = or), formula([X, Y, Z]), valid_4(X); valid_4(Z).
valid_4([X, Y, Z]) :- (Y = arrow), formula([X, Y, Z]), valid_4([neg, X]); valid_4(Z).

/* Validity tutal */
valid(X) :- valid_1(X), valid_2(X), valid_3(X), valid_4(X).


/* test case
:: valid([[p, [or, q]], arrow, q]).
:: valid([[p, arrow, p], arrow, [p, or, [neg, p]]]).
*/
in([X|Y], [A|B]) :- ((X = A), in(Y, B)); (in(Y, [A|B])).

% *********************************** turnstile := ts *******************************************
% Axioms
d(A, A) :- (A = A).
d(Gamma, [Delta, [A]]) :- in(Gamma, A).
% d(Gamma, [Delta, or, [A, and, B]]) :- d(Gamma, [Delta, or, A]), d(Gamma, [Delta, or, B]).
% d([[A, and, B], and, Gamma], Delta) :- d([B, and, Gamma], Delta).
% d([[A, and, B], and, Gamma], Delta) :- d([A, and, Gamma], Delta).

% logical rules



% turnstile([[Gamma, Sigmma], [Delta, Pi]]) :- turnstile((Gamma, (Delta, A))), turnstile(((A, Sigmma), Pi)).
%     % and L1
% turnstile(((Gamma, (A, (and, B))), Delta)) :- turnstile(((Gamma, A), Delta)).
%     % and R1
% turnstile(((Gamma, ((A, (or, B))), Delta)) :- turnstile((Gamma, (A, Delta))).
%     % and L2
% turnstile(((Gamma, (A, (and, B))), Delta)) :- turnstile(((Gamma, B), Delta)).
%     % and R2
% turnstile(((Gamma, (A, (or, B))), Delta)) :- turnstile((Gamma, (B, Delta))).
%     % or L
% turnstile(((Gamma, Sigma, (A, (or, B))), (Delta, Pi))) :-
