%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Sklej - IMPORTANTE
sklej([],X,X).
sklej([X|L1],L2,[X|L3]) :-
	sklej(L1,L2,L3).

%Czy element nalezy do listy:
nalezy(X,[X|_]).
nalezy(X,[_|Yogon]) :-
	nalezy(X,Yogon).

nalezy1(X,L) :-
	sklej(_,[X|_],L).

nalezy2(X,L) :-
	usun(X,L,_).

%Ilość elementów w liście:
dlugosc([],0).
dlugosc([_|Ogon],Dlug) :-
	dlugosc(Ogon,X),
	Dlug is X+1.

%Ostatni element listy:
ostatni(Element,[Element]).
ostatni(Element,[A|Rest]):-
	ostatni(Element,Rest),!.

%Dodawanie pojedynczego el. na początek:
dodaj(X,L,[X|L]).

usun(X,[X|Reszta],Reszta).
usun(X,[Y|Ogon],[Y|Reszta]) :-
	usun(X,Ogon,Reszta).

%Wstaw gdziekolwiek:
wstaw(X,L,Duza) :-
	usun(X,Duza,L).


%Zawieranie się:
zawiera(S,L) :-
	sklej(_,L2,L),
	sklej(S,_,L2).

%Permutacje:
permutacja([],[]).
permutacja([X|L],P) :-
	permutacja(L,L1),
	wstaw(X,L1,P).
 
permutacja2([],[]).
permutacja2(L,[X|P]) :-
	usun(X,L,L1),
	permutacja2(L1,P).

%Odwracanie listy:
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


a2b([],[]).
a2b([a|Ta],[b|Tb]) :- 
   a2b(Ta,Tb).


%Wybranie 3. elementu z listy
trzeci([A,B,C|Rest],C).

%Porównanie konkretnych elementów listy:
porownaj([A,B,C,B|Rest]).

%Zamien elementy w liscie:
zamien([A,B|Rest], [B,A|Rest]).


%Podziel listę na L i P wg numeru elementu: 
podziel([],[],[],Poz).
podziel([],P,P,1).

podziel(L,P,[A|Reszta] , Poz) :-
	Poz > 1,
	N is Poz -1,
	podziel(K,P, Reszta, N),
	sklej([A], K,L).

%Umieść element na zadanej pozycji w liście: 
podziel([],[],[],Poz).
podziel([],P,P,1).

podziel(L,P,[A|Reszta] , Poz) :-
	Poz > 1,
	N is Poz -1,
	podziel(K,P, Reszta, N),
	sklej([A], K,L).

umiesc(Elem, List, Pozycja, Wynik) :-
	podziel(L, P, List, Pozycja),
	sklej(L, [Elem], W),
	sklej(W, P, Wynik).

%Podziel na parzyste i nieparzyste listę:
podzielparznieparz([],[],[]).
podzielparznieparz([A],[A],[]).
podzielparznieparz([A,B|Rest],L1,L2):-
	podziel(Rest,X,Y),
	sklej([A],X,L1),
	sklej([B],Y,L2),!.

%Dzieli na dwa fragmenty o mniej wiecej rownej dlugosci:
podz([A],[A],[]).
podz([],[],[]).
podz(L,L1,L2):-
	sklej(X,[A],L),
	sklej([B],Y,X),
	podz(Y,L3,L4),
	sklej([B],L3,L1),
	sklej(L4,[A],L2).

%Splaszcza liste:
splaszcz([],[]).
splaszcz([A|Reszta],X):-
	splaszcz(A,W1),
	splaszcz(Reszta,W2),
	sklej(W1,W2,X),!.
splaszcz(A,[A]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Silnia:
factorial(0,1).
factorial(Number,Result) :-
        Number > 0,
        NewNumber is  Number-1,
        factorial(NewNumber,NewResult),
        Result  is  Number*NewResult.

%Fibonacci:
fibo(0,0).
fibo(1,1).
fibo(Liczba, Wynik) :-
	Liczba > 1,
	L1 is Liczba-1,
	L2 is Liczba-2,
	fibo(L1,W1),
	fibo(L2,W2),
	Wynik is W1 + W2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Zadanka z ćwiczeń:
usun3ostatnie(L,X):-
	sklej(X,[_,_,_],L).

usun3pierwsze(L,X):-
	sklej([_,_,_],X,L).

usun3pierwszeostatnie(L,X):-
	usun3ostatnie(L,Y),
	usun3pierwsze(Y,X).

nieparzysta([A]).
nieparzysta([A,B|Rest]):-
	nieparzysta(Rest).

parzysta([]).
parzysta([A,B|Rest]):-
	parzysta(Rest).

palindrom(L):-
	odwroc(L,L).

przesun([X|Rest],L2):-
	sklej(Rest,[X],L2).
	
znaczy(0,zero).   znaczy(1,jeden).
      znaczy(2,dwa).    znaczy(3,trzy).
      znaczy(4,cztery). znaczy(5,piec).
      znaczy(6,szesc).  znaczy(7,siedem).
      znaczy(8,osiem).  znaczy(9,dziewiec).	

przeloz([A],X):-
	znaczy(A,Z),
	X=[Z].
przeloz([A|Rest],L2):-
	znaczy(A,Z),
	przeloz(Rest,X),
	sklej([Z],X,L2),!.

podzbior(L,Z):-
	permutacja(L,P),
	sklej(Z,X,P).

%Predykat bagof/3, użyty jako bagof(X,P,L) buduje listę L, złożoną z takich X, że spełnione jest P. 

%Podobnie działa setof/3, jednak powstała lista jest posortowana i nie zawiera ew. duplikatów. 

%Predykat findall/3 wymusza wyszukanie wszystkich możliwych wyników.



podziel([],[],[],Poz).
podziel([],P,P,1).

podziel(L,P,[A|Reszta] , Poz) :-
	Poz > 1,
	N is Poz -1,
	podziel(K,P, Reszta, N),
	sklej([A], K,L).


umiesc(Elem, List, Pozycja, Wy nik) :-
	podziel(L, P, List, Pozycja),
	sklej(L, [Elem], W),
	sklej(W, P, Wynik).

delta(A,B,C,WYNIK):- 
	WYNIK is B+B-4*A*C, write('obliczam delte'),nl.
pierwiastek(A,B,C):- 
	delta(A,B,C,W), W<0, write('Brak rozwiazan').
pierwiastek(A,B,C):- 
	delta(A,B,C,W), W=:=0, write('Jedno rozwiazanie').
pierwiastek(A,B,C):- 
	delta(A,B,C,W), W>0, write('Dwa rozwiazania').



