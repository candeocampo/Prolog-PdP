%% BASE DE CONOMIENTOS

% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipodromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipodromoSanIsidro,85000,3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipodromoSanIsidro,zona1,1500).

% punto 1
% Se cumple para los festivales que ocurren en más de un lugar, 
% pero con el mismo nombre y las mismas bandas en el mismo orden.

itinerante(Festival):-
    festival(Festival,Bandas,UnLugar),
    festival(Festival,Bandas,OtroLugar),
    UnLugar \= OtroLugar.

% punto 2
% Decimos que un festival es careta si no tiene campo o si es el personalFest.

careta(personalFest).
careta(Festival):-
    festival(Festival,_,_),
    not(entradaVendida(Festival, campo)).

% punto 3
% Un festival es nac&pop si no es careta y todas las bandas que tocan en él 
% son de nacionalidad argentina y tienen popularidad mayor a 1000.

nacAndPop(Festival):-
    festival(Festival,Bandas,_),
    forall(member(Banda,Bandas),(banda(Banda,argentina,Popularidad),Popularidad >1000)),
    not(careta(Festival)). %% el not va al final porque sino NO sería inversible.

% punto 4
% Se cumple para los festivales que vendieron más entradas que la capacidad del lugar donde se realizan.
% Nota: no hace falta contemplar si es un festival itinerante.

sobrevendido(Festival):-
    festival(Festival,_,Lugar),
    lugar(Lugar,Capacidad,_),
    findall(Entrada,entradaVendida(Festival,Entrada),Entradas),
    length(Entradas,Cantidad),
    Cantidad > Capacidad.

% punto 5
recaudacionTotal(Festival,Recaudadacion):-
    festival(Festival,_,Lugar),
    findall(Precio,(entradaVendida(Festival,Entrada), precio(Entrada,Lugar,Precio)),Precios),
    sumlist(Precios,Recaudadacion).

precio(campo,Lugar,Precio):-
    lugar(Lugar,_,Precio).
precio(plateaGeneral(Zona),Lugar,Precio):-
    lugar(Lugar,_,PrecioBase),
    plusZona(Lugar,Zona,Recargo),
    Precio is PrecioBase + Recargo.
precio(plateaNumerada(Fila),Lugar,Precio):-
    Fila =<10,
    lugar(Lugar,_,PrecioBase),
    Precio is PrecioBase * 6.
precio(plateaNumerada(Fila),Lugar,Precio):-
    Fila >10,
    lugar(Lugar,_,PrecioBase),
    Precio is PrecioBase * 3.

% punto 6
% Relaciona dos bandas si tocaron juntas en algún recital 
% o si una de ellas tocó con una banda del mismo palo que la otra, pero más popular
delMismoPalo(Banda,OtraBanda):-
    tocoCon(Banda,OtraBanda).
delMismoPalo(Banda,OtraBanda):-
    tocoCon(Banda,TercerBanda),
    banda(TercerBanda,_,PopularidadTercerBanda),
    banda(OtraBanda,_,PopularidadOtraBanda),
    PopularidadTercerBanda > PopularidadOtraBanda,
    delMismoPalo(TercerBanda,OtraBanda).

tocoCon(Banda,OtraBanda):- %% con esto garantizo que tocaron juntas.
    festival(_,Bandas,_),
    member(Banda,Bandas), %% son inversibles, Banda y OtraBandas porque lo usamos en member
    member(OtraBanda,Bandas),
    Banda\=OtraBanda.




