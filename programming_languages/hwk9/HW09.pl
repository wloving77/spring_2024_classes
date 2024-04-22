/* HW09

  In class on Monday (4/15) we did a walkthrough of a simple text-based
  adventure game in Prolog. This file contains a version similar to the one
  built in class.

  Your assignment is to add the following features to this prolog program:
    1.) Create a gate between the fork in the path and the mountaintop.
        The gate is a separate location; that is, the player must move
        from at(you,fork) to at(you,gate) and then to at(you,mountaintop).

    2.) To move forward through the gate the player must first unlock it
        with a key.

    3.) The key is somewhere in the maze. The player must find it and
        explicitly pick it up.

    4.) If the player tries to pass through the gate while still holding the
        key, he or she is killed by lightning. (To get the treasure, the
        player must first open the gate, then put down the key, and then
        pass through.)

    5.) Part of your implementation should be a general way for the player
        to pick things up, carry them, and put them down. Design your
        solution so that it would be easy to add additional objects for
        the player to pick up and put down.

    6.) Everytime report() is called, also print out what items the player
        is currently carrying. (or print out that they are carrying no items)

    7.) Add at least one more feature to the game not already specified above.
        It can be anything that you want, large or small. Describe what you
        added in your comments at the top of the file.

    8.) At the top of your file, include in your comments at least 2
        different complete interactions with your game (play it though a
        couple of different ways and copy and paste the results).
 */

/* Report Comments: 
 * 
 * New Feature: Added a sword to the path that lets you kill the ogre in the maze.
 * 
 * Possible Playthroughs:
 * 
 * Playthrough 1 (Win By Killing Ogre and Collecting Key).
      
      Moves: f -> p -> f -> l -> r -> f -> p -> l -> r -> d -> d -> f -> WIN
      Output:
            This is an adventure game. Legal moves are (l)eft, (r)ight, (f)orward, (p)ickup, or (d)rop. You are carrying no items.
            You are in a pleasant valley, with a trail ahead.
            Next move --
            f
            --f-------forward-----You are carrying no items.
            You are on a path, with ravines on both sides, you spy a blade sticking out of the grass.
            Next move --
            p
            --pickup-----You are currently carrying: [sword]
            You pick up a sword! Next move --
            f
            --f-------forward-----You are currently carrying: [sword]
            You are at a fork in the path.
            Next move --
            l
            --l-------left-----You are currently carrying: [sword]
            You are in a maze of twisty trails, all alike.
            Next move --
            r
            --r-------right-----You are currently carrying: [sword]
            You are in a maze of twisty trails, all alike.
            You meet a very angry ogre. Using your expert swordsmanship you slay the Ogre and survive the encounter! Next move --
            f
            --f-------forward-----You are currently carrying: [sword]
            You are in a maze of twisty trails, all alike, but a shiny key on the ground catches your eye
            Next move --
            p
            --pickup-----You are currently carrying: [sword, key]
            You pick up a key! Next move --
            l
            --l-------left-----You are currently carrying: [sword, key]
            You are at a fork in the path.
            Next move --
            r
            --r-------right-----You are currently carrying: [sword, key]
            You are at a gate to the mountaintop.
            You use your key to open it! Next move --
            d
            --drop-----You are currently carrying: [key]
            You drop a sword. You use your key to open it! Next move --
            d
            --drop-----You are carrying no items.
            You drop a key. The gate is already unlocked! Next move --
            f
            --f-------forward-----You are carrying no items.
            You are on the mountaintop.
            There is a treasure here. Congratulations, you win! Thanks for playing.
            true
 * 
 * Playthrough 2 (Death By Lightning Strike After Killing Ogre)
		
        Moves: f -> p -> f -> l -> r -> f -> p -> l -> r -> f -> DEATH
		Output:
            This is an adventure game. Legal moves are (l)eft, (r)ight, (f)orward, (p)ickup, or (d)rop. You are carrying no items.
            You are in a pleasant valley, with a trail ahead.
            Next move --
            f
            --f-------forward-----You are carrying no items.
            You are on a path, with ravines on both sides, you spy a blade sticking out of the grass.
            Next move --
            p
            --pickup-----You are currently carrying: [sword]
            You pick up a sword! Next move --
            f
            --f-------forward-----You are currently carrying: [sword]
            You are at a fork in the path.
            Next move --
            l
            --l-------left-----You are currently carrying: [sword]
            You are in a maze of twisty trails, all alike.
            Next move --
            r
            --r-------right-----You are currently carrying: [sword]
            You are in a maze of twisty trails, all alike.
            You meet a very angry ogre. Using your expert swordsmanship you slay the Ogre and survive the encounter! Next move --
            f
            --f-------forward-----You are currently carrying: [sword]
            You are in a maze of twisty trails, all alike, but a shiny key on the ground catches your eye
            Next move --
            p
            --pickup-----You are currently carrying: [sword, key]
            You pick up a key! Next move --
            l
            --l-------left-----You are currently carrying: [sword, key]
            You are at a fork in the path.
            Next move --
            r
            --r-------right-----You are currently carrying: [sword, key]
            You are at a gate to the mountaintop.
            You use your key to open it! Next move --
            f
            --f-------forward-----You are currently carrying: [sword, key]
            You are on the mountaintop.
            You carry the key through the gate and are struck by lightning! The key may not cross the threshold to the mountaintops.Thanks for playing.
            true
 * 
 * */


