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

% Punto 1
buenaAccion(ayudar(_)).
buenaAccion(favor(_)).
buenaAccion(travesura(Nivel)):-
    Nivel =< 3.

% Punto 2
sePortoBien(Persona):-
    accion(Persona,_),
    forall(accion(Persona,Accion),buenaAccion(Accion)).
    % con el forall me refiero a que todas las acciones de esa persona son buenas.

% Punto 3
creeEnPapaNoel(Persona):-
    persona(Persona,Edad),
    Edad < 13.

malcriador(Padre):-
    padre(Padre,_),
    forall(padre(Padre,Hijx),esMalcriado(Hijx)).

esMalcriado(Hijx):-
    not(creeEnPapaNoel(Hijx)).
esMalcriado(Hijx):-
    not((accion(Hijx,Accion),buenaAccion(Accion))).

    % accion(Hije,Accion),
    % not(buenaAccion(Accion)).
% esta clausula está mal porque estaría diciendo que es malcriado aquella persona que 
%  si ha realizado alguna acción y esa acción no es buena y el enunciado dice que no ha REALIZADO NINGUNA BUENA ACCIÓN.

% Punto 4
%puedeCostear(Padre,Hije):-
%    padre(Padre,Hije),
%    forall((presupuesto(Padre,Presupuesto),quiere(Hije,Juguete),precioRegalo(Juguete,PrecioRegalo)), Presupuesto >= PrecioRegalo).
% al usar forall no estas sumando los precios de todos los deseos, sino verificando cada uno por separado.
% Presupuesto >= PrecioRegalo está comparando el presupuesto con cada precio de regalo individualmente, 
% pero no se asegura de que el presupuesto pueda cubrir la suma total de todos los regalos.

puedeCostear(Padre,Hijx):-
    padre(Padre,Hijx),
    presupuesto(Padre,Presupuesto),
    costoTotalRegalos(Hijx,PresupuestoRegalos),
    Presupuesto >= PresupuestoRegalos.

costoTotalRegalos(Hijx,PresupuestoRegalos):-
    findall(Precio,(quiere(Hijx,Juguete),precioRegalo(Juguete,Precio)),ListaJuguetes),
    sum_list(ListaJuguetes,PresupuestoRegalos).
    
precioRegalo(abrazo,0).
precioRegalo(juguete(_,Precio),Precio).
precioRegalo(bloques(ListaBloques),Precio):-
    length(ListaBloques,CantidadBloques),
    Precio is CantidadBloques * 3.
    
% Punto 5
regaloCandidatoPara(Persona,Regalo):-
    sePortoBien(Persona),
    quiere(Persona,Regalo),
    padre(Padre,Persona),
    esCapaz(Padre,Regalo),
    creeEnPapaNoel(Persona).    

esCapaz(Padre,Regalo):-
    presupuesto(Padre,Presupuesto),
    precioRegalo(Regalo,PrecioRegalo),
    Presupuesto >= PrecioRegalo.

% Punto 6
% este caso si puede costear
regalosQueRecibe(Hijo,ListaRegalos):-
    padre(Padre,Hijo),
    puedeCostear(Padre,Hijo),
    findall(Regalo,(quiere(Hijo,Regalo)),ListaRegalos).

% este caso si no puede costear
regalosQueRecibe(Hijo,ListaRegalos):-
    padre(Padre,Hijo),
    not(puedeCostear(Padre,Hijo)),
    recibe(Hijo,ListaRegalos).

recibe(Hijo,[media(gris),media(blanca)]):-
    sePortoBien(Hijo).
recibe(Hijo,[carbon]):-
    hizoDosMalasAcciones(Hijo).

hizoDosMalasAcciones(Hijo) :-
    findall(Accion, (accion(Hijo,Accion), not(buenaAccion(Accion))), AccionesMalas),
    length(AccionesMalas, Cantidad),
    Cantidad >= 2.

% hizoDosMalasAcciones(Hijo) :-
%    accion(Hijo,Accion1),
%    accion(Hijo,Accion2),
%    not(buenaAccion(Accion1)),
%    not(buenaAccion(Accion2)).
% Hacerlo de está manera hace que el predicado evalúe si existen dos acciones malas, 
% pero no evalúa todas las acciones que ha hecho la persona para contar cuántas de ellas son malas.

% Punto 7
















