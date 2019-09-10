
% dane

rodzina(
	osoba(jan, kowalski,data(5,kwiecien,1946),pracuje(tpsa,3000)),
	osoba(anna,kowalski,data(8,luty,1949),    pracuje(szkola,1500)), 
	[
	 osoba(maria,kowalski,data(20,maj,1973),     pracuje(argo_turist,4000)),
	 osoba(pawel,kowalski,data(15,listopad,1979),zasilek)]).
       
rodzina(
	osoba(krzysztof, malinowski, data(24,lipiec,1950), bezrobocie),
	osoba(klara, malinowski, data(9,styczen,1951), pracuje(kghm,8000)),
	[
	 osoba(monika, malinowski, data(19,wrzesien,1980), bezrobocie)]
	).

rodzina(
	osoba(marian, ogarnia, data(23,grudzien,1950), bezrobocie),
	osoba(maria, ogarnia, data(25,styczen,1951), pracuje(pzu,18000)),
	[
	 osoba(miko,ogarnia,data(20,maj,1973),     pracuje(agh,13000)),
	 osoba(zuza,ogarnia,data(15,listopad,1979),zasilek)]).

% zaleznosci

maz(X) :-
	rodzina(X,_,_).

zona(X) :-
	rodzina(_,X,_).

dziecko(X) :-
	rodzina(_,_,Dzieci),
	nalezy(X,Dzieci).

istnieje(Osoba) :-
	maz(Osoba)
	;
	zona(Osoba)
	;
	dziecko(Osoba).

data_urodzenia(osoba(_,_,Data,_),Data).

pensja(osoba(_,_,_,pracuje(_,P)),P).
pensja(osoba(_,_,_,zasilek),500).
pensja(osoba(_,_,_,bezrobocie),0).

zarobki([],0).
zarobki([Osoba|Lista],Suma) :-
	pensja(Osoba,S),
	zarobki(Lista,Reszta),
	Suma is S + Reszta.

% narzedzia
nalezy(X,[X|_]).
nalezy(X,[_|Yogon]) :-
	nalezy(X,Yogon).

pokazPensje(P):-
	istnieje(Osoba),
	pensja(Osoba, P).

dzieciUrodzoneW(X,Lista):-
	dziecko(osoba(_,_,data(_,_,X),_)),
	Lista=osoba(_,_,data(_,_,X),_).

zonaPracujacaToDobraZona(X):-
	zona(X),
	X=osoba(_,_,_,pracuje(_,_)).

staraZonaKtoraPracujeIMaloZarabiaToDobraZona(X):-
	zona(X),
	X=osoba(_,_,data(_,_,A),pracuje(_,B)),
	A<1950,
	B<3000.

