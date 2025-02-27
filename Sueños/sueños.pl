% Punto 1
% creeEn(Persona,PersonajeQueCree).
creeEn(gabriel,campanita).
creeEn(gabriel,magoDeOz).
creeEn(gabriel,cavenaghi).

creeEn(juan,conejoDePascua).

creeEn(macarena,reyesMagos).
creeEn(macarena,magoCapria).
creeEn(macarena,campanita).

% suenios
% suenio(cantante,disco).
% suenio(futbolista(equipo)).
% suenio(loteria(apuesta)).

suenio(gabriel,loteria(5)).
suenio(gabriel,loteria(9)).
suenio(gabriel,futbolista(arsenal)).
suenio(juan,cantante(100000)).
suenio(macarena,cantante(10000)).

% en este punto entro el concepto de funtores para tener una mejor explayación
% de los datos que vamos a utilizar.

% Punto 2
ambiciosa(Persona):-
    suenio(Persona,_),
    findall(Dificultad,(suenio(Persona,Suenio),dificultadSuenio(Suenio,Dificultad)),Lista),
    sum_list(Lista,TotalDificultad),
    TotalDificultad >20.
    
dificultadSuenio(cantante(CantidadDiscos),6):-
    CantidadDiscos > 500000.
dificultadSuenio(cantante(CantidadDiscos),4):-
    CantidadDiscos =< 500000.
dificultadSuenio(loteria(Apuesta),Dificultad):-
    Dificultad is Apuesta * 10.
dificultadSuenio(futbolista(Equipo),3):-
    equipoChico(Equipo).
dificultadSuenio(futbolista(Equipo,16)):-
    not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivil).

persona(Persona):-
    suenio(Persona,_).
persona(Persona):-
    creeEn(Persona,_).

% Punto 3
tieneQuimica(Persona,campanita):-
    suenio(Persona,Suenio),
    dificultadSuenio(Suenio,Dificultad),
    Dificultad < 5.

tieneQuimica(Persona,Personaje):-
    creeEn(Persona,Personaje),
    forall(suenio(Persona,Suenio),suenioPuro(Suenio)),
    not(ambiciosa(Persona)).

suenioPuro(futbolista(_)).
suenioPuro(cantante(Discos)):-
    Discos < 200000.

% Punto 4
% amigoDe(Personaje,Amigo)
amigoDe(campanita,reyesMagos).
amigoDe(campanita,conejoDePascua).
amigoDe(conejoDePascua,cavenaghi).

alegraA(Persona,Personaje):-
    suenio(Persona,_), 
    tieneQuimica(Persona,Personaje), 
    estaSanoOAmigoSano(Personaje).

estaSanoOAmigoSano(Personaje):-
    not(estaEnfermo(Personaje)).  

estaSanoOAmigoSano(Personaje):-
    amigoDirectoIndirecto(Personaje,Amigo), 
    not(estaEnfermo(Amigo)). 

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

amigoDirectoIndirecto(Personaje,Amigo):-
    amigoDe(Personaje,Amigo).

amigoDirectoIndirecto(Personaje,Amigo):-
    amigoDe(Personaje,Intermediario),
    amigoDirectoIndirecto(Intermediario,Amigo).












