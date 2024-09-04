%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASE DE CONOCIMIENTOS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% persona(Nombre,Edad).
persona(laura,24).
persona(federico,31).
persona(maria,23).
persona(jacobo,45).
persona(enrique,49).
persona(andrea,38).
persona(gabriela,4).
persona(gonzalo,23).
persona(gonzalo,23).
persona(alejo,20).
persona(andres,11).
persona(ricado,39).
persona(ana,7).
persona(juana,15).

% quiere(Quién,Quiere).
quiere(andres,juguete(maxSteel, 150)).
quiere(andres,bloques([piezaT, piezaL, cubo, piezaChata])).
quiere(maria, bloques([piezaT, piezaT])).
quiere(alejo, bloques([piezaT])).
quiere(juana, juguete(barbie, 175)).
quiere(federico, abrazo).
quiere(enrique, abrazo).
quiere(gabriela, juguete(gabeneitor2000, 5000)).
quiere(laura, abrazo).
quiere(gonzalo, abrazo).

% presupuesto(Quién,Presupuesto).
presupuesto(jacobo,20).
presupuesto(enrique,2311).
presupuesto(ricardo,154).
presupuesto(andrea,100).
presupuesto(laura,2000).

% accion(Quién, Hizo).
accion(andres, travesura(3)).
accion(andres, ayudar(ana)).
accion(ana, golpear(andres)).
accion(ana, travesura(1)).
accion(maria, ayudar(federico)).
accion(maria, favor(juana)).
accion(juana, favor(maria)).
accion(federico, golpear(enrique)).
accion(gonzalo, golpear(alejo)).
accion(alejo, travesura(4)).

% padre(Padre o Madre, Hijo o Hija).
padre(jacobo,ana).
padre(jacobo,juana).
padre(enrique,federico).
padre(ricardo,maria).
padre(andrea,andres).
padre(laura,gabriela).

recibeRegalo(Persona):-
    creeEnPapaNoel(Persona).

creeEnPapaNoel(Persona):-
    persona(Persona,Edad),
    Edad < 13.
creeEnPapaNoel(federico).

% Punto 1
buenaAccion(favor(_)).
buenaAccion(ayudar(_)).
buenaAccion(travesura(NivelTravesura)):-
    NivelTravesura =< 3.

% Punto 2
sePortoBien(Persona):-
    accion(Persona,_),
    forall(accion(Persona,Accion),buenaAccion(Accion)).

% Punto 3
malcriador(Padre):-
    padre(Padre,_),
    forall(padre(Padre,Hijo),malcriado(Hijo)).

malcriado(Hijo):-
    not((accion(Hijo,Accion),buenaAccion(Accion))).
malcriado(Hijo):-
    not(creeEnPapaNoel(Hijo)).

% Punto 4
puedeCostear(Padre,Hijo):-
    padre(Padre,Hijo),
    presupuesto(Padre,Presupuesto),
    puedePagar(Hijo,PrecioRegalos),
    Presupuesto >= PrecioRegalos.

precio(juguete(_,Precio),Precio).
precio(bloques(Piezas),Precio):-
    length(Piezas,CantidadPiezas),
    Precio is CantidadPiezas * 3.
precio(abrazo,0).

puedePagar(Hijo,PrecioRegalos):-
    findall(Precio,(quiere(Hijo,Regalo),precio(Regalo,Precio)),ListaPrecios),
    sum_list(ListaPrecios,PrecioRegalos).

% Punto 5
regaloCandidatoPara(Persona, Regalo):-
    sePortoBien(Persona),
    quiere(Persona, Regalo),
    padre(Padre, Persona),
    puedeComprar(Padre, Regalo),
    creeEnPapaNoel(Persona).

puedeComprar(Padre,Regalo):-
    presupuesto(Padre,Presupuesto),
    precio(Regalo,PrecioRegalo),
    Presupuesto >= PrecioRegalo.

% Punto 6
regalosQueRecibe(Persona,Regalos):-
    padre(Padre,Persona),
    puedeCostear(Padre,Persona),
    findall(Regalo,quiere(Persona,Regalo),Regalos).

regalosQueRecibe(Persona,Regalos):-
    padre(Padre,Persona),
    not(puedeCostear(Padre,Persona)),
    recibeRegaloAlternativo(Persona,Regalos).

recibeRegaloAlternativo(Persona,[media(blanca),media(negra)]):-
    sePortoBien(Persona).

regaloAltenativo(Persona,[carbon]):-
    accion(Persona,Accion1),
    accion(Persona,Accion2),
    not(buenaAccion(Accion1)),
    not(buenaAccion(Accion2)).

% podia haber usado findall:
% findall(Accion,(accion(Persona,Accion),not(buenaAccion(Accion)),Lista)),
% lenght(Lista,Cantidad),
% Cantidad >= 2.

% Punto 7
sugarDaddy(Padre):-
    padre(Padre,_),
    forall(padre(Padre,Hijo),quiereRegalo(Hijo)).

quiereRegalo(Hijo):-
    quiere(Hijo,Regalo),
    regaloCaro(Regalo).
quiereRegalo(Hijo):-
    quiere(Hijo,Regalo),
    valeLaPena(Regalo).

regaloCaro(Regalo):-
    precio(Regalo,Precio),
    Precio > 500.

valeLaPena(bloques(Piezas)):-
    member(cubo,Piezas).
valeLaPena(juguete(Nombre,_)):-
    loVale(Nombre).

loVale(woody).
loVale(buzz).











