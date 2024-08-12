
% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotráfico([metanfetaminas])).
prisionero(alex, narcotráfico([heroína])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotráfico([heroína, opio])).
prisionero(dayanara, narcotráfico([metanfetaminas])).

% Punto 1
% controla(Controlador, Controlado)

controla(piper, alex).
controla(bennett, dayanara).
controla(Guardia, Otro):-
    guardia(Guardia), 
    prisionero(Otro,_), 
    not(controla(Otro, Guardia)).

% No es inversible al menos que agreguemos guarda(Guardia) para ligar la variable y de esta manera
% obtener todos los posibles casos (guardias) que cumplen con el predicado controla.

% Punto 2
conflictoDeIntereses(Persona,Persona2):-
    controla(Persona,OtraPersona),
    controla(Persona2,OtraPersona),
    not(controla(Persona,Persona2)),
    not(controla(Persona2,Persona)),
    Persona\=Persona2.

% Punto 3
peligroso(Preso):-
    prisionero(Preso,_),
    forall(prisionero(Preso,Crimen),grave(Crimen)).

% Como el robo nunca es grave por concepto de mundo cerrado, no lo ponemos.
grave(homicidio(_)).
grave(narcotrafico(Drogas)):-
    member(metanfetaminas,Drogas).
grave(narcotrafico(Drogas)):-
    length(Drogas, Cantidad),
    Cantidad >= 5.
    
% Punto 4
ladronDeGuanteBlanco(Ladron):-
    prisionero(Ladron,robo(Monto)),
    Monto > 100000.

ladronDeGuanteBlancoV2(Ladron):-
    prisionero(Ladron,_),
    forall(prisionero(Ladron,Crimen),(monto(Crimen,Monto),Monto >= 100000)).

monto(robo(Monto),Monto).

% Punto 5
condena(Prisionero,Condena):-
    prisionero(Prisionero,_),
    findall(Anios,(prisionero(Prisionero,Crimen),segunCrimen(Crimen,Anios)),CantidadAnios),
    sumlist(CantidadAnios,Condena).

segunCrimen(robo(Dinero),Anios):-
    Anios is Dinero / 10000.
segunCrimen(homicidio(Victima),7):-
    not(guardia(Victima)).
segunCrimen(homicidio(Victima),Anios):-
    guardia(Victima),
    Anios is 7 +2.
segunCrimen(narcotrafico(Drogas),Anios):-
    length(Drogas, TotalDrogas),
    Anios is TotalDrogas * 2.
    
% Punto 6
capoDiTuliLiCapi(Capo):-
    controla(Capo,_),
    not(controla(_,Capo)),
    forall((persona(Persona),Persona\=Capo), (controlIndirectamenteDirectamente(Capo,Persona))).

persona(Persona):-
    guardia(Persona).
persona(Persona):-
    prisionero(Persona,_).

controlIndirectamenteDirectamente(Capo,Persona):-
    controla(Capo,Persona).
controlIndirectamenteDirectamente(Capo,Persona):-
    controla(Capo,Otro),
    controlIndirectamenteDirectamente(Otro,Persona).
































