porownaj([A,B,C,C|Reszta]).

zamien([A,B,C,D|Reszta],X) :-
	 X=[A,B,D,C|Reszta].
	

nalezy(X,[X|_]).
nalezy(X,[_|Yogon]) :-
	nalezy(X,Yogon).

dlugosc([],0).
dlugosc([_|Ogon],Dlug) :-
	dlugosc(Ogon,X),
	Dlug is X+1.

a2b([],[]).
a2b([a|Ta],[b|Tb]) :- 
   a2b(Ta,Tb).

sklej([],X,X).
sklej([X|L1],L2,[X|L3]) :-
	sklej(L1,L2,L3).

usun3ostatnie(Lista, W) :-
	sklej(W, [_,_,_], Lista).
usun3pierwsze(Lista, W) :-
	sklej([_,_,_], W, Lista).
usun3pierwsze3ostatnie(Lista, W) :-
	sklej([_,_,_], M, Lista),
	sklej(W, [_,_,_], M).

nieparzysta([_]). 
nieparzysta([_,_|Ogon]):-
	nieparzysta(Ogon). 

parzysta([_,_]). 
parzysta([_,_|Ogon]):-
	parzysta(Ogon). 

palindrom(L) :-
	odwroc(L, L).

palindromBezOdwroc([_]).
palindromBezOdwroc([]).

palindromBezOdwroc([A|Reszta]):-
	ostatni(A, Reszta),
	sklej(L,[A], Reszta),
	palindromBezOdwroc(L). 

przesun([A|Reszta], L2) :-
	sklej(Reszta, [A], L2).

znaczy(0,zero).   
znaczy(1,jeden).
      
znaczy(2,dwa).    
znaczy(3,trzy).
      
znaczy(4,cztery). 
znaczy(5,piec).
      
znaczy(6,szesc).  
znaczy(7,siedem).
      
znaczy(8,osiem).  
znaczy(9,dziewiec).	
		
przeloz([A], L2) :-
	znaczy(A, B),
	sklej([B], [], L2).

przeloz([A|Reszta], L2) :-
	przeloz(Reszta, M),
	znaczy(A, B),
	sklej([B], M, L2).

nalezy1(X,L) :-
	sklej(_,[X|_],L).

ostatni(Element,Lista) :-
	sklej(_, [Element], Lista).


ostatniBezSklej(X, [X]). 
ostatniBezSklej(Element,[_|Yogon]) :-
	ostatniBezSklej(Element, Yogon).

dodaj(X,L,[X|L]).

usun(X,[X|Reszta],Reszta).
usun(X,[Y|Ogon],[Y|Reszta]) :-
	usun(X,Ogon,Reszta).

wstaw(X,L,Duza) :-
	usun(X,Duza,L).

nalezy2(X,L) :-
	usun(X,L,_).

zawiera(S,L) :-
	sklej(_,L2,L),
	sklej(S,_,L2).

podzbior(L,Z) :-
	write('Tak'),
	sklej(_,L2,L),
	sklej(Z,_,L2).
	 

permutacja([],[]).
permutacja([X|L],P) :-
	permutacja(L,L1),
	wstaw(X,L1,P).
 
permutacja2([],[]).
permutacja2(L,[X|P]) :-
	usun(X,L,L1),
	permutacja2(L1,P).

odwroc([],[]).
odwroc([H|T],L) :-
	odwroc(T,R),
	sklej(R,[H],L).

wypisz([H|T]) :-
	put(H), wypisz(T).
wypisz([]).

plural(Noun, PL) :- 
	name(Noun, L), 
	name(s,T), 
	append(L,T, NL), 
	name(PL, NL).

podziel([],[],[]).
podziel([A], [A],[]).
podziel([A,B|Reszta], X, Y) :-
	podziel(Reszta, Z1, Z2), 
	sklej([A], Z1, X),
	sklej([B], Z2, Y). 

splaszcz([],[]).
splaszcz(A,[A]).
splaszcz([[A]|Reszta], X) :-
	splaszcz(A, R1),
	splaszcz(Reszta, R2),
	sklej(R1, R2, X).

splaszcz([A|Reszta], X) :-
	splaszcz(Reszta, R2),
	sklej(A, R2, X).






















zakres(S, S, []). 
zakres(Start, Stop, Lista) :-
	L is Start+1,
	zakres(L, Stop, X),
	sklej([L], X, Lista). 
	

liczba(1).
liczba(2). 
liczba(3).
liczba(4). 
liczba(5).
liczba(6). 
liczba(7).
liczba(8). 
liczba(9).

lista_ma_liczby([X]) :-
	liczba(X).
lista_ma_liczby([X|Reszta]):-
	liczba(X),
	lista_ma_liczby(Reszta).

sum_lub_roznica([], X, Y).
sum_lub_roznica(Z, X, Y) :-
	Z is X+Y.
sum_lub_roznica(Z, X, Y) :-
	Z is X-Y.
sum_lub_roznica(Z, X, Y) :-
	Z is Y-X.

suma_lub_roznica_tych_ponizej([],[],[],[],[],[]).

suma_lub_roznica_tych_ponizej([N11|[N12|Reszta1]],[C11|[C12|Reszta2]],[C21|[C22|Reszta3]],[C31|[C32|Reszta4]],[N21|[N22|Reszta5]],[N3|Reszta1]):-
	sum_lub_roznica(N31,N21,N22),
	sum_lub_roznica(N21,C31,C32),
	sum_lub_roznica(C31,C21,C22),
	sum_lub_roznica(C21,C11,C12),
	sum_lub_roznica(C11,N11,N12),
	suma_lub_roznica_tych_ponizej([N12|Reszta1],[C12|Reszta2],[C22|Reszta3],[C32|Reszta4], [N22|Reszta5], Reszta1).


rozwiazania_tego(N1, C1, C2, C3, N2, N3) :-
	suma_lub_roznica_tych_ponizej(N1, C1, C2, C3, N2, N3),
	lista_ma_liczby(N1),
	lista_ma_liczby(C1),
	lista_ma_liczby(C2),
	lista_ma_liczby(C3),
	lista_ma_liczby(N2),
	lista_ma_liczby(N3),
	list_to_set(N1, N1),
	list_to_set(N2,N2),
	list_to_set(N3,N3), 
	list_to_set(C1, X),
	X\=C1, 
	list_to_set(C2, Y),
	Y\=C2, 
	list_to_set(C3, Z),
	Z\=C3.

	

	
	

	
 


	


	

