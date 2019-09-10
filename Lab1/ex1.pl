rodzic(kasia,robert).
rodzic(tomek,robert).
rodzic(tomek,eliza).
rodzic(robert,anna).
rodzic(robert,magda).
rodzic(magda,jan).
 
kobieta(kasia).
kobieta(eliza).
kobieta(magda).
kobieta(anna).
 
mezczyzna(tomek).
mezczyzna(robert).
mezczyzna(jan).

famme(kasia).
homme(krzys).
parent(kasia,krzys).

matka(X,Y) :-
	rodzic(X,Y),
	kobieta(X).
 
ojciec(X,Y) :-
	rodzic(X,Y),
	mezczyzna(X).

brat(X,Y) :-
	mezczyzna(X),
	rodzic(Z,X),
	rodzic(Z,Y),
	X\=Y. 

siostra(X,Y) :-
	kobieta(X),
	rodzic(Z,X),
	rodzic(Z,Y),
	X\=Y. 

dziadek(X,Y) :-
	mezczyzna(X),
	rodzic(X,Z),
	rodzic(Z,Y).

babcia(X,Y) :-
	kobieta(X),
	rodzic(X,Z),
	rodzic(Z,Y).

czlowiek(X) :-
	kobieta(X).

czlowiek(Y) :-
	mezczyzna(Y). 


przodek(X,Y) :-
	rodzic(X,Y).
 
przodek(X,Z) :-
	rodzic(X,Y),
	przodek(Y,Z).

potomek(X,Y) :-
	rodzic(Y, X).

potomek(X, Z) :-
	rodzic(Y,X),
	potomek(Y,Z).

krewny(X,Y) :-
	potomek(X,Y).
krewny(X,Y) :-
	przodek(X,Y).
	



