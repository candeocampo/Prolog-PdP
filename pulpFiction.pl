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
sanCayetano(Personaje).






























