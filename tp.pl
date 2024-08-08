
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

% Punto 1
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

% Punto 2
civilizacionPopular(Civilizacion):-
    jugador(Jugador,Civilizacion),
    jugador(OtroJugador,Civilizacion),
    Jugador \= OtroJugador.

% Punto 3
alcanceGlobal(Tegnologia)






