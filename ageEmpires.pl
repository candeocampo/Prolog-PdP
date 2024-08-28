
% jugador(Nombre, Rating, Civilizacion).
jugador(juli,2200,jemeres).
jugador(aleP,1600,mongoles).
jugador(feli,500000,persas).
jugador(alec,1723,otomanos).
jugador(ger,1729,ramanujanos).
jugador(juan,1515,britones).
jugador(marti,1342,argentinos).

% tiene(Nombre,QueTiene)
tiene(aleP, unidad(samunari,199)).
tiene(aleP, unidad(espadachin,10)).
tiene(aleP, unidad(granjero,10)).
tiene(aleP, recurso(800,300,100)).
tiene(aleP, edificio(casa,40)).
tiene(aleP, edificio(castillo,1)).
tiene(juan, unidad(carreta,10)).

% unidad(TipoUnidad,CantidadUnidad)
% recursos(Madera,Alimento,Oro)
% edificios(TipoEdificio,CantidadEdificio)

% LAS UNIDADES PUEDEN SER MILITARES O ALDEANOS
% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0,60,20),infanteria).
militar(arquero, costo(25,0,45),arqueria).
militar(mangudai, costo(55,0,65),caballeria).
militar(samurai, costo(0,60,30),unica).
militar(keshik, costo(0,80,50),unica).
militar(tarcanos, costo(0,60,60),unica).
militar(alabardero, costo(25,35,0),piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23,0,0)).
aldeano(granjero, produce(0,32,0)).
aldeano(minero, produce(0,0,23)).
aldeano(cazador, produce(0,25,0)).
aldeano(pescador, produce(0,23,0)).
aldeano(alquimista, produce(0,0,25)).

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30,0,0)).
edificio(granja, costo(0,60,0)).
edificio(herreria, costo(175,0,0)).
edificio(castillo, costo(650,0,300)).
edificio(maravillaMartinez, costo(10000,10000,10000)).

% Punto 1
esUnAfano(Jugador,OtroJugador):-
    jugador(Jugador,Rating1,_),
    jugador(OtroJugador,Rating2,_),
    DiferenciaRating is Rating1 - Rating2,
    DiferenciaRating > 500.

% Punto 2
esEfectivo(Unidad,OtraUnidad):-
    esMilitar(Unidad,_,Categoria),
    esMilitar(OtraUnidad,_,OtraCategoria),
    puedeGanar(Categoria,OtraCategoria).
esEfectivo(samurai,Unidad):-
    esMilitar(Unidad,_,unica).

puedeGanar(caballeria,arqueria).
puedeGanar(arqueria,infanteria).
puedeGanar(infanteria,piquero).
puedeGanar(piquero,caballeria).

esMilitar(Tipo,Costo,Categoria):-
    militar(Tipo,Costo,Categoria).

% Punto 3
alarico(Jugador):-
    tiene(Jugador,_),
    tieneUnidad(Jugador,infanteria).
    % ponerlo asi está bien pero podriamos abstraer: esMilitar(Tipo,_,infanteria).

tieneUnidad(Jugador,Categoria):-
    tiene(Jugador,unidad(Tipo,_)),
    militar(Tipo,_,Categoria), % va para ligar la variable sino no es inversible.
    forall(tiene(Jugador,unidad(Tipo,_)),militar(Tipo,_,Categoria)).

% Punto 4
leonidas(Jugador):-
    tiene(Jugador,_),
    tieneUnidad(Jugador,piquero).

% Punto 5
nomada(Jugador):-
    tiene(Jugador,_),
    not(tieneEdificio(Jugador,casa)).

tieneEdificio(Jugador,Edificio):-
    tiene(Jugador,edificio(Edificio,_)).

% Punto 6
cuantoCuesta(Tipo,Costo):-
    esMilitar(Tipo,Costo,_).
cuantoCuesta(Tipo,Costo):-
    esEdificio(Tipo,Costo).
cuantoCuesta(Tipo,(0,50,0)):-
    esAldeano(Tipo,_).
cuantoCuesta(Tipo,(100,0,50)):-
    esCarreraOUrna(Tipo).

esEdificio(Tipo,Costo):-
    edificio(Tipo,Costo).

esAldeano(Tipo,Produce):-
    aldeano(Tipo,Produce).

esCarreraOUrna(carreta).
esCarreraOUrna(urnaMercante).

% Punto 7
produccion(Tipo,ProduccionXMin):-
    aldeano(Tipo,ProduccionXMin).
produccion(Tipo,(0,0,32)):-
    esCarreraOUrna(Tipo).
produccion(Tipo,ProduccionXMin):-
    esMilitar(Tipo,_,_),
    costoOro(Tipo,ProduccionXMin).

costoOro(keshik,(0,0,10)). % si es keshik
costoOro(_,(0,0,0)). % si no es keshik

% Punto 8
produccionTotal(Jugador,Recurso,ProduccionTotal):-
    tiene(Jugador,_),
    recurso(Recurso),
    findall(Produccion,produce(Jugador,Recurso,Produccion),Lista),
    sumlist(Lista,ProduccionTotal).

produce(Jugador,Recurso,Produccion):-
    tiene(Jugador,unidad(Tipo,CuantasTiene)),
    produccion(Tipo,ProduccionXMin),
    produccionRecurso(Recurso,ProduccionXMin,ProduccionRecurso), % acá toma la produccion del recurso en especifico
    Produccion is ProduccionRecurso * CuantasTiene.

% produccionRecurso (Recurso,ProduccionQueTiene,ProduccionRecurso)
produccionRecurso(madera,(Madera,_,_),Madera).
produccionRecurso(alimento,(_,Alimento,_),Alimento).
produccionRecurso(oro,(_,_,Oro),Oro).

recurso(oro).
recurso(madera).
recurso(alimento).
























