%DISCOS
%De cada disco sabemos en qué año salió y cuántas copias vendió
% disco(artista, nombreDelDisco, cantidad, año).
disco(floydRosa, elLadoBrillanteDeLaLuna, 1000000, 1973).
disco(tablasDeCanada, autopistaTransargentina, 500, 2006).
disco(rodrigoMalo, elCaballo, 5000000, 1999).
disco(rodrigoMalo, loPeorDelAmor, 50000000, 1996).
disco(rodrigoMalo, loMejorDe, 50000000, 2018).
disco(losOportunistasDelConurbano, ginobili, 5, 2018).
disco(losOportunistasDelConurbano, messiMessiMessi, 5, 2018).
disco(losOportunistasDelConurbano, marthaArgerich, 15, 2019).

%De los artistas conocemos a su manager y sus característica:
%manager(artista, manager).
manager(floydRosa, habitual(15)).
manager(tablasDeCanada, internacional(cachito, canada)).
manager(rodrigoMalo, trucho(tito)).

% habitual(porcentajeComision) 
% internacional(nombre, lugar)
% trucho(nombre)     

%%PUNTO 1
clasico(Artista):-
    disco(Artista, loMejorDe,,).
clasico(Artista):-
    disco(Artista, _, Cantidades, _),
    Cantidades > 100000.

%%PUNTO 2 
cantidadesVendidas(Artista, UnidadesTotales):-
    artistas(Artista),
    findall(Unidades, disco(Artista, _, Unidades, _), UnidadesVendidas),
    sumlist(UnidadesVendidas, UnidadesTotales).
artistas(Artista):-
    disco(Artista, _, _, _).


%%PUNTO 3
%%Sin manager
derechosDeAutor(Artista,ImporteTotal):-
    disco(Artista,,,_),
    not(manager(Artista,_)),
    importeTotal(ImporteTotal,Artista).

importeTotal(ImporteTotal,Artista):-
    cantidadesVendidas(Artista, UnidadesTotales),
    ImporteTotal is UnidadesTotales * 100.
%%Con Manager
derechosDeAutor(Artista,ImporteTotal):-
    disco(Artista,,,_),
    comisionDelManager(Artista,ImporteTotal).

%a)Manager Habitual
comisionDelManager(Artista,ImporteFinal):-
    importeTotal(ImporteTotal,Artista),
    manager(Artista,habitual(PorcentajeComision)),
    ImporteFinal is ImporteTotal * (PorcentajeComision/100). 
%b)Manager Internacional
comisionDelManager(Artista,ImporteFinal):-
    importeTotal(ImporteTotal,Artista),
    manager(Artista,internacional(_,Lugar)),
    porcentajeSegunLugar(Lugar,PorcentajeComision),
    ImporteFinal is ImporteTotal * (PorcentajeComision/100).

porcentajeSegunLugar(Lugar,PorcentajeComision):-
    disco(Artista,,,_),
    manager(Artista,internacional(_,Lugar)),
    Lugar = canada,
    PorcentajeComision is 5.
%c)Manager Trucho 
comisionDelManager(Artista,ImporteFinal):-
    disco(Artista,,,_),
    manager(Artista,trucho(_)),
    ImporteFinal is 0.



%%PUNTO 4
namberUan(Artista, Anio):-
    artistas(Artista),
    not(manager(Artista,_)),
    forall(disco(Artista,_,Cantidad,Anio), artistaDelAnio(Artista, Cantidad)).
artistaDelAnio(Artista, Cantidad1):-
    disco(Artista, _, Cantidad1, Anio),
    disco(OtroArtista, _, Cantidad2, Anio),
    Artista \= OtroArtista,
    Cantidad1 > Cantidad2.



%%PUNTO 5
/*Lo que hay que hacer es generar otro predicado que cumpla con el nuevo tipo,
como lo trabaje aparte del predicado principal tengo como consecuencia un predicado de menor grado de acoplamiento.
El concepto que nos ayuda es el de Polimorfismo, poder convivir distintas formas de representar datos, y aun asi representar algo concreto.
 */