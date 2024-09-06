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
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(señorCaraDePapa,caraDePapa([original(pieIzquierdo),original(pieDerecho),repuesto(nariz)])).

% Dice si un juguete es raro.
esRaro(deAccion(stacyMalibu, 1, [sombrero])).

% Dice si una persona es coleccionista.
esColeccionista(sam).

% Punto 1
tematica(deTrapo(Tematica),Tematica).
tematica(deAccion(Tematica,_),Tematica).
tematica(miniFiguras(Tematica,_),Tematica).
tematica(caraDePapa(_),caraDePapa).

esDePlastico(Juguete):-
    juguete(Juguete,miniFiguras(_)).
esDePlastico(Juguete):-
    juguete(Juguete,caraDePapa(_)).

esDeColeccion(Juguete) :-
    juguete(Juguete, deTrapo(_)).
esDeColeccion(Juguete) :-
    juguete(Juguete,_),
    esRaro(deAccion(juguete,_,_)).

% Punto 2
amigoFiel(Duenio,Juguete):-
    duenio(Duenio,Juguete,Tiempo),
    not(esDePlastico(Juguete)),
    forall((duenio(OtroDuenio,Juguete2, Tiempo2),Juguete2 \= Juguete), Tiempo > Tiempo2).

% Punto 3







