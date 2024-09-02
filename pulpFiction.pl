%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% BASE DE CONOMIENTOS %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% personaje(Personaje,Actividad)
personaje(pumkin, ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent, mafioso(maton)).
personaje(jules, mafioso(maton)).
personaje(marsellus, mafioso(capo)).
personaje(winston, mafioso(resuelveProblemas)).
personaje(mia, actriz([foxForceFive])).
personaje(butch, boxeador).

% pareja(Personaje,Pareja)
pareja(marsellus, mia).
pareja(pumkin, honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

% Punto 1
actividadPeligrosa(Personaje):-
    personaje(Personaje,mafioso(maton)).
actividadPeligrosa(Personaje):-
    personaje(Personaje,ladron(CosasRobadas)),
    member(licorerias,CosasRobadas).

esPeligroso(Personaje):-
    actividadPeligrosa(Personaje).

esPeligroso(Personaje):-
    trabajaPara(Personaje,Empleado),
    actividadPeligrosa(Empleado).

% Punto 2
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTemible(Personaje,OtroPersonaje):-
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje),
    relacion(Personaje,OtroPersonaje),
    Personaje \= OtroPersonaje.

relacion(Personaje,OtroPersonaje):-
    novios(Personaje,OtroPersonaje).
relacion(Personaje,OtroPersonaje):-
    amistad(Personaje,OtroPersonaje).

% tomamos la relacion de forma simetrica.
amistad(Personaje,OtroPersonaje):-
    amigo(Personaje,OtroPersonaje).
amistad(Personaje,OtroPersonaje):-
    amigo(OtroPersonaje,Personaje).

novios(Personaje,OtroPersonaje):-
    pareja(Personaje,OtroPersonaje).
novios(Personaje,OtroPersonaje):-
    pareja(OtroPersonaje,Personaje).

% Punto 3
% encargo(Solicitante, Encargado, Tarea).
% las tareas pueden ser :
% cuidar(Protegido)
% ayudar(Ayudado)
% buscar(Buscado, Lugar)
encargo(marsellus, vincent, cuidar(mia)).
encargo(vincent, elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnProblemas(Personaje):-
    trabajaPara(Jefe,Personaje),
    esPeligroso(Jefe),
    pareja(Jefe,Pareja),
    encargo(Jefe,Personaje,cuidar(Pareja)).

estaEnProblemas(Personaje):-
    encargo(_,Personaje,buscar(Persona,_)),
    personaje(Persona,boxeador).

% Punto 4
sanCayetano(Personaje):-
    personaje(Personaje,_),
    forall(tieneCerca(Personaje,Empleado),encargo(Personaje,Empleado,_)).

tieneCerca(Personaje,OtroPersonaje):-
    amigo(Personaje,OtroPersonaje).
tieneCerca(Personaje,OtroPersonaje):-
    trabajaPara(Personaje,OtroPersonaje).

% Punto 5
tieneMasEncargos(Personaje,OtroPersonaje):-
    cantidadEncargos(Personaje,Cantidad),
    cantidadEncargos(OtroPersonaje,Cantidad2),
    Cantidad > Cantidad2.

cantidadEncargos(Personaje,Cantidad):-
    encargo(_,Personaje,_),
    findall(Encargo,encargo(_,Personaje,Encargo),Encargos),
    length(Encargos,Cantidad).

masAtareado(Personaje):-
    personaje(Personaje,_),
    forall((personaje(OtroPersonaje,_),Personaje \= OtroPersonaje),
    tieneMasEncargos(Personaje,OtroPersonaje)).

% Punto 6
personajesRespetables(Personaje):-
    findall(PersonajeRespetable,esRespetable(PersonajeRespetable),Personaje).

esRespetable(Personaje):-
    personaje(Personaje,Actividad),
    nivelRespeto(Actividad,Nivel),
    Nivel > 9.

nivelRespeto(actriz(Peliculas),Nivel):-
    length(Peliculas,CantidadPeliculas),
    Nivel is CantidadPeliculas // 10.
nivelRespeto(mafioso(resuelveProblemas),10).
nivelRespeto(mafioso(maton),1).
nivelRespeto(mafioso(capo),20).
nivelRespeto(_,0).

% Punto 7
% interactua con el segundo.
interactua(cuidar(Persona),Persona).
interactua(buscar(Persona,_),Persona).
interactua(ayudar(Persona),Persona).
% en caso de que tenga que interactuar con un amigo del segundo.
interactua(cuidar(Persona),Amigo):-
    amistad(Persona,Amigo).
interactua(buscar(Persona),Amigo):-
    amistad(Persona,Amigo).
interactua(ayudar(Persona),Amigo):-
    amistad(Persona,Amigo).

hartoDe(Personaje,OtroPersonaje):-
    encargo(_,Personaje,_), % lo que va acá tiene que ser el mismo predicado que uso en el forall para ligarlo.
    personaje(OtroPersonaje,_),
    forall(encargo(_,Personaje,Actividad),interactua(Actividad,OtroPersonaje)).

% Punto 8
% caracteristicas(Personaje,Caracteristicas).
caracteristicas(vincent, [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules, [tieneCabeza, muchoPelo]).
caracteristicas(marvin, [negro]).

duoDiferenciable(Personaje,OtroPersonaje):-
    relacion(Personaje,OtroPersonaje),
    caracteristicas(Personaje,Caracteristica1),
    caracteristicas(OtroPersonaje,Caracteristica2),
    tieneCaracteristica(Caracteristica1,Caracteristica2).

tieneCaracteristica(Caracteristica1,Caracteristica2):-
    member(Caracteristica,Caracteristica1),
    not(member(Caracteristica,Caracteristica2)).
tieneCaracteristica(Caracteristica1,Caracteristica2):-
    member(Caracteristica,Caracteristica2),
    not(member(Caracteristica,Caracteristica1)).







