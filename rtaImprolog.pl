%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Código Inicial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Punto 1

%tieneBuenaBase2(Grupo):-
%    integrante(Grupo, TocaRitmico, InstrumentoRitmico),
%    integrante(Grupo, TocaArmonico, InstrumentoArmonico),
%    TocaRitmico \= TocaArmonico,
%    instrumento(InstrumentoRitmico, ritmico),
%    instrumento(InstrumentoArmonico, armonico).

%% Alternativa con abstracción adicional

tieneBuenaBase(Grupo):-
    cubreRolDeInstrumento(Grupo, TocaRitmico, ritmico),
    cubreRolDeInstrumento(Grupo, TocaArmonico, armonico),
    TocaRitmico \= TocaArmonico.

cubreRolDeInstrumento(Grupo, Persona, Rol):-
    integrante(Grupo, Persona, Instrumento),
    instrumento(Instrumento, Rol).

%% Punto 2
seDestaca(PersonaDestacada,Grupo):-
    nivelConElQueToca(PersonaDestacada, Grupo, Nivel),
    forall((nivelConElQueToca(OtraPersona, Grupo, NivelMenor), OtraPersona \= Persona),
            Nivel >= NivelMenor + 2).

nivelConElQueToca(Persona, Grupo, Nivel):-
    integrante(Grupo, Persona, Instrumento),
    nivelQueTiene(Persona, Instrumento, Nivel).

%% Punto 3
grupo(vientosDelEste, bigBand).
grupo(sophieTrio, formacion([contrabajo, guitarra, violin])).
grupo(jazzmin, formacion([bateria, bajo, trompeta, piano, guitarra])).

%% Agregado Punto 8
grupo(estudio1, ensamble(3)).

%% Punto 4
hayCupo(Instrumento, Grupo):-
    grupo(Grupo, bigBand),
    esDeViento(Instrumento).
hayCupo(Instrumento, Grupo):-
    instrumento(Instrumento, _),
    grupo(Grupo, TipoDeGrupo),
    sirveInstrumento(TipoDeGrupo, Instrumento),
    not(integrante(Grupo, _, Instrumento)).

esDeViento(Instrumento):-
    instrumento(Instrumento, melodico(viento)).

sirveInstrumento(formacion(InstrumentosBuscados), Instrumento):-
    member(Instrumento, InstrumentosBuscados).
sirveInstrumento(bigBand, Instrumento):-
    esDeViento(Instrumento).
sirveInstrumento(bigBand, bateria).
sirveInstrumento(bigBand, bajo).
sirveInstrumento(bigBand, piano).

%% Agregado Punto 8
sirveInstrumento(ensamble(_), _).

%% Punto 5
puedeIncorporarse(Grupo, Persona, Instrumento):-
    hayCupo(Instrumento, Grupo),
    nivelQueTiene(Persona,Instrumento,Nivel),
    not(integrante(Grupo, Persona, _)),
    grupo(Grupo,TipoDeGrupo),
    nivelMinimo(TipoDeGrupo, NivelEsperado),
    Nivel >= NivelEsperado.

nivelMinimo(bigBand, 1).
nivelMinimo(formacion(Instrumentos), NivelMinimo):-
    length(Instrumentos, CantidadInstrumentos),
    NivelMinimo is 7 - CantidadInstrumentos.

%% Agregado Punto 8
nivelMinimo(ensamble(NivelMinimo), NivelMinimo).

%% Punto 6
seQuedoEnBanda(Persona):-
    nivelQueTiene(Persona, _,_),
    not(integrante(_, Persona, _)),
    not(puedeIncorporarse(_, Persona, _)).

%% Punto 7
puedeTocar(Grupo):-
    grupo(Grupo, bigBand),
    tieneBuenaBase(Grupo),
    findall(TocaViento, (integrante(Grupo, TocaViento, Instrumento), esDeViento(Instrumento)),
     TocanViento),
    length(TocanViento, CantidadVientos),
    CantidadVientos >= 5.

puedeTocar(Grupo):-
    grupo(Grupo, formacion(Instrumentos)),
    forall(member(Instrumento, Instrumentos), integrante(Grupo, _, Instrumento)).

%% Agregado Punto 8
puedeTocar(Grupo):-
    grupo(Grupo, ensamble(_)),
    tieneBuenaBase(Grupo),
    cubreRolDeInstrumento(Grupo, _, melodico(_)).