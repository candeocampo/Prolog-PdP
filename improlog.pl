
%% BASE DE CONOCIMIENTOS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% integrante/3: relaciona a un grupo, con una persona que toca en ese grupo y el instrumento
% que toca.

% integrante(Grupo, Persona, Instrumento).
integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDeEste, lisa, saxo).
integrante(vientosDeEste, santi, voz).
integrante(vientosDeEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

% nivelQueTiene/3: relaciona a una persona con un instrumento que toca y qué toca
% tan bien puede improvisar con dicho instrumento (que representamos del 1-5).

% nivelQueTiene(Persona, Instrumento, Nivel)
nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompleta, 1).
nivelQueTiene(luis, contrabajo, 4).

% instrumento/2: que relaciona el nombre de un instrumento con el rol que cumple el mismo
% al tocar en un grupo. Todos los instrumentos se consideran ritmicos, armónicos o melódicos 
% (se incluye información adicional del tipo de instrumento: cuerda, viento, etc)

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