/*
  Introduction to the game -
  This is a little adventure game.  There are three
  entities: you, a treasure, and an ogre.  There are 
  six places: a valley, a path, a cliff, a fork, a maze, 
  and a mountaintop.  Your goal is to get the treasure
  without being killed first.
*/

/* Allow asserts and retracts for the predicate -at- */
:- dynamic at/2.
:- dynamic has/2.
:- dynamic connect/3. 


/*
  First, text descriptions of all the places in 
  the game.
*/
description(valley,
  'You are in a pleasant valley, with a trail ahead.').
description(path,
  'You are on a path, with ravines on both sides, you spy a blade sticking out of the grass.').
description(cliff,
  'You are teetering on the edge of a cliff').
description(fork,
  'You are at a fork in the path.').
description(maze(2),
  'You are in a maze of twisty trails, all alike, but a shiny key on the ground catches your eye').
description(maze(_),
  'You are in a maze of twisty trails, all alike.').
description(mountaintop,
  'You are on the mountaintop.').
description(gate, 
  'You are at a gate to the mountaintop.').

/*
  report prints the description of your current
  location.
*/
report :-
  at(you,X),
  description(X,Y),
  report_inventory,
  write(Y), nl.

/*
  These connect predicates establish the map.
  The meaning of connect(X,Dir,Y) is that if you
  are at X and you move in direction Dir, you
  get to Y.  Recognized directions are
  forward, right, and left.
*/
connect(valley,forward,path).
connect(path,right,cliff).
connect(path,left,cliff).
connect(path,forward,fork).
connect(fork,left,maze(0)).
connect(fork,right,gate).
connect(gate,forward,mountaintop).
connect(gate,left,fork).
connect(gate,right,cliff).
connect(maze(0),left,maze(1)).
connect(maze(0),right,maze(3)).
connect(maze(1),left,maze(0)).
connect(maze(1),right,maze(2)).
connect(maze(2),left,fork).
connect(maze(2),right,maze(0)).
connect(maze(3),left,maze(0)).
connect(maze(3),forward, maze(2)).
connect(maze(3),right,maze(3)).



/*Inventory Reporting*/

report_inventory :-
    findall(Item, has(you, Item), Items),
    (   Items = [] -> write('You are carrying no items.'), nl
    ;   write('You are currently carrying: '), write(Items), nl).

/*
  move(Dir) moves you in direction Dir, then
  prints the description of your new location.
*/

move(pickup) :-
    write('--'),write(pickup), write('-----'),
    at(you,Loc),
    at(Item,Loc),
    pickup(Item).

move(drop) :- 
    write('--'),write(drop), write('-----'),
    has(you,Item),
    drop(Item).

move(p) :- move(pickup).
move(d) :- move(drop).

