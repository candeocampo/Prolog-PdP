
%% BASE DE CONOCIMIENTOS

% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotrafico([metanfetaminas])).
prisionero(alex, narcotrafico([heroina])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotrafico([heroina, opio])).
prisionero(dayanara, narcotrafico([metanfetaminas])).

% punto 1 

% controla(Controlador, Controlado)
controla(piper, alex).
controla(bennett, dayanara).

controla(Guardia, Otro):-
    guardia(Guardia), % aseguramos la inversibilidad, ya que ligamos la variable Guardia del not al guardia.
    prisionero(Otro,_), 
    not(controla(Otro, Guardia)).
% Solamente es inversible para su segundo parametro "Otro", por eso debemos ligar el parametro "Guardia"
% para ligarlo con el not.

% punto 2
% relaciona a dos personas distintas (ya sean guardias o prisioneros) si no se controlan mutuamente 
% y existe algún tercero al cual ambos controlan.

conflictoDeInteres(Uno,Otro):-
    controla(Uno,Tercero),
    controla(Otro,Tercero),
    not(controla(Uno,Otro)),
    not(controla(Otro,Uno)),
    Uno \= Otro.  

% punto 3
%  Se cumple para un preso que sólo cometió crímenes graves.
peligroso(Priosionero):-
    prisionero(Priosionero,_),
    forall(prisionero(Priosionero,Crimen),crimenGrave(Crimen)).

crimenGrave(homicidio(_)).
crimenGrave(narcotrafico(Drogas)):-
    member(metanfetaminas,Drogas).
crimenGrave(narcotrafico(Drogas)):-
    length(Drogas, Cantidad),
    Cantidad >=5.

% No ponemos nada sobre los robos pues por la teoría sobre el universo cerrado prolog 
% va a asumir que cualquier cosa que le pase al no matchear con uno de los casos no se cumple o no es cierto.

% punto 4
% Aplica a un prisionero si sólo cometió robos y todos fueron por más de $100.000.

%ladronDeGuanteBlanco(Prisionero):-
%    prisionero(Prisionero,robo(Dinero)),
%    Dinero >= 100000.

ladronDeGuanteBlanco(Prisionero):-
    prisionero(Priosionero,_),
    forall(prisionero(Prisionero,Crimen),(monto(Crimen,Monto),Monto>=10000)).
monto(robo(Monto),Monto).

% de esta última variante usamos polimorfismo.

% punto 5
condena(Prisionero,Condena):-
    prisionero(Priosionero,_),
    findall(Pena,(prisionero(Priosionero,Crimen),pena(Crimen,Pena)),Penas),
    sumlist(Penas,Condena).

pena(robo(Dinero),Pena):-
    Pena is Dinero/10000.
pena(homicidio(Persona),9):-
    guardia(Persona).
pena(homicidio(Persona),7):-
    not(guardia(Persona)).
pena(narcotrafico(Drogas),Pena):-
    length(Drogas,Cantidad),
    Pena is Cantidad * 2.

% punto 6
% Se dice que un preso es el capo de todos los capos cuando nadie lo controla, 
% pero todas las personas de la cárcel (guardias o prisioneros) son controlados por él, 
% o por alguien a quien él controla (directa o indirectamente).

capoDiTuliLiCapi(Capo):-
    prisionero(Capo,_),
    not(controla(_,Capo)),
    forall((persona(Persona),Capo \= Persona),controlaDirectaOIndirectamente(Capo,Persona)).

persona(Persona):-
    prisionero(Persona,_).
persona(Persona):-
    guardia(Persona).

controlaDirectaOIndirectamente(Uno,Otro):-
    controla(Uno,Otro).
controlaDirectaOIndirectamente(Uno,Tercero):-
    controlaDirectaOIndirectamente(Tercero,Otro).

