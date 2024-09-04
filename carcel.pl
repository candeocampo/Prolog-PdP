%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASE DE CONOCIMIENTOS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

% Tipo de crimen:
% narcotrafico(ListaDeDrogas).
% homicidio(Victima).
% robo(DineroRobado).

% Punto 1
% controla(Controlador, Controlado)
controla(piper, alex).
controla(bennett, dayanara).
controla(Guardia, Otro):- 
    guardia(Guardia), % debemos agregar el predicado guardia para que pueda ser inversible.
    prisionero(Otro,_), 
    not(controla(Otro, Guardia)).

% si no ligamos la variable guardia en el predicado controla, simplemente
% no podriamos consultar de forma existencial que nos diga los diferentes
% personas que es Controlador y Controlado, además de que el not es una función
% que no cumple con la inversibilidad.

% not en Prolog no cumple con la inversibilidad porque no realiza una 
% negación lógica tradicional, sino una negación basada en la falla de 
% demostración, lo cual puede producir resultados contraintuitivos cuando
% se aplican reglas de lógica clásica.

% Punto 2
conflictoDeInteres(Persona,OtraPersona):-
    controla(Persona,Tercero),
    controla(OtraPersona,Tercero),    
    not(controla(Persona,OtraPersona)),
    not(controla(OtraPersona,Persona)),
    Persona \= OtraPersona.

% Punto 3
peligroso(Preso):-
    prisionero(Preso,_),
    forall(prisionero(Preso,Crimen),crimenGrave(Crimen)).

crimenGrave(homicidio(_)).
crimenGrave(narcotrafico(Drogas)):-
    length(Drogas,CantidadDrogas),
    CantidadDrogas =< 5.
crimenGrave(narcotrafico(Drogas)):-
    member(metanfetaminas,Drogas).

% Punto 4
monto(robo(Dinero),Dinero).

ladronDeGuanteBlanco(Preso):-
    prisionero(Preso,Crimen),
    forall(prisionero(_,Crimen),(monto(Crimen,Dinero),Dinero > 100000)).

% forall(prisionero(Prisionero,robo(Monto),Monto>10000).
% está mal porque solamente estaría chequeando para todo los robos del prisionero
% y la idea es que sea para todos los crimenes utilizando polimorfismo
% y chequeamos que ese crimen sea de robo.

% Punto 5
condena(Prisionero,TiempoCondena):-
    prisionero(Prisionero,Crimen),
    findall(Condena,(prisionero(Prisionero,Crimen),tiempoCondena(Crimen,Condena)),Condenas),
    sum_list(Condenas,TiempoCondena).
    
tiempoCondena(robo(DineroRobado),Condena):-
    Condena is DineroRobado // 10000.
tiempoCondena(homicidio(Victima),9):-
    guardia(Victima).
tiempoCondena(homicidio(Victima),7):-
    not(guardia(Victima)).
tiempoCondena(narcotrafico(Drogas),Condena):-
    length(Drogas,CantidadDrogas),
    Condena is CantidadDrogas * 2.

% Punto 6
capoDiTuliLiCapi(Preso):-
    prisionero(Preso,_),
    not(controla(_,Preso)),
    forall((persona(Persona),Persona\=Preso),controlIndirectoDirecto(Preso,Persona)).

controlIndirectoDirecto(Preso,Otro):-
    controla(Preso,Otro).
controlIndirectoDirecto(Preso,Tercero):-
    controla(Preso,Otro),
    controlIndirectoDirecto(Tercero,Otro).

persona(Persona):-
    prisionero(Persona,_).
persona(Persona):-
    guardia(Persona).

























