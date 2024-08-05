
mago(harry).
mago(draco).
mago(hermione).

%sangre(Mago,TipoDeSangre).
sangre(harry,mestizo).
sangre(draco,pura).
sangre(hermione,impura).

% casa(NombreCasa,Caracteristicas).
caracteristicaCasa(gryffindor,coraje).

caracteristicaCasa(slytherin,orgulloso).
caracteristicaCasa(slytherin,inteligente).

caracteristicaCasa(ravenclaw,inteligente).
caracteristicaCasa(ravenclaw,responsable).

caracteristicaCasa(hufflepuff,amistoso).

%caracteristica del mago (Mago,Caracteristica).
caracteristica(harry,coraje).
caracteristica(harry,amistoso).
caracteristica(harry,orgulloso).
caracteristica(harry,inteligente).

caracteristica(draco,inteligente).
caracteristica(draco,orgulloso).

caracteristica(hermione,inteligente).
caracteristica(hermione,orgulloso).
caracteristica(hermione,responsable).

casaQueOdia(harry,slytherin).
casaQueOdia(draco,hufflepuff).


% Punto 1
permiteEntrar(Casa,Mago):-
    mago(Mago),
    caracteristicaCasa(Casa,_),
    Casa \= slytherin.
permiteEntrar(slytherin,Mago):-
    sangre(Mago,Sangre),
    Sangre \= impura.

% Punto 2
tieneCaracterApropiado(Mago,Casa):-
    mago(Mago),
    caracteristicaCasa(Casa,_),
    forall(caracteristicaCasa(Casa,Caracteristica),caracteristica(Mago,Caracteristica)).
    %% si para todas las casas el mago tiene las caracteristicas de la casa.

% Punto 3 
seleccionDeCasa(Casa,Mago):-
    permiteEntrar(Casa,Mago),
    tieneCaracterApropiado(Mago,Casa),
    not(casaQueOdia(Mago,Casa)).
seleccionDeCasa(gryffindor,hermione).

% Punto 4
cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).

todosAmistosos(Magos):-
    forall(member(Mago,Magos),amistoso(Mago)).
amistoso(Mago):-
    caracteristica(Mago,amistoso).

% con recursividad
cadenaDeCasas([]).
cadenaDeCasas([_]).
cadenaDeCasas([Mago1,Mago2|MagosSiguientes]):-
    seleccionDeCasa(Casa,Mago1),
    seleccionDeCasa(Casa,Mago2),
    cadenaDeCasas([Mago2|MagosSiguientes]).

% sin recursividad
cadenasDeCasasv2(Magos):-
    forall(consecutivos(Mago1,Mago2,Magos),(seleccionDeCasa(Casa,Mago1),seleccionDeCasa(Casa,Mago2),Mago1\=Mago2)).
    % para todos aquellos que sean consecutivos pueden quedar seleccionados para la misma casa.
consecutivos(Anterior,Siguiente,Lista):-
    nth1(IndiceAnterior,Lista,Anterior),
    IndiceSiguiente is IndiceAnterior +1,
    nth1(IndiceSiguiente,Lista,Siguiente).            
    % con nth1 es un predicado que toma un INDICE, Lista, 











