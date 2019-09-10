fibo(0,0).
fibo(1,1).
fibo(Number,Result) :-
        Number > 1,
        NewNumber is  Number-1,
	NewNumber1 is  Number-2,
        fibo(NewNumber,NewResult),
	fibo(NewNumber1,NewResult1),
        Result  is  NewResult+NewResult1.
