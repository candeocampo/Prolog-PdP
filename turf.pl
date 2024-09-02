% jockey(Persona,Altura,Peso)
jockey(valdivieso,155,52).
jockey(leguisamo,161,49).
jockey(lezcano,149,50).
jockey(baratucci,153,55).
jockey(falero,157,52).

% caballo(NombreCaballo)
caballo(botagofo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

% prefiere(Caballo,Jockey)
prefiere(botagofo,Jockey):-
    jockey(Jockey,_,Peso),
    Peso < 52.
prefiere(botagofo,baratucci).
prefiere(oldMan,Jockey):-
    jockey(Jockey,_,_),
    atom_length(Jockey,CantidadLetras),
    CantidadLetras > 7.
prefiere(energica,Jockey):-
    jockey(Jockey,_,_),
    forall(jockey(Jockey,_,_),not(prefiere(botagofo,Jockey))).
prefiere(matBoy,Jockey):-
    jockey(Jockey,Altura,_),
    Altura > 170.

%representa(Jockey,Stand).
representa(valdivieso,elTute).
representa(falero,elTute).
representa(lezcano,lasHormigas).
representa(baratucci,elCharabon).
representa(leguisamo,elCharabon).

% gano(Caballo,Premio).
gano(botagofo,granPremioNacional).
gano(botagofo,granPremioRepublica).

gano(oldMan,granPremioRepublica).
gano(oldMan,campeonatoPalermoDeOro).

gano(matBoy,granPremioCriadores).

% PUNTO 2
prefiereJockeys(Caballo):-
    prefiere(Caballo,Jockey),
    prefiere(Caballo,OtroJockey),
    Jockey \= OtroJockey.
    
% Punto 3
noPrefiereJockey(Caballo,Stud):-
    caballo(Caballo),
    stud(Stud),
    not((prefiere(Caballo,Jockey),representa(Jockey,Stud))).

stud(Stud):-
    representa(_,Stud).

% Punto 4
piolines(Jockey):-
    jockey(Jockey,_,_),
    forall(ganoPremioImportante(Caballo),prefiere(Caballo,Jockey)).

ganoPremioImportante(Caballo):-
    gano(Caballo,Premio),
    premioImportante(Premio).

premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

% Punto 5
% ganadora(Apuesta,Resultado).
ganadora(ganador(Caballo),Resultado):-
    primerPuesto(Caballo,Resultado).

ganadora(segundo(Caballo),Resultado):-
    primerPuesto(Caballo,Resultado).
ganadora(segundo(Caballo),Resultado):-
    segundoPuesto(Caballo,Resultado).

ganadora(exacta(Caballo1,Caballo2),Resultado):-
    primerPuesto(Caballo1,Resultado),
    segundoPuesto(Caballo2,Resultado).

ganadora(imperfecta(Caballo1,Caballo2),Resultado):-
    primerPuesto(Caballo1,Resultado),
    segundoPuesto(Caballo2,Resultado).

ganadora(imperfecta(Caballo1,Caballo2),Resultado):-
    primerPuesto(Caballo2,Resultado),
    segundoPuesto(Caballo1,Resultado).

primerPuesto(Caballo,[Caballo|_]).
segundoPuesto(Caballo,[_|Caballo]).

% Punto 6
% tiene(Caballo,Tipo).
tiene(botagofo,tordo(negro)).
tiene(oldMan,alazan(marron)).
tiene(energica,ratonero(gris)).
tiene(energica,ratonero(negro)).
tiene(matBoy,palomino(marron)).
tiene(matBoy,palomino(blanco)).
tiene(yatasto,pinto(blanco)).
tiene(yatasto,pinto(marron)).

% color(Tipo,Color)
color(tordo(Color),Color).
color(alazan(Color),Color).
color(ratonero(Color),Color).
color(palomino(Color),Color).
color(pinto(Color),Color).

puedeComprar(Caballo,Color):-
    tiene(Caballo,Tipo),
    color(Tipo,Color),
    findall(Caballo,(tiene(Caballo,Tipo),color(Tipo,Color)),CaballosPosibles),
    CaballosPosibles  \= [].

% tendria que agregar combinar(Caballo,CaballosPosibles) después del findall.

combinar([], []).
combinar([Caballo|CaballosPosibles], [Caballo|Caballos]):-combinar(CaballosPosibles, Caballos).
combinar([_|CaballosPosibles], Caballos):-combinar(CaballosPosibles, Caballos).














