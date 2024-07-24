%% BASE DE CONOMIENTOS
%turno(Persona,Día,HoraInicio,HoraFin)
turno(dodain,lunes,9,15).
turno(dodain,miercoles,9,15).
turno(dodain,viernes,9,15).

turno(lucas,martes,10,20).

turno(juanC,sabados,18,22).
turno(juanC,domingo,18,22).

turno(juanFdS,jueves,10,22).
turno(juanFdS,viernes,12,20).

turno(leoC,lunes,14,18).
turno(leoC,miercoles,14,18).

turno(martu,miercoles,23,24).

% punto 1

turno(vale,Dia,HoraInicio,HoraFin):-
    turno(dodain,Dia,HoraInicio,HoraFin).
turno(vale,Dia,HoraInicio,HoraFin):-
    turno(leoC,Dia,HoraInicio,HoraFin).

% "nadie hace el mismo horario que leoC"
% por principio de universo cerrado, no creamos un predicado para esto ya que no tiene sentido agregarlo.

% "maiu está pensando si hace el horario de 0 a 8 los martes y jueves"
% por principio de uniersvo cerrado, lo desconocido de presume como falso.

% punto 2 
% Definir un predicado que permita relacionar un día y hora con una persona, 
% en la que dicha persona atiende el kiosko.
quienAtiende(Dia,Hora,Persona):-
    turno(Persona,Dia,HoraInicio,HoraFin),
    between(HoraInicio, HoraFin, Hora).
    
% punto 3 
% Definir un predicado que permita saber si una persona en un día y horario 
% determinado está atendiendo ella sola.
foreverAlone(Persona,Dia,Horario):-
    quienAtiende(Dia,Horario,Persona),
    not((quienAtiende(Dia,Horario,OtraPersona),Persona\=OtraPersona)).

% punto 4
% Dado un día, queremos relacionar qué personas podrían estar atendiendo el kiosko en algún momento de ese día.
posibilidadesDeAtencion(Dia,Personas):-
    findall(Persona, distinct(Persona, quienAtiende(Persona,Dia,_)), PersonasPosibles),
    combinar(PersonasPosibles,Personas).

combinar([],[]).
combiar([Persona|PersonasPosibles], [Persona|Personas]):- 
    combinar(PersonasPosibles,Personas).
%% Este predicado dice que si tenemos una lista [Persona|PersonasPosibles] 
%% (donde Persona es el primer elemento y PersonasPosibles es el resto de la lista), 
%% entonces una posible combinación es una lista que comienza con Persona seguida por una 
%% combinación de PersonasPosibles. Aquí estamos incluyendo Persona en la combinación resultante.
combinar([_|PersonasPosibles],Personas):-combinar(PersonasPosibles,Personas).
%% Este predicado dice que otra posible combinación de la lista [Persona|PersonasPosibles] 
%% es simplemente una combinación de PersonasPosibles (sin incluir Persona). 
%% Aquí estamos excluyendo Persona de la combinación resultante.

% punto 5
% venta(Persona,Fecha,VentaDelDia).
venta(dodain, fecha(10,8), [golosinas(1200),cigarillos(jockey),golosinas(50)]).
venta(dodain, fecha(12, 8), [bebidas(true, 8), bebidas(false, 1), golosinas(10)]).
venta(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(lucas, fecha(11, 8), [golosinas(600)]).
venta(lucas, fecha(18, 8), [bebidas(false, 2), cigarrillos([derby])]).

personaSuertuda(Persona):-
    vendedor(Persona),
    forall(venta(Persona,_,[Venta|_]), ventaImportante(Venta)).

vendedor(Persona):- venta(Persona,_,_).

ventaImportante(golosinas(Precio)):-
    Precio > 100.
ventaImportante(cigarillos(Marcas)):-
    length(Marcas, Cantidad),
    Cantidad > 2.
ventaImportante(bebidas(true,_)).
ventaImportante(bebidas(_,Cantidad)):-
    Cantidad > 5.













