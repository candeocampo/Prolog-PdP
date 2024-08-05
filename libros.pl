
% vende(Titulo,Autor,Genero,Editorial,Precio)
vende(elResplandor, stephenKing, terror, debolsillo, 2300).
vende(cronicasDelAngelGris, alejandroDolina, ficcion, booket, 1600).
vende(harryPotter3, jkRowling, ficcion, salamandra, 2500).
vende(mort, terryPratchett, aventura, plazaJanes, 1300).

% Si comenzara a vender discos
% vende(Titulo,Autor,Genero,CantidadDeDiscos,CantidadDeTemas,Precio)

vende(differentClass, pulp, pop, 2, 24, 1450).
vende(bloodOnTheTracks, bobDylan, folk, 1 12, 2500).

% Podria armar un predicado general
% vende(Articulo,Precio) 
% Acá el Articulo podría ser un libro, cd, etc.

% BASE DE CONOCIMIENTO
vende(libro(elResplandor, stephenKing, terror, debolsillo), 2300).
vende(libro(cronicasDelAngelGris, alejandroDolina, ficcion, booket), 1600).
vende(libro(harryPotter3, jkRowling, ficcion, salamandra), 2500).
vende(libro(mort, terryPratchett, aventura, plazaJanes), 1300).

vende(cd(differentClass, pulp, pop, 2, 24), 1450).
vende(cd(bloodOnTheTracks, bobDylan, folk, 1, 12), 2500).

% Se cumple para un autor si todo lo que se vende es de él.
tematico(Autor):-
    autor(_,Autor),
    forall(vende(Articulo,_), autor(Articulo,Autor)).

%Relaciona un articulo con su autor.
autor(libro(_,Autor,_,_),Autor):-
    vende(libro(_,Autor,_,_),_). % con esto ya es inversible.
autor(cd(_,Autor,_,_,_),Autor):-
    vende(cd(_,Autor,_,_,_),_).

% el predicado autor no es totalmente inversible, si no le doy el funtor no sabe de que autor hablo.


% EJERCICIOS

% libroMasCaro/1: Se cumple para un articulo si es el libro de mayor precio.

libroMasCaro(libro(Titulo,Autor,Genero,Editorial)):-
    vende(libro(Titulo,Autor,Genero,Editorial),Precio),
    forall(vende(libro(_,_,_),OtroPrecio), OtroPrecio=<Precio).
    % Se podria haber hecho con un not también.


% curiosidad/1: Se cumple para un articulo si es lo único que hay a la venta de su autor.
curiosidad(Articulo):-
    vende(Articulo,_),
    autor(Articulo,Autor), % este no es 100% inversible.
    not((vende(Otro,_), autor(Otro,Autor),Articulo\=Otro)).
    % no hay ninguna otra cosa que yo este vendiendo de esté autor, que sea distinta.
    % se podia hacer con un forall también.

% sePrestaAConfusion/1: Se cumple para un título si pertenece a más de un articulo.

sePrestaAConfusion(Titulo):-
    titulo(Articulo,Titulo),
    titulo(OtroArticulo,Titulo),
    Articulo \= OtroArticulo.

titulo(libro(Titulo,_,_,_),Titulo):-
    vende(libro(Titulo,_,_,_),_).

titulo(cd(Titulo,_,_,_,_),Titulo):-
    vende(cd(Titulo,_,_,_,_),_).

titulo(pelicula(Titulo,_,_),Titulo):-
    vende(pelicula(Titulo,_,_),Titulo).

% mixto/1: Se cumple para los autores de más de un tipo de artículo.
mixto(Autor):-
    autor(libro(_,_,_,_),Autor),
    autor(cd(_,_,_,_,_),Autor).

mixto(Autor):-
    autor(libro(_,_,_,_),Autor),
    autor(pelicula(_,_,_),Autor).

mixto(Autor):-
    autor(cd(_,_,_,_,_),Autor),
    autor(pelicula(_,_,_),Autor).

% Agregar soporte para vender peliculas con titulo, director y genero.

vende(pelicula(Titulo,Director,Genero),Precio).






















