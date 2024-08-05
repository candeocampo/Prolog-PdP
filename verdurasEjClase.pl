%%%%%%%%%%%%%%%%
%% BASE DE CONOMIENTOS %% 
%%%%%%%%%%%%%%%%
% receta(Nombre,Ingredientes)
% ingrediente(Ingrediente)
% calorias(Ingrediente,Calorias)


% trivial/1: Se cumple para las recetas con un único ingrediente.
trivial(Receta):-
    receta(Receta,[_]).

% elPeor/2: Relaciona una receta con su ingrediente más calórico.
elPeor(Ingredientes,Peor):- 
    member(Peor,Ingredientes), 
    calorias(Peor,CaloriasDelPeor),
    forall(member(Ingrediente,Ingredientes),(calorias(Ingrediente,Calorias),CaloriasDelPeor>= Calorias)).

% caloríasTotales/2: Relaciona una receta y su total de calorías.
caloriasTotales(Receta,Total):-
    receta(Receta,Ingredientes),
    findall(Kcal,(member(Ing,Ingredientes),calorias(Ing,Kcal)),Kcals),
    % Para cada uno de esos ingredientes obtener sus calorias, el selector "Kcal" permite elegir la cantidad de 
    % calorias de cada uno de esos ingredientes de la receta.
    sum_list(Kcals, Total).
    

% versiónLight/2: Relaciona una receta con sus ingredientes, sin el peor.
versionLight(Receta,IngredientesLight):-
    receta(Receta,Ingredientes),
    elPeor(Ingredientes,Peor),
    findall(Ing,(member(Ing,Ingredientes),Ing\=Peor),IngredientesLight).

% guasada/1: Se cumple para una receta con algún ingrediente de más de 1000Kcal.
guasada(Receta):-
    receta(Receta,Ingredientes),
    member(IngredienteEngordador,Ingredientes),
    calorias(IngredienteEngordador,Kcal),
    Kcal>1000.






























