
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
	sklej([A],L1,L).	


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Umieść element na zadanej pozycji w liście.
% Przykład:
% ?- umiesc(alfa,[a,b,c,d],2,Wynik).
% Wynik = [a,alfa,b,c,d]

podziel([],[],[],Poz).
podziel([],P,P,1).

podziel(L,P,[A|Reszta] , Poz) :-
	Poz > 1,
	N is Poz -1,
	podziel(K,P, Reszta, N),
	sklej([A], K,L).
umiesc(Cos,List,Num,Wynik):-
	podziel(L,P,List,Num),
	sklej(L,[Cos],X),
	sklej(X,P,Wynik).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Andrzej, Barbara i Celina ustalają w toku rozmowy, że wykonują
% trzy różne zawody (lekarz, prawnik, inżynier) i grają na trzech
% różnych instrumentach (fortepian, flet, skrzypce). Wiedząc, że:
%  - Barbara jest żoną lekarza,
%  - prawnik gra na fortepianie,
%  - Barbara nie jest inżynierem,
%  - Andrzej jest pacjentem skrzypka
% ustal kto gra na flecie.
% NIE wykorzystuj w tym zadaniu LIST!
% Przykładowy wynik predykatu solution:
% ?- solution(Flute).
% Flute = krzysztof

% A logic puzzle involving jobs and musical instruments,
solution(Flute) :-
 
   % Distinct occupations and instruments
   uniq_people(Doctor,Lawyer,Engineer),
   uniq_people(Piano,Violin,Flute),
 
   % The four clues
   \+ barbara = Doctor,     % Barbara is married to the doctor.
   Lawyer = Piano,        % The lawyer plays the piano.
   \+ Engineer = barbara,   % The engineer is not Barbara.
   Violin = Doctor,       % Andrzej is a patient of 
   \+ andrzej = Violin.     %    the violinist.
 
% uniq(...) is used to generate three distinct people.
uniq_people(A,B,C) :- person(A),  person(B),  person(C),  
                      \+ A=B, \+ A=C, \+ B=C. 
 
% The three given people
person(andrzej).   person(barbara).   person(celina).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Dana jest baza wiedzy jak niżej:

% miasto(Nazwa, Populacja, Powierzchnia).
miasto('Warszawa', 1735442, 51724).
miasto('Kraków', 761873, 32685).
miasto('Łódź', 706004, 29325).
miasto('Wrocław', 634487, 29282).
miasto('Poznań', 545680, 26191).
miasto('Gdańsk', 461489, 26196).

% trasa(Miasto - Miasto, Długość, Szacowany czas przejazdu w minutach).
trasa('Warszawa' - 'Kraków', 294, 244).
trasa('Warszawa' - 'Kraków', 355, 239).
trasa('Warszawa' - 'Kraków', 311, 266).
trasa('Gdańsk' - 'Warszawa', 341, 253).
trasa('Warszawa' - 'Łódź', 130, 92).
trasa('Kraków' - 'Wrocław', 269, 169).

% Dopisz predykat dojazd/2, który wskazuje, czy istnieje pośrednia
% lub bezpośrednia trasa między dwoma miastami. Predykat powinien
% abstrahować od kierunku trasy (X - Y i Y - X są dla niego równoważne).
% Przykład:
% ?- dojazd('Łódź', 'Gdańsk').
% true

dojazd(MiastoX, MiastoY) :-
	trasa(MiastoX - MiastoY, X,Y), !.

dojazd(MiastoX, MiastoY) :-
	trasa(MiastoX - X, A,Y), 
	dojazd(X,MiastoY).

dojazd(MiastoX, MiastoY) :-
	trasa(MiastoY - MiastoX, X,Y),!.

dojazd(MiastoX, MiastoY) :-
	trasa(MiastoY - X, A,Y), 
	dojazd(X,MiastoX).


%Zmodyfikuj predykat dojazd/2 stworzony powyżej (skopiuj jego kod
% i rozbuduj go) tak, aby oprócz sprawdzenia, czy istnieje dojazd, podawał
% również listę miast, przez które trzeba przejechać. Miasta przejazdowe
% powinny być zwrócone jako lista w 3 argumencie.
% Przykład:
% ?- dojazd('Łódź', 'Gdańsk', Posrednie).
% Posrednie = ['Warszawa']

dojazd(MiastoX, MiastoY, []) :-
	trasa(MiastoX - MiastoY, X,Y), !.

dojazd(MiastoX, MiastoY, Posrednie) :-
	trasa(MiastoX - X, A,Y), 
	dojazd(X,MiastoY, P),
	sklej([X], P, Posrednie).

dojazd(MiastoX, MiastoY, []) :-
	trasa(MiastoY - MiastoX, X,Y),!.

dojazd(MiastoX, MiastoY, Posrednie) :-
	trasa(MiastoY - X, A,Y), 
	dojazd(X,MiastoX, P),
	sklej([X], P, Posrednie).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Wytnij zadany fragment listy. Start określa indeks pierwszego, a Stop
% indeks ostatniego wyciętego elementu. Zakładamy, że pierwszy element listy
% ma numer 1.
% Przykład
% ?- wytnij([a,b,c,d,e,f,g,h,i,k], 3, 7, Wynik).
% Wynik = [c,d,e,f,g]

