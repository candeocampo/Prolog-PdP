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
    forall((impactoEnRecompensa(OtroPirata,Evento,OtroMonto),OtroPirata \=Pirata),Monto >= OtroMonto).

% punto 3
pirataDesapercibido(Pirata,Evento):-
    tripulante(Pirata,Tripulacion),
    participoDeEvento(Tripulacion,Evento),
    not(impactoEnRecompensa(Pirata,Evento,_)).

% punto 4
recompensaTotal(Tripulacion,Total):-
    tripulante(_,Tripulacion),
    findall(RecompensaActual,(tripulante(Pirata,Tripulacion),recompensaActual(Pirata,RecompensaActual)),RecompensaTripulantes),
    sumlist(RecompensaTripulantes,Total).

recompensaActual(Pirata,RecompensaActual):- %relaciona un pirata con su recompensa actual, osea suma los montos
    tripulante(Pirata,_),
    findall(Recompensa,impactoEnRecompensa(Pirata,_,Recompensa),RecompensasEventos),
    sumlist(RecompensasEventos,RecompensaActual).

% punto 5
tripulacionTemible(Tripulacion):-
    tripulante(_,Tripulacion),
    forall(tripulante(_,Tripulacion),peligroso(Pirata)).

tripulacionTemible(Tripulacion):-
    recompensaTotal(Tripulacion,Total),
    Total > 500000000.

peligroso(Pirata):-
    recompensaActual(Pirata,RecompensaActual),
    RecompensaActual > 100000000.

% punto 6
%% Agregamos a nuestra base de conocimientos:
peligroso(Pirata):-
    comio(Pirata,Fruta),
    frutaPeligrosa(Fruta).

comio(luffy, paramecia(gomugomu)).
comio(luffy, paramecia(barabara)).
comio(law, paramecia(opeope)).
comio(chopper, zoan(hitohito, humano)).
comio(lucci, zoan(nekoneko, leopardo)).
comio(smoker, logia(mokumoku, humano)).

frutaPeligrosa(paramecia(opeope)).
frutaPeligrosa(zoan(_,Especie)):-
    especieFeroz(Especie).
frutaPeligrosa(logia,_).

especieFeroz(lobo).
especieFeroz(leopardo).
especieFeroz(anaconda).

%% 6.b
%% Queriamos saber en un predicado si un pirata es peligroso respecto a la fruta que comio,
%% por eso hicimos dos predicados nuevos llamados comio y frutaPeligrosa para analizar cada tipo de fruta.
%% frutaPeligrosa es polimorfimo que independienemente de la fruta nos diga si es peligrosa o no.
%% no necesita ser inversible frutaPeligrosa.

% punto 7
% Saber si una tripulación es de piratas de asfalto, que se cumple si ninguno de sus miembros puede nadar.

% el enunciado dice que los que comen frutan no pueden nadar.
tripulacionDeAsfalto(Tripulacion):-
    tripulante(_,Tripulacion),
    not((tripulante(Pirata,Tripulacion),
    puedaNadar(Pirata))). %esta trabajando en afirmativo, hay como dos negaciones.

puedeNadar(Pirata):-
    not(comio(Pirata,Fruta)).

deAsfalto(Tripulacion):-
    tripulante(_,Tripulacion),
    forall(tripulante(Pirata,Tripulacion),not(puedaNadar(Pirata))).


