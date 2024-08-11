
% vocaloid(Cantante,Cancion(Nombre,Duracion))).

vocaloid(megurineLuke,cancion(nightFever,4)).
vocaloid(megurineLuke,cancion(foreverYoung,5)).
vocaloid(hatsuneMiku,cancion(tellYourWorld,4)).
vocaloid(gumi,cancion(foreverYoung,4)).
vocaloid(gumi,cancion(tellYourWorld,5)).
vocaloid(seeU,cancion(novemberRaing,6)).
vocaloid(seeU,cancion(nightFever,5)).

% Punto 1
sabeDosCanciones(Cantante):-
    vocaloid(Cantante,Cancion),
    vocaloid(Cantante,OtraCancion),
    Cancion \= OtraCancion.
    
duracionCanciones(Cantante,Total):-
    vocaloid(Cantante,Cancion),
    findall(Duracion,vocaloid(Cantante,cancion(_,Duracion)),Canciones),
    sum_list(Canciones,Total).
    
novedoso(Cantante):-
    sabeDosCanciones(Cantante),
    duracionCanciones(Cantante,Total),
    Total < 15.

% Otra alternativa seria utilizar polimorfino para los funtores.
tiempo(cancion(_,Tiempo),Tiempo).

tiempoUnaCancion(Cantante,TiempoCancion):-
    vocaloid(Cantante,Cancion),
    tiempo(Cancion,TiempoCancion).

duracionDeCanciones(Cantante,TiempoTotal):-
    findall(Duracion,tiempo(Cantante,Duracion),DuracionTotal),
    sum_list(DuracionTotal,TiempoTotal).


% Punto 2
acelerado(Cantante):-
    vocaloid(Cantante,_),
    not((tiempoUnaCancion(Cantante,Duracion), Duracion > 4)).

% conciertos
% concierto(Nombre,Lugar,Fama,TipoConcierto(Requisito)).
concierto(mikuExpo,estadosUnidos,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vocalektVisions,estadosUnidos,1000,mediano(9)).
concierto(mikuFest,argentina,100,pequenio(4)).















