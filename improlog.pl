
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASE DE CONOCIMIENTOS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% integrante(Grupo, Persona, Instrumento).
integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDeEste, lisa, saxo).
integrante(vientosDeEste, santi, voz).
integrante(vientosDeEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

% nivelQueTiene(Persona, Instrumento, Nivel)
nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompleta, 1).
nivelQueTiene(luis, contrabajo, 4).

% instrumento(Instrumento, Rol)
instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

% Punto 1
tieneBuenaBase(Grupo):-
    tocaInstrumentoEnBanda(Grupo,Persona,ritmico),
    tocaInstrumentoEnBanda(Grupo,OtraPersona,armonico),
    Persona \= OtraPersona.

tocaInstrumentoEnBanda(Grupo,Persona,Rol):-
    integrante(Grupo,Persona,Instrumento),
    instrumento(Instrumento,Rol).

% Punto 2
seDestaca(Persona,Grupo):-
    nivelConQueToca(Grupo,Persona,Nivel),
    forall((nivelConQueToca(Grupo,OtraPersona,OtroNivel),Persona\=OtraPersona),Nivel > OtroNivel +2).

% Buscamos abstraer esto en otra forma:
% integrante(Grupo,Persona,Instrumento),
% nivelQueTiene(Persona,Instrumento,Nivel)

nivelConQueToca(Grupo,Persona,Nivel):-
    integrante(Grupo,Persona,Instrumento),
    nivelQueTiene(Persona,Instrumento,Nivel).

% Punto 3
% grupo(Grupo,Tipo)
grupo(vientosDelEste,bigBand).
grupo(sophieTrio,formacion([contrabajo,guitarra,violin])).
grupo(jazzmin,formacion([bateria,bajo,trompeta,piano,guitarra])).

% Punto 4
esDeViento(Instrumento):-
    instrumento(Instrumento,melodico(viento)).

hayCupo(Instrumento,Grupo):-
    grupo(Grupo,bigBand),
    esDeViento(Instrumento).
hayCupo(Instrumento,Grupo):-
    instrumento(Instrumento,_), % DEBES PONERLO PARA LIGAR VARIABLES!
    grupo(Grupo,Tipo),
    instrumentoQueSirve(Tipo,Instrumento),
    not(integrante(Grupo,_,Instrumento)). % NO hay alguien que ya lo toque en el grupo.

% este no es inversible ¡debes ligar la variable antes de utilizarlo!
instrumentoQueSirve(formacion(Instrumentos),Instrumento):-
    member(Instrumento,Instrumentos).
instrumentoQueSirve(bigBand,Instrumento):-
    esDeViento(Instrumento).
instrumentoQueSirve(bigBand,bateria).
instrumentoQueSirve(bigBand,bajo).
instrumentoQueSirve(bigBand,piano).


% Punto 5


















