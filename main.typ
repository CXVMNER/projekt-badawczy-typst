// =============================================================================
//  main.typ — odpowiednik main.tex (klasa wipb3)
//  Kompilacja:  typst compile main.typ        (lub: make pdf)
//  Wymaga Typst >= 0.13 oraz czcionek: Times New Roman (lub Liberation Serif),
//  Latin Modern Sans/Mono (lub New Computer Modern), Liberation Sans Narrow.
//  Jeśli czcionki są w katalogu projektu:  typst compile --font-path fonts main.typ
// =============================================================================
#import "wipb.typ": *

// ---- dane pracy (odpowiednik \katedra{…}, \temat{…}, \autor{…} …) -------------
#let meta = (
  katedra: "Oprogramowania",
  typ-pracy: "inżynierska", // lub "magisterska"
  temat: "Opis użycia klasy wipb",
  autor: "Gal Anonim",
  promotor: "dr inż. Jan Kowalski",
  indeks: "123456",
  studia: "stacjonarne", // lub "niestacjonarne"
  rok-akademicki: "2008/2009",
  profil: "magisterskie jednolite",
  kierunek: "informatyka", // lub "matematyka"
  specjalnosc: "Inżynieria Oprogramowania",
  zakres: "1. zakres I, 2. zakres II, 3. zakres III",
)

// ---- \hypersetup{pdfauthor=…, pdftitle=…, pdfkeywords=…} ---------------------
#show: wipb.with()

// \includepdf{strona-tytulowa.pdf} — odtworzona natywnie (puste pola z kropkami).
// Aby wstawić dane z `meta`:  #strona-tytulowa(meta: meta, wypelnij: true)
// Aby użyć gotowego PDF-a (Typst >= 0.14):  #page(margin: 0pt)[#image("strona-tytulowa.pdf")]
#strona-tytulowa(
  // \bibliographystyle{plabbrv} sortuje alfabetycznie. Typst numeruje wg pierwszego
  // cytowania, więc podajemy kolejność alfabetyczną kluczy (niewidoczne cytowania na
  // stronie tytułowej). Nowe pozycje dopisz w miejscu wynikającym z sortowania;
  // niewymienione dostaną kolejne numery.
  tresc-dodatkowa: kolejnosc-bibliografii(
    <iso9126>,
    <przyklad2>,
    <NagraTC02>,
    <lctsc2017dataset>,
  ),
)

// \maketitle (w oryginale wyłączone):  #maketitle(meta)

// \tableofcontents + \thispagestyle{empty}
#spis-tresci()

// \setcounter{page}{0}; \pagestyle{plain} — numeracja zaczyna się od 1 na Wstępie
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

// \bibliography{bibliografia}
#bibliografia()

#spis-tabel()
#spis-rysunkow()
// \caption[krótki]{długi}: krótki podpis do spisu listingów
#spis-listingow(skroty: ("tomtorfs": [Tom Torfs - tomtorfs.c]))
#spis-algorytmow()

// \biblioteka{tak}  (w oryginale wyłączone):  #biblioteka(meta, zgoda: true)
