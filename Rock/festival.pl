% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él 
% y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipodromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipodromoSanIsidro, 85000, 3000).

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
plusZona(hipodromoSanIsidro, zona1, 1500).

itinerante(Festival):-
    festival(Festival,Bandas,Lugar),
    festival(Festival,Bandas,OtroLugar),
    Lugar\=OtroLugar.

careta(Festival):-
    festival(Festival,_,_),
    not(entradaVendida(Festival,campo)).
careta(personalFest).

nacAndPop(Festival):-
    festival(Festival,Bandas,_),
    forall(member(Banda,Bandas),(banda(Banda,argentina,Fans),Fans>1000)),
    % todos los miembros de esa lista de bandas
    not(careta(Festival)).

sobrevendido(Festival):-
    festival(Festival,_,Lugar),
    lugar(Lugar,Cantidad,_),
    findall(Entradas,entradaVendida(Festival,Entradas),ListaEntradas),
    length(ListaEntradas, TotalVendido),
    TotalVendido > Cantidad.

recaudacionTotal(Festival,TotalRecaudado):-
    festival(Festival,_,Lugar),
    findall(Precio,(entradaVendida(Festival,TipoDeEntrada),precioLugar(TipoEntrada,Precio,Lugar)),PrecioTotal),
    sum_list(PrecioTotal, TotalRecaudado).

precioLugar(campo,Precio,Lugar):-
    lugar(Lugar,_,Precio).
precioLugar(plateaGeneral(Zona),Precio,Lugar):-
    lugar(Lugar,_,PrecioBase),
    plusZona(Lugar, Zona, Recargo),
    Precio is PrecioBase + Recargo.
precioLugar(plateaNumerada(Num),Precio,lugar):-
    Num > 10,
    lugar(Lugar,_,PrecioBase),
    Precio is PrecioBase * 3.
precioLugar(plateaNumerada(Num),Precio,lugar):-
    Num =< 10,
    lugar(Lugar,_,PrecioBase),
    Precio is PrecioBase * 6.

tocoCon(Banda,OtraBanda):-
    festival(_,Bandas,_),
    member(Banda,Bandas),
    member(OtraBanda,Bandas),
    Banda \= OtraBanda.
delMismoPalazo(Banda,OtraBanda):-
    tocoCon(Banda,OtraBanda).
delMismoPalo(Banda,OtraBanda):-
    tocoCon(Banda,Tercera),
    delMismoPalazo(Tercera,OtraBanda),
    banda(TercerBanda,_,PopularidadTercero),
    banda(OtraBanda,_,OtraPopularidad),
    PopularidadTercero > OtraPopularidad.





