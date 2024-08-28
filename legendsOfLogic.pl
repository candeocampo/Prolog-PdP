%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASE DE CONOCIMIENTOS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% pokemon(Pokemon,Tipo)
pokemon(pikachu,electrico).
pokemon(charizard,fuego).
pokemon(venusaur,planta).
pokemon(blastoise,agua).
pokemon(totodile,agua).
pokemon(snorlax,normal).
pokemon(rayquaza,dragon).
pokemon(rayquaza,volador).

% entrena(Entrenador,Pokemon)
tiene(ash,pikachu).
tiene(ash,charizard).
tiene(bock,snorlax).
tiene(misty,blastoise).
tiene(misty,venusaur).
tiene(misty,arceus).

% Punto 1
esDeTipoMultiple(Pokemon):-
    pokemon(Pokemon,Tipo),
    pokemon(Pokemon,OtroTipo),
    Tipo \= OtroTipo.

% Punto 2
esLegendario(Pokemon):-
    % pokemon(Pokemon,_), % no hace falta ligarlo pues el siguiente predicado ya es inversible.
    esDeTipoMultiple(Pokemon),
    not(tiene(_,Pokemon)).

% Punto 3
misterioso(Pokemon):-
    pokemon(Pokemon,Tipo),
    not((pokemon(OtroPokemon,Tipo),Pokemon \= OtroPokemon)).
    %forall((pokemon(OtroPokemon,OtroTipo),Pokemon \= OtroPokemon),Tipo \= OtroTipo).
    % no es conviene utilizar el forall acá pues se usa cuando deseas comprobar que todos los elementos de un conjunto cumplen una condición. 
misterioso(Pokemon):-
    pokemon(Pokemon,_),
    not(tiene(_,Pokemon)).

%% PARTE 2: MOVIMIENTOS 
% fisico(nombre, potencia).
% especial(nombre, potencia, tipo).
% defensivo(nombre, porcentajeReduccion).

%movimiento(Pokemon,movimiento(Nombre,Potencia))

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
% danioAtaque(Ataque,Danio).
danioAtaque(fisico(_,Potencia),Potencia).
danioAtaque(defensivo(_,_),0).
danioAtaque(especial(_,Potencia,Tipo),Danio):-
    segunTipo(Tipo,Multiplicador),
    Danio is Potencia * Multiplicador.

segunTipo(Tipo, 1.5):-
    tipoBasico(Tipo).

segunTipo(dragon, 3).
segunTipo(Tipo, 1):-
    Tipo \= dragon,
    not(tipoBasico(Tipo)).

tipoBasico(fuego).
tipoBasico(agua).
tipoBasico(planta).
tipoBasico(normal).

% Punto 2
capacidadOfensiva(Pokemon,Capacidad):-
    esPokemon(Pokemon),
    findall(Danio,(movimiento(Pokemon,Ataque),danioAtaque(Ataque,Danio)),Lista),
    sumlist(Lista,Capacidad).

esPokemon(Pokemon):-
    pokemon(Pokemon,_).
esPokemon(Pokemon):-
    tiene(_,Pokemon).

% Punto 3
esPicante(Entrenador):-
    tiene(Entrenador,_), % acá no va pokemon pq no nos interesa ligarla xd
    forall(tiene(Entrenador,Pokemon),pokemonPicante(Pokemon)).

pokemonPicante(Pokemon):-
    capacidadOfensiva(Pokemon,Capacidad),
    Capacidad > 200.

pokemonPicante(Pokemon):-
    misterioso(Pokemon).













