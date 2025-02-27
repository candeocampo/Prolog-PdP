
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

% Parte 2

% Punto 1
% concierto(Nombre,Lugar,Fama,TipoConcierto(Requisito)).
concierto(mikuExpo,estadosUnidos,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vocalektVisions,estadosUnidos,1000,mediano(9)).
concierto(mikuFest,argentina,100,pequenio(4)).

% Punto 2
puedeParticipar(hatsuneMiku,Concierto):-
    concierto(Concierto,_,_,_).
puedeParticipar(Cantante,Concierto):-
    vocaloid(Cantante,_),
    Cantante \= hatsuneMiku,
    concierto(Concierto,_,_,Requisitos),
    cumpleRequisitos(Cantante,Requisitos).

cumpleRequisitos(Cantante,gigante(CantCanciones,TiempoMinimo)):-
    cantidadCanciones(Cantante,CantidadCanciones),
    CantidadCanciones >= CantCanciones,
    duracionDeCanciones(Cantante,TiempoTotal),
    TiempoTotal > TiempoMinimo.
cumpleRequisitos(Cantante,mediano(DuracionTotalCanciones)):-
    duracionDeCanciones(Cantante,DuracionCancion),
    DuracionCancion < DuracionTotalCanciones.
cumpleRequisitos(Cantante,pequenio(Duracion)):-
    tiempoUnaCancion(Cantante,TiempoCancion),
    TiempoCancion > Duracion. 

cantidadCanciones(Cantante,CantidadCanciones):-
    findall(Cancion,vocaloid(Cantante,Cancion),Canciones),
    length(Canciones, CantidadCanciones).
    
% Punto 3
masFamoso(Cantante):-
    nivelFama(Cantante,NivelFama),
    forall(nivelFama(_,Nivel),NivelFama >= Nivel).

nivelFama(Cantante,NivelDeFama):-
    vocaloid(Cantante,_),
    cantidadCanciones(Cantante,CantidadCanciones),
    famaTotal(Cantante,FamaTotal),
    NivelDeFama is CantidadCanciones * FamaTotal.

famaTotal(Cantante,FamaTotal):-
    vocaloid(Cantante,_),
    findall(Fama,concierto(_,_,Fama,_),NivelFama),
    sum_list(NivelFama,FamaTotal).

famaConcierto(Cantante,Fama):-
    puedeParticipar(Cantante,Concierto),
    concierto(Concierto,_,Fama,_).

% Punto 4
conoce(megurineLuke,hatsuneMiku).
conoce(megurineLuke,gumi).
conoce(gumi,seeU).
conoce(seeU,kaito).

unicoParticipante(Cantante,Concierto):-
    puedeParticipar(Cantante,Concierto),
    not((conocido(Cantante,OtroCantante),puedeParticipar(OtroCantante,Concierto))).

%conocido directo
conocido(Cantante,OtroCantante):-
    conoce(Cantante,OtroCantante).

% conocido indirecto
conocido(Cantante,OtroCantante):-
    conoce(Cantante,Tercero),
    conocido(Tercero,OtroCantante).










