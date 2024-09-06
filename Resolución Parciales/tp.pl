
% Punto 1

% jugador(Persona, Civilizacion)
jugador(ana,romanos).
jugador(beto,incas).
jugador(carola,romanos).
jugador(dimitri,romanos).


% tecnologia(Jugador,Tecnologias).
tecnologia(ana,[herreria,forja, emplumado, laminas]).
tecnologia(beto,[herreria,forja, fundicion]).
tecnologia(carola,[herreria]).
tecnologia(dimitri,[herreria,fundicion]).

% Punto 2
expertoEnMetales(Jugador):-
    tecnologia(Jugador,Tecnologias),
    armasDesarrolladas(Tecnologias),
    yBien(Jugador).

armasDesarrolladas(Tecnologias):-
    member(herreria,Tecnologias),
    member(forja, Tecnologias).
    
yBien(Jugador):-
    jugador(Jugador,romanos).
yBien(Jugador):-
    tecnologia(Jugador,Tecnologias),
    member(fundicion,Tecnologias).

% Punto 3
civilizacionPopular(Civilizacion):-
    jugador(Jugador,Civilizacion),
    jugador(OtroJugador,Civilizacion),
    Jugador \= OtroJugador.

% Punto 4
alcanceGlobal(TecnologiaBuscada):-
    tieneTecnologia(_,TecnologiaBuscada),
    forall(jugador(Jugador, _), tieneTecnologia(Jugador, TecnologiaBuscada)).
    
tieneTecnologia(Jugador,BuscarTecnologia):-
    tecnologia(Jugador,Tecnologias),
    member(BuscarTecnologia,Tecnologias).

% Punto 5   
desarrolloTecnologia(Civilizacion,Tecnologia):-
    jugador(_,Civilizacion,Tecnologias),
    member(Tecnologia,Tecnologias).



