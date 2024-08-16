
% pokemon(Pokemon,Tipo)
pokemon(pikachu,electrico).
pokemon(charizard,fuego).
pokemon(venusaur,planta).
pokemon(blastoise,agua).
pokemon(totodile,agua).
pokemon(snorlax,normal).
pokemon(rayquaza,dragon).
pokemon(rayquaza,volador).

% entrenador(Entrenador,Pikachu).
entrenador(ash,pikachu).
entrenador(ash,charizard).
entrenador(brock,snorlax).
entrenador(misty,blastoise).
entrenador(misty,venusaur).
entrenador(misty,arceus).

% Punto 1
multiple(Pokemon):-
    pokemon(Pokemon,Tipo),
    pokemon(Pokemon,OtroTipo),
    Tipo \= OtroTipo.

% Punto 2
legendario(Pokemon):-
    multiple(Pokemon),
    not(entrenador(_,Pokemon)).

% Punto 3
misterioso(Pokemon):-
    pokemon(Pokemon,Tipo),
    not((pokemon(OtroPokemon,Tipo),Pokemon\=OtroPokemon)).
misterioso(Pokemon):-
    pokemon(Pokemon,_),
    not(entrenador(_,Pokemon)).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% PARTE 2 %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

movimiento(pikachu,fisico(mordedura,95)).
movimiento(pikachu,especial(impactrueno,40,electrico)).

movimiento(charizard,especial(garraDragon,100,dragon)).
movimiento(charizard,fisico(mordedura,95)).

movimiento(blastoise,defensivo(proteccion,10)).
movimiento(blastoise,fisico(placaje,50)).

movimiento(arceus,especial(impactrueno,40,electrico)).
movimiento(arceus,especial(garraDragon,100,dragon)).
movimiento(arceus,defensivo(proteccion,10)).
movimiento(arceus,fisico(placaje,50)).
movimiento(arceus,defensivo(alivio,100)).

% Punto 1
danioDeAtaque(fisico(_,Potencia),Potencia).
danioDeAtaque(defensivo(_,_),0).
danioDeAtaque(especial(_,Potencia,Tipo),PotenciaAtaque):-
    esDeTipo(Tipo,Multiplicador),
    PotenciaAtaque is Potencia * Multiplicador.

esDeTipo(Tipo,1.5):-
    tipoBasico(Tipo).
esDeTipo(dragon,3).
esDeTipo(Tipo,1):-
    Tipo \= dragon,
    not(tipoBasico(Tipo)).

tipoBasico(fuego).
tipoBasico(agua).
tipoBasico(planta).
tipoBasico(normal).

% Punto 2
capacidadOfensiva(Pokemon,Capacidad):-
    esPokemon(Pokemon),
    findall(Danio,danioPokemon(Pokemon,Danio),Lista),
    sum_list(Lista,Capacidad).
    
danioPokemon(Pokemon,Danio):-
    movimiento(Pokemon,Movimiento),
    danioDeAtaque(Movimiento,Danio).

esPokemon(Pokemon):-
    pokemon(Pokemon,_).
esPokemon(Pokemon):-
    pokemon(_,Pokemon).

% Punto 3
persona(Entrenador):-
    entrenador(Entrenador,_).

picante(Entrenador):-
    persona(Entrenador),
    forall(entrenador(Entrenador,Pokemon),pokemonPicante(Pokemon)).

pokemonPicante(Pokemon):-
    capacidadOfensiva(Pokemon,Capacidad),
    Capacidad>200.
pokemonPicante(Pokemon):-
    misterioso(Pokemon).








