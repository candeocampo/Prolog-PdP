
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






















