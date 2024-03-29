
% IMIĘ I NAZWISKO: Mikołaj Ogarek 
% gr. 4B

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [5 pkt] ZADANIE 1 (rozgrzewka z listami)
% Stwórz listę zawierającą wszystkie liczby całkowite z zadanego zakresu.
% Przykład:
% ?- zakres(4,9,Lista).
% Lista = [4,5,6,7,8,9]

sklej([],X,X).

sklej([X|L1],L2,[X|L3]) :-
	sklej(L1,L2,L3).

zakres(B,B,[B]).
zakres(A,B,L):-
	B > A,
	X is A+1,
	zakres(X,B,L1),
	sklej([A],L1,L),!.	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [10 pkt] ZADANIE 2 (trudniejsze listy)
% Lista jest podwójna jeżeli składają się na nią dwie identyczne części.
% Sprawdź czy lista podana jako argument jest podwójna.
% Przykład:
% ?- podwojna([a,b,c,d,a,b,c,d]).
% True
% ?- podwojna([a,b,a]).
% False

podz([A],[A],[]).
podz([],[],[]).
podz(L,L1,L2):-
	sklej(X,[A],L),
	sklej([B],Y,X),
	podz(Y,L3,L4),
	sklej([B],L3,L1),
	sklej(L4,[A],L2).

podwojna(List) :- 
	podz(List, L1, L1),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [15 pkt] ZADANIE 3 (baza wiedzy)
% Poniższa baza wiedzy opisuje wybrane relacje w austriackiej
% dynastii Habsburgów na przełomie XVII i XVIII wieku:

mezczyzna(franciszek_I).
mezczyzna(franciszek_II).
mezczyzna(jozef_I).
mezczyzna(jozef_II).
mezczyzna(karol_VI).
mezczyzna(leopold_I).
mezczyzna(leopold_II).
mezczyzna(ferdynand_I).

kobieta(maria_teresa).
kobieta(maria_antonina).

% dziecko(Dziecko, Rodzic).
dziecko(leopold_II, maria_teresa).
dziecko(franciszek_II, leopold_II).
dziecko(jozef_I, leopold_I).
dziecko(karol_VI, leopold_I).
dziecko(maria_teresa, karol_VI).
dziecko(jozef_II, maria_teresa).
dziecko(jozef_II, franciszek_I).
dziecko(leopold_II, franciszek_I).
dziecko(maria_antonina, maria_teresa).
dziecko(maria_jozefa, jozef_I).
dziecko(maria_amalia_wettyn, maria_jozefa).

% (a) [7.5 pkt]
% Zdefiniuj operatory jest_kobieta i jest_mezczyzna działające jak niżej:
% ?- maria_teresa jest_mezczyzna.
% False

jest_kobieta(X):-
	kobieta(X).

jest_mezczyzna(X):-
	mezczyzna(X).

:- op(100, xf, jest_kobieta).
:- op(100, xf, jest_mezczyzna).

% ?- X jest_kobieta.
% X = maria_teresa;
% X = maria_antonina.

% (b) [7.5 pkt]
% Dopisz predykat wspolne_pokolenie/2, który sprawdza czy osoby A i B
% są na tym samym poziomie w drzewie genealogicznym.
% Przykład:
% ?- wspolne_pokolenie(jozef_II, jozef_II).
% False   %% Chcemy się uchronić przed sytuacją, w której predykat zwraca
%         %% nam, że ktoś jest w relacji z samym sobą
% ?- wspolne_pokolenie(maria_amalia_wettyn, maria_antonina).
% True    %% Wspólny pradziadek (leopold_I)


wspolne_pokolenie(OsobaA, OsobaB) :- 
	dziecko(OsobaA,X),
	dziecko(OsobaB,X),
	\+ OsobaA=OsobaB.

wspolne_pokolenie(OsobaA, OsobaB) :- 
	dziecko(OsobaA,X),
	dziecko(OsobaB,Y),
	wspolne_pokolenie(X,Y),
	\+ OsobaA=OsobaB.