wytnij(Lista, Start, Stop, Wynik) :-
	podziel(L1, P1, Lista, Stop+1), %%podziel jest u góry
	podziel(L2, Wynik, L1, Start). 
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stworzyc funkcje znajdujaca najmniejsza wartosc w liscie, pomocniczo zdefiniowana jest funkcja min(A,B,C), ktora 
% porownuje A z B i unifikuje mniejsza z tych dwoch z C. 
min(A,B,A):-
	B>A,!.
min(A,B,B):-
	A>=B,!.

listmin([A],A).
listmin([A|Reszta],X):-
	listmin(Reszta,M),
	min(A,M,X).

%stworzyc funkcje usuwajaca z listy pierwsze wystapienie wskazanej wartosci
removefirst([A|Reszta],A,Reszta).
removefirst([A|Reszta],Num,L):-
	removefirst(Reszta,Num,X),
	sklej([A],X,L),!.


%Zdefiniowac operator : z priorytetem 80, ktory bedzie sluzyl podczas podawania godziny. 
%Napisac predykat, ktory zwroci liczbe minut.

:- op(80, xfy, :).
godzina : minuty.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DRUGIEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

% Dodaj 1 do każdego elementu listy Lista i zwróć wynik jako ListaPlus1.
% Przykład:
% ?- dodaj_jeden([5,3,19,4],X).
% X = [6,4,20,5]

sklej([],X,X).
sklej([X|L1],L2,[X|L3]) :-
	sklej(L1,L2,L3).

dodaj_jeden([A], X):-
	B is A+1,
	sklej([B],[],X).
	
dodaj_jeden([A|Reszta], ListaPlus1) :- 
	dodaj_jeden(Reszta,X),
	B is A+1,
	sklej([B],X,ListaPlus1),!.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Podziel listę na dwie części. W pierwszej z nich powinny znaleźć się
% elementy dodatnie, a w drugiej z nich elementy ujemne.
% Przykład:
% ?- podziel([1,-3,-7,2,8], Dodatnie, Ujemne).
% Dodatnie = [1,2,8]
% Ujemne = [-3,-7]

podziel([A],[A],[]):-
	A>0.
podziel([A],[],[A]):-
	A<0.

podziel([A|Reszta], Dodatnie, Ujemne) :-
	podziel(Reszta,D,Ujemne),
	A>0,
	sklej([A],D,Dodatnie),!. 

podziel([A|Reszta], Dodatnie, Ujemne) :-
	podziel(Reszta,Dodatnie,U),
	A<0,
	sklej([A],U,Ujemne),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Znasz matrioszki? To rosyjskie wydrążone w środku lalki, które są włożone
% jedna w drugą.
% Dana jest baza wiedzy o naszym zbiorze matrioszek jak niżej:

% w(WewnętrznaLalka, ZewnętrznaLalka) -- definiuje bezpośrednie połączenie
% między matrioszkami (tzn. walentina znajduje się bezpośrednio w irinie)
w(walentina, irina).
w(natasza, katarina).
w(katarina, olga).
w(swietlana, walentina).

% (a) 
% Chcemy mieć możliwość definiowana bazy jak niżej. Spraw, aby było to
% możliwe (odkomentuj te linie po wykonaniu tej części zadania)

:- op(100, xfy, w).

ludmila w swietlana.
oksana w radmila.

% (b) 
% Dopisz predykat wewnetrzna/2, który sprawdza czy lalka A jest
% wewnątrz lalki B (albo bezpośrednio albo pośrednio).
% Przykład:
% ?- wewnetrzna(natasza, olga).
% True   %% pomiędzy nimi jest katarina
% ?- wewnetrzna(radmila, oksana).
% False

wewnetrzna(X,Y):-
	w(X,Y),!.

wewnetrzna(LalkaA, LalkaB) :-
	w(LalkaA,X),
	wewnetrzna(X,LalkaB).

% (c) 
% Dopisz predykat rozmiar_grupy/2, który wylicza ile matrioszek jest
% w grupie razem ze wskazaną lalką (albo na zewnątrz albo wewnątrz
% wskazanej lalki).
% Przykład:
% ?- rozmiar_grupy(swietlana, X).
% X = 4  % ludmila, swietlana, walentina, irina

dlugosc([],0).
dlugosc([_|Ogon],Dlug) :-
	dlugosc(Ogon,X),
	Dlug is X+1.

wewnetrzna1(X,Y,[X,Y]):-
	w(X,Y),!.

wewnetrzna1(LalkaA, LalkaB, L) :-
	w(LalkaA,X),
	wewnetrzna1(X,LalkaB,L1),
	sklej([LalkaA],L1,L).

rozmiar_grupy(Lalka, Rozmiar) :- 
	wewnetrzna1(Lalka,X, W),
	wewnetrzna1(Y,Lalka, W1),
	dlugosc(W,A1),
	dlugosc(W1,A2),
	Rozmiar is A1+A2.

ostatni([A],A).
ostatni([A|Reszta],X):-
	ostatni(Reszta,X).






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


