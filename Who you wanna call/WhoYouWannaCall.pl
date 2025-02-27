%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASE DE CONOMIENTOS %%
%%%%%%%%%%%%%%%%%%%%%%%%%

% herramientasRequeridas(Tarea,Herramientas).
herramientasRequeridas(ordenarCuarto, [aspiradora(100),trapeador,plumero]).
herramientasRequeridas(limpiarTecho, [escoba,pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa,trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora,cera,aspiradora(300)]).

% cazafantasmas(Persona).
cazafantasmas(peter).
cazafantasmas(egon).
cazafantasmas(ray).
cazafantasmas(winston).

% Punto 1
% tiene(Persona,Herramienta).
tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(peter,trapeador).
tiene(winston,varitaDeNeutrones).

% Punto 2
satisfaceNecesidad(Persona,Herramienta):-
    tiene(Persona,Herramienta).

satisfaceNecesidad(Persona,aspiradora(PotenciaRequerida)):-
    tiene(Persona,aspiradora(PotenciaAspiradora)),
    between(0,PotenciaRequerida,PotenciaAspiradora).
    % PotenciaAspiradora >= PotenciaRequerida. NO LO HACE INVERSIBLE.

% Punto 3
puedeRealizar(Persona,Tarea):-
    tiene(Persona,varitaDeNeutrones),
    herramientasRequeridas(Tarea,_).

puedeRealizar(Persona,Tarea):-
    tiene(Persona,_),
    herramientasRequeridas(Tarea,Herramientas),
    forall(member(Herramienta,Herramientas),satisfaceNecesidad(Persona,Herramienta)).

% una forma de abstraer la condición de forall sería:
% requiereHerramienta(Tarea,Herramienta):-
%   herramientasRequeridas(Tarea,Herramientas),
%   member(Herramienta,Herramientas).

% Punto 4
%tareaPedida(cliente,tarea, metrosCuadrados).
tareaPedida(dana, ordenarCuarto, 20).
tareaPedida(walter, cortarPasto, 50).
tareaPedida(walter, limpiarTecho, 70).
tareaPedida(louis, limpiarBanio, 15).
tareaPedida(winston, limpiarTecho, 30).
tareaPedida(egon, ordenarCuarto, 100).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

precioPorTarea(Cliente,Tarea,Precio):-
    tareaPedida(Cliente,Tarea,Metros),
    precio(Tarea,PrecioMetro),
    Precio is Metros * PrecioMetro.

cobrar(Cliente,PrecioTotal):-
    tareaPedida(Cliente,_,_),
    herramientasRequeridas(Tarea,_),
    findall(Precio,precioPorTarea(Cliente,Tarea,Precio),PrecioTarea),
    sum_list(PrecioTarea,PrecioTotal).

% Punto 5
% aceptaPedido(Integrante,Pedido)
seDisponeAceptarlo(ray,Cliente):-
    not(tareaPedida(Cliente,limpiarTecho,_)). 
seDisponeAceptarlo(winston,Cliente):-
    precioPorTarea(Cliente,_,Precio),
    Precio > 500.
seDisponeAceptarlo(peter,_).
seDisponeAceptarlo(egon,Cliente):-
    not((tareaPedida(Cliente,Pedido,_),
    tareaCompleja(Pedido))).
% otra forma:
% forall(tareaPedida(Cliente, Tarea, _),not(tareaCompleja(Tarea))).

% hacerlo así:
%seDisponeAceptarlo(egon,Cliente):-
%    tareaPedida(Cliente,Pedido,_),
%    not(tareaCompleja(Pedido)).
% esto solamente verifica si hay alguna tarea que no sea compleja, no TODAS.

tareaCompleja(limpiarTecho).
tareaCompleta(Tarea):-
    herramientasRequeridas(Tarea,Herramientas),
    length(Herramientas,CantidadHerramientas),
    CantidadHerramientas > 2.

puedeHacerPedido(Cliente,Trabajador):-
    cliente(Cliente),
    trabajador(Trabajador),
    forall(tareaPedida(Cliente,Tarea,_),puedeRealizar(Trabajador,Tarea)).

cliente(Cliente):-
    tareaPedida(Cliente,_,_).
trabajador(Trabajador):-
    tiene(Trabajador,_).

aceptaPedido(Cliente,Trabajador):-
    puedeHacerPedido(Cliente,Trabajador),
    seDisponeAceptarlo(Trabajador,Cliente).

% Punto 6
% La alternativa que planteamos en esta solución es agrupar en una lista
% las herramientas remplazables, y agregar una nueva definición a 
% satisfaceNecesidad, que era el predicado que usabamos para tratar
% directamente con las herramientas, que trate polimorficamente tanto
% a nuestros hechos sin herramientas remplazables, como a aquellos que 
% sí las tienen. También se podría haber planteado con un functor en vez
% de lista.

herramientasReemplazables(ordenarCuarto,
    [alternativas([aspiradora(100),escoba]),trapeador,plumero]).

satisfaceNecesidad(Persona,alternativas(HerramientasAlternativas)):-
    member(Herramientas,HerramientasAlternativas),
    satisfaceNecesidad(Persona,Herramienta).


%% IMPORTANTE
% Este enunciado pedía que todos los predicados fueran inversibles
% Recordemos que un predicado es inversible cuando 
% no necesitás pasar el parámetro resuelto (un individuo concreto), 
% sino que podés pasar una incógnita (variable sin unificar).

% Listas:
% En general las listas son útiles sólo para contar o sumar muchas cosas
% que están juntas.










