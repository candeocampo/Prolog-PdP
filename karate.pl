
%alumnoDe(Maestro, Alumno)
alumnoDe(miyagui, sara).
alumnoDe(miyagui, bobby).
alumnoDe(miyagui, sofia).
alumnoDe(chunLi, guidan).

% destreza(alumno, velocidad, [habilidades]).
destreza(sofia,80,[golpeRecto(40,3),codazo(20)]).
destreza(sara,70,[patadaRecta(80,2),patadaDeGiro(90,95,2),golpeRecto(1,90)]).
destreza(bobby,80,[patadaVoladora(100,3,2,90),patadaDeGiro(50,20,1)]).
destreza(guidan,70,[patadaRecta(60,1),patadaVoladora(100,3,2,90),patadaDeGiro(70,80,1)]).

%categoria(Alumno, Cinturones)
categoria(sofia,[blanco]).
categoria(sara,[blanco,amarillo,naranja,rojo,verde,azul,violeta,marron,negro]).
categoria(bobby,[blanco,amarillo,naranja,rojo,verde,azul,violeta,marron,negro]).
categoria(guidan,[blanco,amarillo,naranja]).

% Punto 1
% patada(Patada).
patada(patadaRecta(_,_)).
patada(patadaDeGiro(_,_,_)).
patada(patadaVoladora(_,_,_,_)).

esBueno(Alumno):-
    seVerifica(Alumno).

seVerifica(Alumno):-
    destreza(Alumno,_,Habilidades),
    member(Patada1,Habilidades),
    member(Patada2,Habilidades),
    patada(Patada1),
    patada(Patada2),
    Patada1 \= Patada2.
seVerifica(Alumno):-
    destreza(Alumno,Velocidad,Habilidades),
    velocidadEntre(Velocidad),
    member(golpeRecto(_,_),Habilidades).

velocidadEntre(Velocidad):-
    between(50,80,Velocidad).

% Punto 2
esAptoParaTorneo(Alumno):-
    esBueno(Alumno),
    tieneCinturon(Alumno,verde).

tieneCinturon(Alumno,Cinturon):-
    categoria(Alumno,Cinturones),
    member(Cinturon,Cinturones).

% Punto 3
totalPotencia(Alumno,PotenciaTotal):-
    destreza(Alumno,_,_),
    findall(Potencia,(destreza(Alumno,_,Habilidades),calcularPotencia(Habilidades,Potencia)),Lista),
    sum_list(Lista,PotenciaTotal).

calcularPotencia(Habilidades,Potencia):-
    member(Habilidad,Habilidades),
    potenciaHabilidad(Habilidad,Potencia).

% potenciaHabilidad(Habilidad,Potencia).
potenciaHabilidad(patadaRecta(Potencia,_),Potencia).
potenciaHabilidad(patadaDeGiro(Potencia,_,_),Potencia).
potenciaHabilidad(patadaVoladora(Potencia,_,_,_),Potencia).
potenciaHabilidad(codazo(Potencia),Potencia).
potenciaHabilidad(golpeRecto(_,Potencia),Potencia).

% Punto 4
alumnoConMayorPotencia(Alumno):-
    totalPotencia(Alumno,Potencia),
    forall(totalPotencia(_,Potencia2),Potencia>=Potencia2).

% Punto 5
sinPatadas(Alumno):-
    destreza(Alumno,_,Habilidades),
    forall(member(Habilidad,Habilidades),not(patada(Habilidad))).

% Punto 6
soloSabePatear(Alumno):-
    destreza(Alumno,_,Habilidades),
    forall(member(Habilidad,Habilidades),patada(Habilidad)).

% Punto 7
potencialesSemifinalistas(Alumno):-
    esAptoParaTorneo(Alumno),
    tieneMaestro(Alumno),
    habilidadConBuenEstilo(Alumno).

tieneMaestro(Alumno):-
    alumnoDe(Maestro,Alumno),
    alumnoDe(Maestro,OtroAlumno),
    Alumno \= OtroAlumno.

punteriaHabilidad(patadaDeGiro(_,Punteria,_),Punteria).
punteriaHabilidad(patadaVoladora(_,_,_,Punteria),Punteria).

habilidadConBuenEstilo(Alumno):-
    destreza(Alumno,_,Habilidades),
    obtenerPunteria(Habilidades,90).

habilidadConBuenEstilo(Alumno):-
    destreza(Alumno,_,Habilidades),
    obtenerPotencia(Habilidades,100).

obtenerPunteria(Habilidades,Punteria):-
    member(HabilidadPunteria,Habilidades),
    punteriaHabilidad(HabilidadPunteria,Punteria).

obtenerPotencia(Habilidades,Potencia):-
    member(HabilidadPotencia,Habilidades),
    potenciaHabilidad(HabilidadPotencia,Potencia).

% Punto 8
semifinalistas(ListaAlumnos):-
    findall(Alumno, potencialesSemifinalistas(Alumno),ListaAlumnos).

% Punto 9
%% El polimorfismo en Prolog se ve en la forma en que diferentes predicados trabajan con distintos 
%% tipos de datos o estructuras de forma genérica. Por ejemplo, potenciaHabilidad/2 es un predicado 
%% que funciona con varias formas de habilidades (patadaRecta, patadaDeGiro, etc.) 
%% sin necesidad de modificar el código para cada tipo específico. Esto permite que 
%% potenciaHabilidad/2 se aplique a cualquier habilidad de manera uniforme, sin importar su tipo específico.

% El uso de predicados de orden superior, como member/2, forall/2, y findall/3, 
% permite que se manipulen listas y se realicen comprobaciones o búsquedas de manera abstracta y reutilizable.



