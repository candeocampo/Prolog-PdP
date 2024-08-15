%%%%%%%%%%%%%%%%%%%%%%%%%%% Pokemon %%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% Parte 1: Pokedex

% tipo(Pokemon, Tipo).
tipo(pikachu, electrico).
tipo(charizard, fuego).
tipo(venusaur, planta).
tipo(blastoise, agua).
tipo(totodile, agua).
tipo(snorlax, normal).
tipo(rayquaza, dragon).
tipo(rayquaza, volador).

% tiene(Entrenador, Pokemon).
tiene(ash, pikachu).
tiene(ash, charizard).
tiene(brock, snorlax).
tiene(misty, blastoise).
tiene(misty, venusaur).
tiene(misty, arceus).

pokemon(Pokemon):-
    tipo(Pokemon, _).

pokemon(Pokemon):-
    tiene(_, Pokemon).

entrenador(Persona):-
    tiene(Persona, _).

% Punto 1

esTipoMultiple(Pokemon):-
    tipo(Pokemon, T1),
    tipo(Pokemon, T2),
    T1 \= T2.

% Punto 2

esLegendario(Pokemon):-
    esTipoMultiple(Pokemon),
    not(tiene(_, Pokemon)).

% Punto 3

esMisterioso(Pokemon):-
    tipo(Pokemon, Tipo),
    not((tipo(Otro, Tipo), Otro \= Pokemon)).

esMisterioso(Pokemon):-
    pokemon(Pokemon),
    not(tiene(_, Pokemon)).

%%%%%%%%%%%%%%%%%%%%%%% Parte 2: Movimientos

% fisico(nombre, potencia).
% especial(nombre, potencia, tipo).
% defensivo(nombre, porcentajeReduccion).

% Pikachu 
movimiento(pikachu, fisico(mordedura, 95)).
movimiento(pikachu, especial(impactrueno, 40, electrico)).

% Charizard
movimiento(charizard, especial(garraDragon, 100, dragon)).
movimiento(charizard, fisico(mordedura, 95)).

% Blastoise
movimiento(blastoise, defensivo(proteccion, 10)).
movimiento(blastoise, fisico(placaje, 50)).

% Arceus
movimiento(arceus, especial(impactrueno, 40, electrico)).
movimiento(arceus, especial(garraDragon, 100, dragon)).
movimiento(arceus, defensivo(proteccion, 10)).
movimiento(arceus, fisico(placaje, 50)).
movimiento(arceus, defensivo(alivio, 100)).

% Punto 1

% danioAtaque(Movimiento, Daño).
danioAtaque(fisico(_, Potencia), Potencia).
danioAtaque(defensivo(_, _), 0).
danioAtaque(especial(_, Potencia, Tipo), Danio):-
    multiplicadorTipo(Tipo, Multiplicador),
    Danio is Potencia * Multiplicador. 

multiplicadorTipo(Tipo, 1.5):-
    tipoBasico(Tipo).

multiplicadorTipo(dragon, 3).
multiplicadorTipo(Tipo, 1):-
    Tipo \= dragon, 
    not(tipoBasico(Tipo)).

tipoBasico(fuego).
tipoBasico(agua).
tipoBasico(planta).
tipoBasico(normal).

% Punto 2

capOfensiva(Pokemon, Cap):-
    pokemon(Pokemon),
    findall(Danio, danioAtaquePokemon(Pokemon, Danio), Danios),
    sumlist(Danios, Cap).

danioAtaquePokemon(Pokemon, Danio):-
    movimiento(Pokemon, Mov), 
    danioAtaque(Mov, Danio).

% Punto 3

entrenadorPicante(Entrenador):-
    entrenador(Entrenador),
    forall(tiene(Entrenador, Pokemon), pokemonPicante(Pokemon)).

pokemonPicante(Pokemon):-
    capOfensiva(Pokemon, Cap),
    Cap > 200.

pokemonPicante(Pokemon):-
    esMisterioso(Pokemon).