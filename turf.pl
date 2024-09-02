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




































