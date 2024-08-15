
% …jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

% …tiene(Nombre, QueTiene).
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).



%tiene(Jugador,unidad(Unidad,Cantidad))
%tiene(Jugador, recurso(Madera,Alimento,Oro))
%tiene(Jugador, edificio(Edificio,Cantidad))

% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).

% Punto 1
esUnAfano(Jugador,OtroJugador):-
    jugador(Jugador,Rating1,_),
    jugador(OtroJugador,Rating2,_),
    Rating1 - Rating2 > 500.

% Punto 2
esEfectivo(Tipo,OtroTipo):-
    esMilitar(Tipo,_,Categoria),
    esMilitar(OtroTipo,_,OtraCategoria),
    puedeGanar(Categoria,OtraCategoria).

esEfectivo(samurai,Tipo):-
    esMilitar(Tipo,_,unica).

%puedeGanar(CateriaGana,OtraCategoria)
puedeGanar(caballeria,arqueria).
puedeGanar(arqueria,infanteria).
puedeGanar(infanteria,piquero).
puedeGanar(piquero,caballeria).

esMilitar(Tipo,Costo,Categoria):- 
    militar(Tipo,Costo,Categoria).

% Punto 3
alarico(Jugador):-
    tiene(Jugador,_),
    tieneUnidadDe(infanteria,Jugador).

tieneUnidadDe(Categoria,Jugador):-
    tiene(Jugador,unidad(Tipo,_)),
    militar(Tipo,_,Categoria),
    forall(tiene(Jugador,unidad(Tipo,_)),militar(Tipo,_,Categoria)).

% Punto 4
leonidas(Jugador):-
    tiene(Jugador,_),
    tieneUnidadDe(piquero,Jugador).

% Punto 5
nomada(Jugador):-
    tiene(Jugador,_),
    not(tieneEdificio(Jugador,casa)).

tieneEdificio(Jugador,Edificio):-
    tiene(Jugador,unidad(Edificio,_)).

% Punto 6


















