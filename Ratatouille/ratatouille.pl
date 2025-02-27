
% rata(Nombre, LugarDondeVive).
rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).

% cocina(Persona, Plato, Experiencia)
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).

% trabajaEn(Restaurante, Persona)
trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).

% Punto 1
inspeccionSatisfactoria(Restaurante):-
    trabajaEn(Restaurante,_),
    not(rata(_,Restaurante)).

% Punto 2
chef(Empleado,Restaurante):-
    trabajaEn(Restaurante,Empleado),
    findall(Plato,cocina(Empleado,Plato,_),PlatosCocina),
    length(PlatosCocina,Cantidad),
    Cantidad >=1.
    
% Punto 3
chefcito(Rata):-
    rata(Rata,Casa),
    trabajaEn(Casa,linguini).

% Punto 4
cocinaBien(Persona,Plato):-
    cocina(Persona,Plato,Experiencia),
    Experiencia > 7.
cocinaBien(remy,_).

% Punto 5
encargadoDe(Persona,Plato,Restaurante):-
    cocina(Persona,Plato,Experiencia1),
    trabajaEn(Restaurante,Persona),
    forall((trabajaEn(Restaurante,OtraPersona),cocina(OtraPersona, Plato,Experiencia2)),
    Experiencia1 =< Experiencia2). % va =< que EXP2 porque se trata de ver quién tiene mayor experiencia.

%% SE AGREGA MÁS INFORMACIÓN A NUESTRA BASE DE CONOCIMIENTOS :)
% plato(Plato,Tipo(Ingredientes))
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

% Punto 6
saludable(Plato):-
    plato(Plato,Tipo),
    caloriasPlato(Tipo,Calorias),
    Calorias =< 75.

caloriasPlato(entrada(Ingredientes),Calorias):-
    length(Ingredientes,CantidadIngredientes),
    Calorias is CantidadIngredientes * 15.
caloriasPlato(principal(_,TiempoCoccion),Calorias):-
    Calorias is TiempoCoccion * 5.
caloriasPlato(principal(pure,TiempoCoccion),Calorias):-
    Calorias is TiempoCoccion * 5 + 20.
caloriasPlato(principal(papasFritas,TiempoCoccion),Calorias):-
    Calorias is TiempoCoccion * 5 + 50.
caloriasPlato(postre(Calorias),Calorias).

% Punto 7
criticaPositiva(Critico,Restaurante):-
    inspeccionSatisfactoria(Restaurante),
    criterioCritico(Critico,Restaurante).

criterioCritico(antonEgo,Restaurante) :-
    especialistaEn(Restaurante,ratatouille).
criterioCritico(christophe,Restaurante):-
    trabajaEn(Restaurante,_),
    findall(Chef,trabajaEn(Restaurante,Chef),Chefs),
    length(Chefts,Cantidad),
    Cantidad >=3.
criterioCritico(cormillot,Restaurante):-
    forall((chef(Chef, Restaurante),cocina(Chef, Plato, _)), saludable(Plato)),
    noFaltaZanahoria(Restaurante).

noFaltaZanahoria(Restaurante):-
    forall((plato(Plato, entrada(_)), trabajaEn(Restaurante, _)), tieneZanahoria(Plato)).
 
tieneZanahoria(Plato) :-
    plato(Plato, entrada(Ingredientes)),
    member(zanahoria, Ingredientes).

especialistaEn(Restaurante,Plato):-
    trabajaEn(Restaurante,_),
    cocina(_,Plato,_),
    forall((trabajaEn(Restaurante,Chef),chef(Chef,Restaurante)),cocinaBien(Chef,Plato)).



















