// =============================================================================
//  main.typ — odpowiednik main.tex (klasa wipb3)
//  Kompilacja:  typst compile main.typ        (lub: make pdf)
//  Wymaga Typst >= 0.13 oraz czcionek: Times New Roman (lub Liberation Serif),
//  Latin Modern Sans/Mono (lub New Computer Modern), Liberation Sans Narrow.
//  Jeśli czcionki są w katalogu projektu:  typst compile --font-path fonts main.typ
// =============================================================================
#import "wipb.typ": *

#show: wipb.with()

#strona-tytulowa()


#spis-tresci()

#set page(numbering: "1")
#counter(page).update(1)

#include "rozdzial_1.typ"
#include "rozdzial_2.typ"
#include "rozdzial_3.typ"
#include "rozdzial_4.typ"
#include "rozdzial_5.typ"
#include "rozdzial_6.typ"
#include "rozdzial_7.typ"
#include "rozdzial_8.typ"

#bibliografia()

#spis-tabel()
#spis-rysunkow()

#spis-listingow(skroty: ("tomtorfs": [Tom Torfs - tomtorfs.c]))
#spis-algorytmow()
