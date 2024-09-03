%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASE DE CONOCIMIENTOS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%tareas:
%  ingerir(descripcion, tamaño, cantidad)
%  apresar(malviviente, recompensa)
%  asuntosInternos(agenteInvestigado)
%  vigilar(listaDeNegocios)

%tarea(agente, tarea, ubicacion)
tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).

ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).

%jefe(jefe, subordinado)
jefe(jefeSupremo,vega ).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).

% Punto 1
frecuenta(Agente,Ubicacion):-
    tarea(Agente,_,Ubicacion).
frecuenta(Agente,buenosAires):-
    tarea(Agente,_,_).
frecuenta(vega,quilmes).
frecuenta(Agente,marDelPlata):-
    tarea(Agente,vigilar(Lugares),_),
    member(alfajores,Lugares).

% Punto 2
inaccesible(Ubicacion):-
    ubicacion(Ubicacion),
    not(frecuenta(_,Ubicacion)).

% Punto 3
afincado(Agente):-
    tarea(Agente,_,Ubicacion),
    forall(tarea(Agente,_,OtraUbicacion),Ubicacion=OtraUbicacion).

% Punto 4
% Hacer el predicado cadenaDeMando/1 que verifica si la lista recibida 
% se trata de una cadena de mando válida, lo que significa que el primero es 
% jefe del segundo y el segundo del tercero y así sucesivamente. 
% Debe estar hecho de manera tal que permita generar todas las cadenas de mando
% posibles, de dos o más agentes.

cadenaDeMando([Jefe,Segundo]):- % caso base
    jefe(Jefe,Segundo).
cadenaDeMando([Jefe,Segundo | Resto]):- % caso recursivo
    jefe(Jefe,Segundo),
    cadenaDeMando([Segundo | Resto]).

% Punto 5
agentePremiado(Agente):-
    tarea(Agente,_,_),
    forall((tarea(OtroAgente,_,_),Agente \= OtroAgente),tieneMasPuntaje(Agente,OtroAgente)).

tieneMasPuntaje(Agente,OtroAgente):-
    puntuacionAgente(Agente,Puntuacion1),
    puntuacionAgente(OtroAgente,Puntuacion2),
    Puntuacion1 > Puntuacion2.

puntuacionAgente(Agente,Puntuacion):-
    findall(Punto,(tarea(Agente,Tarea,_),puntajeTarea(Tarea,Punto)),Puntajes),
    sum_list(Puntajes,Puntuacion).
    
puntajeTarea(vigilar(Lugares),Punto):-
    length(Lugares,LugaresVigilados),
    Punto is 5 * LugaresVigilados.
puntajeTarea(ingerir(_,Tamanio,Cantidad),Punto):-
    UnidadesIngeridas is Tamanio * Cantidad,
    Punto is UnidadesIngeridas * (- 10).
puntajeTarea(apresar(_,Recompensa),Punto):-
    Punto is Recompensa // 2.
puntajeTarea(asuntosInternos(Agente),Punto):-
    puntuacionAgente(Agente,Puntuacion),
    Punto is Puntuacion * 2.

% otra forma
% agentePremiado(AgentePremiado) :-
%    tarea(AgentePremiado, _, _),  % Comienza con el primer agente
%    puntuacionAgente(AgentePremiado, PuntuacionPremiado),  % Calcula su puntuación
%    forall((tarea(OtroAgente, _, _), OtroAgente \= AgentePremiado),  % Verifica todos los otros agentes
%           (puntuacionAgente(OtroAgente, PuntuacionOtro),
%            PuntuacionOtro =< PuntuacionPremiado)).  % Asegura que ningún otro tenga puntuación mayor

% 6) Justificar la utilización de polimorfismo, orden superior e inversibilidad.
% El polimorfismo en prolog nos permite manipular un predicado con diferentes
% tipos de datos, por ejemplo en puntajeTarea que se define un único predicado
% que calcula el puntaje según cada tarea en especifica.

% El uso de orden superior como al usar "forall" nos permite ver de manera
% declarativa que todos los agentes cumplen con una determinada propiedad.

% Inversibilidad: nos permite la utilidad de usar un predicado para que nos permita
% tanto la busqueda como la generación de todos los datos existentes que cumplen con lo pedido.
% Ej: agentePremiado/1, la estructura de la consulta permite deducir quién 
% es el agente premiado y también puede utilizarse para generar soluciones 
% si se proporciona información parcial.



















