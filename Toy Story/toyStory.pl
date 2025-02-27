%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASE DE CONOCIMIENTOS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Relaciona al dueño con el nombre del juguete y la cantidad de años que lo ha tenido.
duenio(andy, woody, 8).
duenio(sam, jessie, 3).

% Relaciona al juguete con su nombre los juguetes son de la forma:
% deTrapo(tematica)
% deAccion(tematica, partes)
% miniFiguras(tematica, cantidadDeFiguras)
% caraDePapa(partes)

% juguete(NombreJuguete,Forma).
juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero)).
juguete(buzz, deAccion(espacial,[original(casco)])).
juguete(soldados, miniFiguras(soldado,60)).
juguete(monitosEnBarril, miniFiguras(mono,50)).
juguete(seniorCaraDePapa, caraDePapa([original(pieIzquierdo),original(pieDerecho),repuesto(nariz)])).

% Dice si un juguete es raro.
% esRaro(Forma)
esRaro(deAccion(stacyMalibu, 1, [sombrero])).

% Dice si una persona es coleccionista.
esColeccionista(sam).

% Punto 1.a
% tema(Forma,Tematica)
tema(deTrapo(Tematica),Tematica).
tema(deAccion(Tematica,_),Tematica).
tema(miniFiguras(Tematica,_),Tematica).

% tematica(Juguete,Tematica)
tematica(Juguete,caraDePapa):-
    juguete(Juguete,caraDePapa(_)).
tematica(Juguete,Tematica):-
    juguete(Juguete,Forma),
    tema(Forma,Tematica).

% Punto 1.b
esDePlastico(Juguete):-
    juguete(Juguete,Forma),
    plastico(Forma).

plastico(miniFiguras(_,_)).
plastico(caraDePapa(_)).

% Punto 1.c
esDeColeccion(Juguete):-
    juguete(Juguete,_),
    forall(juguete(Juguete,Forma),esRaro(Forma)).

esDeColeccion(Juguete):-
    juguete(Juguete,deTrapo(_)).

% Punto 2
amigoFiel(Duenio,Juguete):-
    duenio(Duenio,Juguete,TiempoJuguete),
    forall((duenio(Duenio,OtroJuguete,OtroTiempoJuguete), Juguete \= OtroJuguete),TiempoJuguete > OtroTiempoJuguete).

% Punto 3
superValioso(Juguete):-
    original(Juguete),
    not(esDeColeccionista(Juguete)).

original(Juguete):-
    juguete(Juguete,Forma),
    esOriginal(Forma).

esOriginal(deAccion(_,Piezas)):-
    not(member(repuesto(_),Piezas)).
esOriginal(caraDePapa(Piezas)):-
    not(member(repuesto(_),Piezas)).

esDeColeccionista(Juguete):-
    duenio(Persona,Juguete,_),
    esColeccionista(Persona).

% Punto 4
duoDinamico(Duenio,Juguete,OtroJuguete):-
    duenio(Duenio,Juguete,_),
    duenio(Duenio,OtroJuguete,_),
    pareja(Juguete,OtroJuguete).

pareja(Juguete,OtroJuguete):-
    tematica(Juguete,Tematica),
    tematica(OtroJuguete,Tematica),
    Juguete \= OtroJuguete.
pareja(woody,buzz).

% Punto 5
felicidad(Duenio,CantidadFelicidad):-
    duenio(Duenio,_,_),
    findall(Juguete,duenio(Duenio,Juguete,_),Juguetes),
    felicidadTotal(Juguetes,CantidadFelicidad).

felicidadTotal(Juguetes,Total):-
    findall(Felicidad,(member(Juguete,Juguetes),valorFelicidad(Juguete,Felicidad)),Felicidades),
    sum_list(Felicidades,Total).

valorFelicidad(Juguete,Valor):-
    juguete(Juguete,miniFiguras(_,Figuritas)),
    Valor is Figuritas * 20.
valorFelicidad(Juguete,100):-
    juguete(Juguete,deTrapo(_)).
valorFelicidad(Juguete,120):-
    juguete(Juguete,deAccion(_,_)),
    esDeColeccion(Juguete),
    duenio(Duenio,Juguete,_),
    esColeccionista(Duenio).
valorFelicidad(Juguete,100):-
    juguete(Juguete,deAccion(_,_)).
valorFelicidad(Juguete,Total):-
    juguete(Juguete,caraDePapa(Lista)),
    findall(Valor,(member(Pieza,Lista),puntoPieza(Pieza,Valor)), Felicidades),
    sum_list(Felicidades,Total).

puntoPieza(original(_),5).
puntoPieza(repuesto(_),8).

% Punto 6
puedeJugarCon(Persona,Juguete):-
    duenio(Persona,Juguete,_).

puedeJugarCon(Persona,Juguete):-
    puedeJugarCon(Persona,Juguete):-
    dueno(Duenio,Juguete,_),
    pretaJuguete(Persona,Duenio).

cantidadJuguetes(Duenio, CantidadDeJuguetes):-
    findall(Juguete,duenio(Duenio,Juguete,_),ListaJuguetes),
    sum_list(ListaJuguetes, CantidadDeJuguetes).

pretaJuguete(Persona,Duenio):-
    cantidadJuguetes(Persona,JuguetesPersona),
    cantidadJuguetes(Duenio,JuguetesDuenio),
    JuguetesPersona > JuguetesDuenio.




