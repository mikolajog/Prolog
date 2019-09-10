delta(A,B,C, Wynik) :-
	Wynik is (B*B) - (4*A*C).

kwadrat(A,B,C, Wynik) :-
	delta(A,B,C, W1),
	W1>0.0, 
	Wynik is (-B-sqrt(W1))/(2*A). 

kwadrat(A,B,C, Wynik) :-
	delta(A,B,C, W1),
	W1>0.0, 
	Wynik is (-B+sqrt(W1))/(2*A). 

kwadrat(A,B,C,Wynik) :-
	delta(A,B,C,W1),
	W1=:=0.0, 
	Wynik is -B/(2*A).


kwadrat(A,B,C,Wynik) :-
	delta(A,B,C,W1),
	FAIL.

