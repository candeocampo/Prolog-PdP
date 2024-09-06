
% disco(artista, nombreDelDisco, cantidadCopias, año).
disco(floydRosa, elLadoBrillanteDeLaLuna, 1000000, 1973).
disco(tablasDeCanada, autopistaTransargentina, 500, 2006).
disco(rodrigoMalo, elCaballo, 5000000, 1999).
disco(rodrigoMalo, loPeorDelAmor, 50000000, 1996).
disco(rodrigoMalo, loMejorDe, 50000000, 2018).
disco(losOportunistasDelConurbano, ginobili, 5, 2018).
disco(losOportunistasDelConurbano, messiMessiMessi, 5, 2018).
disco(losOportunistasDelConurbano, marthaArgerich, 15, 2019).

%manager(artista, manager).
manager(floydRosa,normal(15)).
manager(tablasDeCanada,buenaOnda(cachito, canada)).
manager(rodrigoMalo,estafador(tito)).

% habitual(porcentajeComision)
% internacional(nombre, lugar)
% trucho(nombre)

% Punto 1
clasico(Artista):-
    disco(Artista,loMejorDe,_,_).
clasico(Artista):-
    disco(Artista,_,Cantidad,_),
    Cantidad > 100000.

% Punto 2
cantidadesVendidas(Artista,TotalVendido):-
    disco(Artista,_,_,_),
    findall(Cantidad,disco(Artista,_,Cantidad,_),ListaDiscos),
    sumlist(ListaDiscos,TotalVendido).

artista(Artista):-
    disco(Artista,_,_,_),
    manager(Artista,_).

% Punto 3
derechoDeAutor(Artista,ImporteTotal):-
    tiene(Artista,_),
    venta(Artista, TotalVentas),
    cobraManager(Artista,Porcentaje),
    ImporteManager is TotalVentas * Porcentaje / 100,
    ImporteTotal is TotalVentas - ImporteManager.
derechoDeAutor(Artista,ImporteTotal):- 
    disco(Artista,_,_,_),
    not(tiene(Artista,_)),
    venta(Artista,ImporteTotal).

venta(Artista,Aporte):-
    disco(Artista,_,_,_),
    cantidadesVendidas(Artista,TotalVendido),
    Aporte is 100 * TotalVendido.

tiene(Artista,Manager):-
    artista(Artista),
    manager(Artista,Manager).

cobraManager(Artista,Porcentaje):-
    manager(Artista,Caracteristica),
    tipo(Tipo),
    cobra(Tipo,Caracteristica,Porcentaje).

% cobra (Tipo,Caracteristica,Porcentaje)
cobra(habitual,normal(Porcentaje),Porcentaje).
cobra(internacional,buenaOnda(_,Lugar),Porcentaje):-
    residencia(Lugar,Porcentaje).
cobra(trucho,estafador(_),100).

residencia(mexico,15).
residencia(canada,5).

tipo(habitual).
tipo(internacional).
tipo(trucho).

% Punto 4
namberuan(Artista,Anio).




















