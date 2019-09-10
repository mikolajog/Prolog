%maze.pl
% A program that finds a path through a maze

solve_maze :- path([start],Solution), write(Solution).

path([finish|RestOfPath],[finish|RestOfPath]).
path([CurrentLocation|RestOfPath],Solution):-
	connected_to(CurrentLocation,NextLocation),
	\+ member(NextLocation,RestOfPath),
	path([NextLocation,CurrentLocation|RestOfPath],Solution).

connected_to(Location1,Location2):- connect(Location1,Location2).
connected_to(Location1,Location2):- connect(Location2,Location1).

connect(start, 2).
connect(2,8). 
connect(2,3). 
connect(8,9). 
connect(3,9). 
connect(3,4). 
connect(4,10). 
connect(10,16). 
connect(16,22). 
connect(22,21). 
connect(21,15). 
connect(15,14). 
connect(14,13). 
connect(13,7). 
connect(7,1). 
connect(14,20). 
connect(20,26). 
connect(26,27). 
connect(27,28). 
connect(28,29). 
connect(29,23). 
connect(23,17). 
connect(17,11). 
connect(11,5). 
connect(5,6). 
connect(28,34). 
connect(34,35).
connect(35,36). 
connect(36,30). 
connect(30,24). 
connect(24,18). 
connect(18,12). 
connect(34,33). 
connect(33,32). 
connect(32,31). 
connect(31,25).
connect(25,19). 
connect(32,finish). 
connect(34, 41).
connect(41, finish).

 
 

