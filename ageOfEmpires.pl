
% …jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

% …tiene(Nombre, QueTiene).
%..         unidad(samurai,Cuantas).
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).

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
    tiene(Jugador,edificio(Edificio,_)).

% Punto 6
% Interpreto como que se quiere saber costo(Madera, Alimento, Oro)
cuantoCuesta(Tipo,Costo):-
    esMilitar(Tipo,Costo,_).
cuantoCuesta(Tipo,Costo):-
    esEdificio(Tipo,Costo).
esEdificio(Tipo,Costo):-
    edificio(Tipo,Costo).

esAldeano(Tipo,Produccion):-
    aldeano(Tipo,Produccion).

cuantoCuesta(Tipo,costo(0,50,0)):-
    esAldeano(Tipo,_).
cuantoCuesta(Tipo,costo(100,0,50)):-
    esCarretaOUna(Tipo).

esCarretaOUna(carreta).
esCarretaOUna(urnasMercantes).

% Punto 7
produccion(Tipo,ProduccionMin):-
    esAldeano(Tipo,ProduccionMin).
produccion(Tipo,produce(0,0,32)):-
    esCarretaOUna(Tipo).
produccion(Tipo,produce(0,0,Oro)):-
    esMilitar(Tipo,_,_),
    evaluarOro(Tipo,Oro).

evaluarOro(keshik,10).
evaluarOro(_,0).

% Punto 8
produccionTotal(Jugador,Recurso,ProduccionTotal):-
    tiene(Jugador,_),
    recursos(Recurso),
    findall(Produccion,loProduce(Jugador,Recurso,Produccion),Lista),
    sum_list(Lista,ProduccionTotal).

loProduce(Jugador,Recurso,Produccion):-
    tiene(Jugador,unidad(Tipo,CuantasTiene)),
    produccion(Tipo,ProduccionTotal),
    produccionDelRecurso(Recurso,ProduccionTotal,ProduccionRecurso),
    Produccion is ProduccionRecurso * CuantasTiene.

produccionDelRecurso(madera,produccion(Madera,_,_),Madera).
produccionDelRecurso(alimento,produccion(_,Alimento,_),Alimento).
produccionDelRecurso(oro,produccion(_,_,Oro),Oro).

recursos(oro).
recursos(madera).
recursos(alimento).

% Punto 10
avanzaA(Jugador,Edad):-
    jugador(Jugador,_,_),
    puedeAvanzar(Jugador,Edad).
avanzaA(_,edadMedia).

puedeAvanzar(Jugador,edadFeudal):-
    cumpleAlimento(Jugador,500),
    tieneEdificio(Jugador,casa).
    
puedeAvanzar(Jugador,edadCastillos):-
    cumpleAlimento(Jugador,800),
    cumpleOro(Jugador,200),
    ademasTiene(Edificio),
    tieneEdificio(Jugador,Edificio).

puedeAvanzar(Jugador,edadImperial):-
    cumpleAlimento(Jugador,1000),
    cumpleOro(Jugador,800),
    edificioImperial(Edificioimperial),
    tieneEdificio(Jugador,Edificioimperial).

cumpleAlimento(Jugador,Cantidad):-
    recursosPersona(Jugador,_,Alimento,_),
    Cantidad >= Alimento.
cumpleOro(Jugador,Cantidad):-
    recursosPersona(Jugador,_,_,Oro),
    Cantidad >= Oro.

recursosPersona(Jugador,Madera,Alimento,Oro):-
    tiene(Jugador,recurso(Madera,Alimento,Oro)).

ademasTiene(herreria).
ademasTiene(establo).
ademasTiene(galeriaDeTiro).

edificioImperial(universidad).
edificioImperial(castillo).