move(Dir) :-
  write('--'),write(Dir),write('-----'),
  at(you,Loc),
  connect(Loc,Dir,Next),
  retract(at(you,Loc)),
  assert(at(you,Next)),
  report,
  !.

move(f) :- move(forward).
move(l) :- move(left).
move(r) :- move(right).


/*
  But if the argument was not a legal direction,
  print an error message and don't move.
*/
move(_) :-
  write('That is not a legal move.\n'),
  report.

/*Logic for picking up and dropping items*/

pickup(Item) :-
    at(Item, Loc),
    at(you,Loc),
	Item \= you,
    retract(at(Item, Loc)),
    assert(has(you, Item)),
    report_inventory,
    write('You pick up a '), write(Item), write('!\n').

drop(Item) :-
    at(you, Loc),
    retract(has(you, Item)),
    assert(at(Item, Loc)),
    report_inventory,
    write('You drop a '), write(Item), write('.\n').

/*
  If you and the ogre are at the same place, it 
  kills you, unless you picked up the sword.
*/

ogre :-
    at(ogre,Loc),
    at(you,Loc),
    has(you,sword),
    retract(at(ogre, Loc)),
    write('You meet a very angry ogre. \n'),
    write('Using your expert swordsmanship you slay the Ogre and survive the encounter!'),
    !.

ogre :-
  at(ogre,Loc),
  at(you,Loc),
  write('You meet a very angry ogre.\n'),
  write('There is no escape for you. Ahhh!\n'),
  retract(at(you,Loc)),
  assert(at(you,done)),
  !.
/*
  But if you and the ogre are not in the same place,
  nothing happens.
*/
ogre.


/*Logic for handling lightning + key*/

lightning :-
    at(you,mountaintop),
    has(you,key),
    write('You carry the key through the gate and are struck by lightning! The key may not cross the threshold to the mountaintops.'),
    retract(at(you,mountaintop)),
    assert(at(you,done)),
    !.

lightning.

/*
  If you and the treasure are at the same place, you
  win.
*/


treasure :-
  at(treasure,Loc),
  at(you,Loc),
  write('There is a treasure here.\n'),
  write('Congratulations, you win!\n'),
  retract(at(you,Loc)),
  assert(at(you,done)),
  !.
/*
  But if you and the treasure are not in the same
  place, nothing happens.
*/
treasure.

/*
  If you are at the cliff, you fall off and die.
*/
cliff :-
  at(you,cliff),
  write('You fall off and die.\n'),
  retract(at(you,cliff)),
  assert(at(you,done)),
  !.
/*
  But if you are not at the cliff nothing happens.
*/
cliff.

/* Added Mountaintop Logic */

gate :-
    at(you,gate),
    has(you,key),
    assert(connect(gate, forward, mountaintop)),
    write('You use your key to open it!').


gate :-
    at(key,gate),
    at(you,gate),
    assert(connect(gate, forward, mountaintop)),
    write('The gate is already unlocked!').

gate :-
    at(you, gate),
    retract(connect(gate,forward, mountaintop)),
    write('You lack the key to open it, to move forward you must find it.').

gate.

/*
  Main loop.  Stop if player won or lost.
*/
main :- 
  at(you,done),
  write('Thanks for playing.\n'),
  !.
/*
  Main loop.  Not done, so get a move from the user
  and make it.  Then run all our special behaviors.  
  Then repeat.
*/
main :-
  write('\nNext move -- '),
  read(Move),
  call(move(Move)),
  ogre,
  lightning,
  treasure,
  cliff,
  gate,
  main.

/*
  This is the starting point for the game.  We
  assert the initial conditions, print an initial
  report, then start the main loop.
*/
    
go :-
  retractall(at(_,_)), % clean up from previous runs
  retractall(has(_,_)),
  assert(at(you,valley)),
  assert(at(key,maze(2))),
  assert(at(sword, path)),
  assert(at(ogre, maze(3))),
  assert(at(treasure, mountaintop)),
  write('This is an adventure game. \n'),
  write('Legal moves are (l)eft, (r)ight, (f)orward, (p)ickup, or (d)rop.\n'),
  report,
  main.


/*
 * To get started, use the query:
 * go. 
 */
