
%% herramientasRequeridas(Tarea,[Herramientas]) 
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(peter,trapeador).
tiene(witnston,varitaDeNeutrones).

satisfaceNecesidad(Integrante,Herramienta):-
    tiene(Integrante,Herramienta).
satisfaceNecesidad(Integrante,aspiradora(PotenciaRequerida)):-
    tiene(Integrante,aspiradora(PotenciaAspiradora)),
    between(0,PotenciaAspiradora,PotenciaRequerida).
    
%    PotenciaRequerida =< PotenciaAspiradora.
% Ponerlo así no lo hace inversible.

% Punto 3
puedeRealizarTarea(Integrante,Tarea):-
    herramientasRequeridas(Tarea,_),
    tiene(Integrante,varitaDeNeutrones).    
puedeRealizarTarea(Integrante,Tarea):-
    tiene(Integrante,_),
    herramientasRequeridas(Tarea,_),
    forall(requiereHerramienta(Tarea,Herramienta),satisfaceNecesidad(Integrante,Herramienta)).

requiereHerramienta(Tarea,Herramienta):-
    herramientasRequeridas(Tarea,Herramientas),
    member(Herramienta, Herramientas).
    
% Punto 4
% tareaPedida(Cliente,Tarea,MetrosXTarea).
% precio(Tarea,PrecioXMetro).

cobrar(Cliente,PrecioACobrar):-
    tareaPedida(Cliente,_,_),
    findall(Precio,precioPorTarea(Cliente,Tarea,Precio),ListaTareas),
    sum_list(ListaTareas,PrecioACobrar).
    
precioPorTarea(Cliente,Tarea,Precio):-
    tareaPedida(Cliente,Tarea,MetrosAUsar),
    precio(Tarea,PrecioXMetro),
    Precio is MetrosAUsar * PrecioXMetro.

% Punto 5
% tareaCompleja(Tarea):-
%    herramientasRequeridas(limpiarTecho,_). % si le ponemos esto no seria inversible.

tareaCompleja(limpiarTecho).
tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea,Herramientas),
    length(Herramientas, TotalHerramientas),
    TotalHerramientas >2.

dispuestoAceptar(ray,Cliente):-
    not(tareaPedida(limpiarTecho,Cliente,_)).
dispuestoAceptar(winston,Cliente):-
    precio(Cliente,PrecioACobrar),
    PrecioACobrar > 500.
dispuestoAceptar(egon,Cliente):-
    tareaPedida(Cliente,Tarea,_),
    not(tareaCompleja(Tarea)).
dispuestoAceptar(peter,_).   

aceptaPedido(Integrante,Cliente):-
    puedeHacerPedido(Integrante,Cliente), % esto lo usamos para abstraer sino podria ponerlo acá.
    dispuestoAceptar(Integrante,Cliente).

puedeHacerPedido(Integrante,Cliente):-
    tiene(Integrante,_), 
    tareaPedida(_,Cliente,_), 
    forall(tareaPedida(Tarea,Cliente,_),puedeRealizarTarea(Integrante,Tarea)).

% Punto 6
% 6.a
herramientasRequeridas(ordenarCuarto, [alternativas(aspiradora(100),escoba), trapeador, plumero]).
% 6.b
satisfaceNecesidad(Tarea,alternativas(H1,_)):-
    satisfaceNecesidad(Tarea,H1).
satisfaceNecesidad(Tarea,alternativas(_,H2)):-
    satisfaceNecesidad(Tarea,H2).


% 6.c



















