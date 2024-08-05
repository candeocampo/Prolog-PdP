jugador(ana,romanos,[herreria,forja,emplumado,laminas]).
jugador(beto,incas,[herreria,forja,fundicion]).
jugador(carola,romanos,[herreria,fundicion]).
jugador(dimitri,romanos,[herreria,fundicion]).


cantidadDeJugadores(Civilizacion,CantidadJugadores):-
    findall(Jugador,jugador(Jugador,Civilizacion,_),Jugadores),
    length(Jugadores, CantidadJugadores).
  
civilizacionPopular(Civilizacion):-
    jugador(_,Civilizacion,_),
    cantidadDeJugadores(Civilizacion,CantidadJugadores),
    CantidadJugadores > 1 .


tieneTecnologiasBasicas(Jugador) :-
    jugador(Jugador, _, Tecnologias),
    member(herreria, Tecnologias),
    member(forja, Tecnologias).

% Predicado para verificar si un jugador tiene la tecnología de fundición
tieneFundicion(Jugador) :-
    jugador(Jugador, _, Tecnologias),
    member(fundicion, Tecnologias).

% Predicado para verificar si un jugador es de la civilización romana
esRomano(Jugador) :-
    jugador(Jugador, romanos, _).

% Predicado principal para determinar si un jugador es experto en metales
expertoEnMetales(Jugador) :-
    tieneTecnologiasBasicas(Jugador).
expertoEnMetales(Jugador):-
    jugador(Jugador,romanos,_).




