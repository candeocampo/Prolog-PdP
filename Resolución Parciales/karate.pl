%alumnoDe(Maestro, Alumno)  
alumnoDe(miyagui,sara). 
alumnoDe(miyagui,bobby). 
alumnoDe(miyagui,sofia). 
alumnoDe(chunLi,guidan).

% tipos de patadas:
% patadaRecta(potencia, distancia).
% patadaDeGiro(potencia, punteria, distancia).
% patadaVoladora(potencia, distancia, altura, punteria).
% golpeRecto(distancia, potencia).
% codazo(potencia).

% destreza(alumno, velocidad, [habilidades]). 
destreza(sofia, 80,[golpeRecto(40,3), codazo(20)]). 
destreza(sara, 70,[patadaRecta(80,2), patadaDeGiro(90,95,2), golpeRecto(1,90)]). 
destreza(bobby, 80,[patadaVoladora(100,3,2,90), patadaDeGiro(50,20,1)]). 
destreza(guidan, 70,[patadaRecta(60,1), patadaVoladora(100,3,2,90), patadaDeGiro(70,80,1)]). 

%categoria(Alumno, Cinturones)  
categoria(sofia, [blanco]). 
categoria(sara, [blanco, amarillo, naranja, rojo, verde, azul, violeta, marron, negro]). 
categoria(bobby, [blanco, amarillo, naranja, rojo, verde, azul, violeta, marron, negro]). 
categoria(guidan, [blanco, amarillo, naranja]).

% Punto 1
esBueno(Alumno):-
    destreza(Alumno,Velocidad,Habilidades),
    between(50,80,Velocidad),
    member(golpeRecto(_,_),Habilidades).
esBueno(Alumno):-
    destreza(Alumno,_,Habilidades),
    patada(Patada),
    member(Patada,Habilidades),
    member(OtraPatada,Habilidades),
    Patada \= OtraPatada.

patada(patadaRecta(_,_)).
patada(patadaDeGiro(_,_,_)).
patada(patadaVoladora(_,_,_,_)).

% Punto 2
esAptoParaTorneo(Alumno):-
    esBueno(Alumno),
    alcanzoCinturon(verde,Alumno).

alcanzoCinturon(Color,Alumno):-
    categoria(Alumno,Cinturones),
    member(Color,Cinturones).

% Punto 3
totalPotencia(Alumno,Potencia):-
    destreza(Alumno,_,Habilidades),
    calcularPotencia(Habilidades,Potencia).

calcularPotencia(Habilidades,Potencia):-
    findall(Valor,(destreza(_,_,Habilidades),member(Habilidad,Habilidades),potencia(Habilidad,Valor))
    ,Lista),
    sum_list(Lista,Potencia).

% potencia(Habilidad,Potencia).
potencia(patadaRecta(Potencia,_),Potencia).
potencia(patadaDeGiro(Potencia,_,_),Potencia).
potencia(patadaVoladora(Potencia,_,_,_),Potencia).
potencia(golpeRecto(_,Potencia),Potencia).
potencia(codazo(Potencia),Potencia).

% otra forma:
% totalPotencia(Alumno,PotenciaTotal):-
% destreza(Alumno,_,Habilidades),
% findall(Valor,(destreza(Alumno,_,Habilidades),calcularPotencia(Habilidades,Potencia)),Lista),
%       sum_list(Potencia,PotenciaTotal).

% calcularPotencia(Habilidades,Potencia):-
%   member(Habilidad,Habilidades),
%   potencia(Habilidad,Potencia).

% Punto 4
alumnoConMayorPotencia(Alumno):-
    totalPotencia(Alumno,Potencia1),
    forall((totalPotencia(OtroAlumno,Potencia2),Alumno\=OtroAlumno),Potencia1 > Potencia2).

% Punto 5
sinPatadas(Alumno):-
    destreza(Alumno,_,Habilidades),
    forall(member(Habilidad,Habilidades),not(patada(Habilidad))).

% sinPatadas(Alumno):-
%    destreza(Alumno,_,Habilidades),
%    patada(Patada), // verifica si esa patada específica no está en las habilidades del alumno.
%    not(member(Patada,Habilidades)). 
% solo verifica la ausencia de una patada específica y no garantiza que el alumno no sepa realizar ninguna patada

% Punto 6
soloSabePatear(Alumno):-
    destreza(Alumno,_,Habilidades),
    forall(member(Habilidad,Habilidades),patada(Habilidad)).

% Punto 7
potencialesSemifinalistas(Alumno):-
    esAptoParaTorneo(Alumno),
    alumnoDe(Maestro,Alumno),
    tieneVariosAlumnos(Maestro),
    estiloArtistico(Alumno).

estiloArtistico(Alumno):-
    destreza(Alumno,_,Habilidades),
    obtenerPotencia(Habilidades,100).
estiloAristico(Alumno):-
    destreza(Alumno,_,Habilidades),
    obtenerPunteria(Habilidades,90).

obtenerPotencia(Habilidades,Potencia):-
    potencia(Habilidad,Potencia),
    member(Habilidad,Habilidades).

obtenerPunteria(Habilidades,Potencia):- 
    punteria(Habilidad,Potencia),
    member(Habilidad,Habilidades).

punteria(patadaDeGiro(_,Punteria,_),Punteria).
punteria(patadaVoladora(_,_,_,Punteria),Punteria).

tieneVariosAlumnos(Maestro):-
    alumnoDe(Maestro,Alumno),
    alumnoDe(Maestro,OtroAlumno),
    Alumno \= OtroAlumno.























