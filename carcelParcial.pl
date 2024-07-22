
%% BASE DE CONOCIMIENTOS

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


% punto 1 

% controla(Controlador, Controlado)
controla(piper, alex).
controla(bennett, dayanara).
controla(Guardia, Otro):- 
    prisionero(Otro,_), 
    not(controla(Otro, Guardia)).












