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
puedeRealizar2(Persona,Tarea):-
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
%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

cobrar(Cliente,PrecioTotal):-
    tiene(Cliente,_),
    herramientasRequeridas(Tarea,_),
    findall(Precio,precioPorTarea(Cliente,Tarea,Precio),PrecioTarea),
    sum_list(PrecioTarea,PrecioTotal).

precioPorTarea(Cliente,Tarea,Precio):-
    tareaPedida(Cliente,Tarea,Metros),
    precio(TareaPedida,PrecioMetro),
    Precio is Metros * PrecioMetro.








