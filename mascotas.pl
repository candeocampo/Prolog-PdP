adopto(martin, pepa, 2014). 
adopto(martin, olivia, 2014). 
adopto(martin, frida, 2015). 
adopto(martin, kali, 2016). 
adopto(constanza, mambo, 2015). 
adopto(hector, abril, 2015). 
adopto(hector, mambo, 2015). 
adopto(hector, buenaventura, 1971). 
adopto(hector, severino, 2007). 
adopto(hector, simon,  2016). 

compro(martin, piru, 2010). 
compro(hector, abril, 2006). 

regalo(constanza, abril, 2006). 
regalo(silvio, quinchin, 1990). 

mascota(pepa,perro(mediano)).
mascota(frida,perro(grande)).
mascota(piru,gato(macho,15)).
mascota(kali,gato(macho,3)).
mascota(olivia,gato(hembra,16)).
mascota(mambo,gato(macho,2)).
mascota(abril,gato(hembra,4)).
mascota(buenaventura,tortuga(agresiva)).
mascota(severino,tortuga(agresiva)).
mascota(simon,tortuga(tranquila)).
mascota(quinchin,gato(macho,0)).

% Punto 1
% b) Da falso debido al concepto de universo cerrado todo aquello que no hayamos
% aclarado y/o escrito en nuestra base de conocimientos de considerara falso.

% Punto 2
comprometidos(Persona,OtraPersona):-
    adopto(Persona,Mascota,Anio),
    adopto(OtraPersona,Mascota,Anio),
    Persona \= OtraPersona.

% Punto 3
locoDeLosGatos(Persona):-
   persona(Persona,_,_),
   findall(Mascota,tieneSolamenteGato(Persona,Mascota),Lista),
   length(Lista,CantidadGatos),
   CantidadGatos >1.
   
tieneSolamenteGato(Persona,Mascota):-
    persona(Persona,_,_),
    forall(adopto(Persona,Mascota,_),mascota(Mascota,gato(_,_))).

persona(Persona,Mascota,Anio):-
    adopto(Persona,Mascota,Anio).
persona(Persona,Mascota,Anio):-
    regalo(Persona,Mascota,Anio).
persona(Persona,Mascota,Anio):-
    compro(Persona,Mascota,Anio).

% Punto 4
puedeDormir(Persona):-
    persona(Persona,_,_),
    forall(persona(Persona,Mascota,_),not(estaChapita(Mascota))).

estaChapita(perro(chico)).
estaChapita(tortuga(_)).
estaChapita(gato(macho,Caricias)):-
    Caricias < 10.

% Punto 5

% Punto 6
mascotaAlfa(Persona,Mascota):-
    persona(Persona,Mascota,_),
    forall((persona(Persona,OtraMascota,_),Mascota\=OtraMascota),dominante(Mascota,OtraMascota)).

dominante(Mascota,Mascota2):- 
    mascota(Mascota,Animal),
    mascota(Mascota2,Animal2), 
    domina(Animal,Animal2).

domina(tortuga(agresiva),_).
domina(gato(_,_),perro(_)).
domina(perro(grande),perro(chico)).
domina(GatoChapita,gato(_,_)):-
    estaChapita(GatoChapita).

% Punto 7
materialista(Persona):-
   not(persona(Persona,_,_)).

materialista(Persona):-
    persona(Persona,_,_),
    mascotasAdoptadas(Persona,CantidadAdoptados),
    mascotasCompradas(Persona,CantidadComprados),
    CantidadComprados > CantidadAdoptados.

mascotasAdoptadas(Persona,CantidadAdoptados):-
    findall(MascotaAdoptada,adopto(Persona,MascotaAdoptada,_),ListaAdopto),
    length(ListaAdopto,CantidadAdoptados).
mascotasCompradas(Persona,CantidadComprados):-
    findall(MascotaComprada,compro(Persona,MascotaComprada,_),ListaComprados),
    length(ListaComprados,CantidadComprados).










