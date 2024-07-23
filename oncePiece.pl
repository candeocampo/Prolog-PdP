%% BASE DE CONOCIMIENTOS

% Relaciona Pirata con Tripulacion
tripulante(luffy, sombreroDePaja).
tripulante(zoro, sombreroDePaja).
tripulante(nami, sombreroDePaja).
tripulante(ussop, sombreroDePaja).
tripulante(sanji, sombreroDePaja).
tripulante(chopper, sombreroDePaja).

tripulante(law, heart).
tripulante(bepo, heart).

tripulante(arlong, piratasDeArlong).
tripulante(hatchan, piratasDeArlong).

% Relaciona Pirata, Evento y Monto
impactoEnRecompensa(luffy, arlongPark, 30000000).
impactoEnRecompensa(luffy, baroqueWorks, 70000000).
impactoEnRecompensa(luffy, eniesLobby, 200000000).
impactoEnRecompensa(luffy, marineford, 100000000).
impactoEnRecompensa(luffy, dressrosa, 100000000).

impactoEnRecompensa(zoro, baroqueWorks, 60000000).
impactoEnRecompensa(zoro, eniesLobby, 60000000).
impactoEnRecompensa(zoro, dressrosa, 200000000).

impactoEnRecompensa(nami, eniesLobby, 16000000).
impactoEnRecompensa(nami, dressrosa, 50000000).

impactoEnRecompensa(ussop, eniesLobby, 30000000).
impactoEnRecompensa(ussop, dressrosa, 170000000).

impactoEnRecompensa(sanji, eniesLobby, 77000000).
impactoEnRecompensa(sanji, dressrosa, 100000000).

impactoEnRecompensa(chopper, eniesLobby, 50).
impactoEnRecompensa(chopper, dressrosa, 100).

impactoEnRecompensa(law, sabaody, 200000000).
impactoEnRecompensa(law, descorazonamientoMasivo,240000000).
impactoEnRecompensa(law, dressrosa, 60000000).

impactoEnRecompensa(bepo, sabaody,500).

impactoEnRecompensa(arlong, llegadaAEastBlue, 20000000).
impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).

% punto 1
participaron(Tripulacion,OtraTripulacion,Evento):-
    participoDeEvento(Tripulacion,Evento),
    participoDeEvento(OtraTripulacion,Evento),
    Tripulacion \= OtraTripulacion.

participoDeEvento(Tripulacion,Evento):-
    impactoEnRecompensa(Pirata,Evento,_),
    tripulante(Pirata,Tripulacion).

% otra variante larga, que no está bueno porque es mejor abstraer sería:
% participaronDeEvento(Tripulacion,OtraTripulacion,Evento):-
%    impactoEnRecompensa(Tripulacion,Evento,_),
%    tripulante(Pirata,Tripulacion),
%    impactoEnRecompensa(OtraTripulacion,Evento,_),
%    tripulante(OtroPirata,OtraTripulacion),
%    Tripulacion \= OtraTripulacion.

% punto 2
% Saber quién fue el pirata que más se destacó en un evento, 
% en base al impacto que haya tenido su recompensa.
destacoEnEvento(Pirata,Evento):-
    impactoEnRecompensa(Pirata,Evento,Monto),
    not((impactoEnRecompensa(OtroPirata,Evento,OtroMonto),
    Pirata \= OtroPirata,
    Monto =< OtroMonto)).

% Podiamos hacerlo con forall.
pirataDestacado(Pirata,Evento):-
    impactoEnRecompensa(Pirata,Evento,Monto),
    forall((impactoEnRecompensa(_,Evento,OtroMonto),OtroPirata \=Pirata),Monto >= OtroMonto).

% punto 3





















