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
   persona(Persona),
   findall(Mascota,tieneSolamenteGato(Persona,Mascota),Lista),
   length(Lista,CantidadGatos),
   CantidadGatos >1.
   
tieneSolamenteGato(Persona,Mascota):-
    persona(Persona),
    forall(adopto(Persona,Mascota,_),mascota(Mascota,gato(_,_))).

persona(Persona):-
    adopto(Persona,_,_).
persona(Persona):-
    regalo(Persona,_,_).
persona(Persona):-
    compro(Persona,_,_).

% Punto 3




