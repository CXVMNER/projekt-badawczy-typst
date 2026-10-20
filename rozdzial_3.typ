#import "wipb.typ": *

= Przykładowy rozdział // deklarowanie rozdziału

== Wypunktowania
+ punkt
+ punkt
+ wypunkowania można mieszać
  #list(indent: 1.35em, body-indent: 0.5em, spacing: 19.8pt)[punkt][punkt]
+ punkt
  #enum(numbering: "(a)", indent: 0.59em, body-indent: 0.5em, spacing: 19.8pt)[punkt][punkt]

== Cytowania
Tak cytujemy @NagraTC02 lub kilka @NagraTC02 @iso9126 @godot_book albo @NagraTC02[str. 3]. Zasoby internetowe powinny zawierać datę dostępu @lctsc2017dataset @godot_docs.

== Tabele

#figure(
  table(
    columns: 3,
    align: center + horizon,
    table.cell(colspan: 2, rowspan: 2)[combined cells], [top right],
    [middle right],
    [bottom left], [bottom center], [bottom right],
  ),
  caption: [Przykładowa tabela],
  placement: bottom,
) <tab:prz>

Przykład formatowania #ref(<tab:prz>, supplement: [Tabeli]). Tak właśnie odwołujemy się do~tabel. // ~ zapobiega łamaniu wierszy w danym miejscu

=== Rysunki
Rysunki najlepiej dodawać w formacie EPS. Rysunek~#ref(<fig:przyklad>, supplement: none) w taki sposób odwołujemy się do rysunków. Narzędzia jak pdflatex pozwalają wykorzystać bitmapy w formatach jak PNG (patrz Rys.~#ref(<fig:przyklad2>, supplement: none)).

// Typst nie czyta EPS — rysunek został skonwertowany do wektorowego SVG
// (zapasowy PNG 300 dpi: grafika/ps03impulse.png)
#figure(
  image("grafika/ps03impulse.svg", width: 100%),
  caption: [Opis rysunku w formacie EPS],
  placement: top,
) <fig:przyklad>

#figure(
  image("grafika/abvol2.png", width: 10cm),
  caption: [Opis rysunku w formacie PNG],
  placement: top,
) <fig:przyklad2>

#paragraf[Równania][Równania matematyczne tworzymy przez:]
$ R_(i,j) = H(epsilon_i - bar.v.double x_i - x_j) $ <equa:rr>
#noindent[W Równaniu~#eqref(<equa:rr>) przedstawiono …lub małe wstawki matematyczne $R_(i,j) = H(epsilon_i - bar.v.double x_i - x_j)$ w tej samej lini lub w nowej]
#[
  #set math.equation(numbering: none)
  $ R_(i,j) = H(epsilon_i - bar.v.double x_i - x_j) $
]
#noindent[.]

== Listingi
Korzystając ze środowiska listings możemy formatować listingi.
#listing(
  "listings/tomtorfs.c",
  rozmiar: 10pt,
  podpis: [Zwycięzca 14th International Obfuscated C Code Contest w kategorii Best Self-Documenting - Tom Torfs],
) <tomtorfs>
Na Listingu~#ref(<tomtorfs>, supplement: none) przedstawiono listing bez ramki a na Listingu~#ref(<ramka>, supplement: none) z ramką.

#listing(
  "listings/ramka.c",
  rozmiar: 12pt,
  ramka: true,
  podpis: [Listing z ramką],
  podpis-na-dole: true,
) <ramka>

== Algorytmy
Algorytm~#ref(<algo_disjdecomp>, supplement: none) przedstawia …

#algorytm([Disjoint decomposition])[
  #wejscie("input", 0.55em)[A bitmap $I m$ of size $w times l$]

  #wejscie("output", 0em)[A partition of the bitmap]

  #v(5.3pt)
  _special treatment of the first line_;

  #kw[for] $i arrow.l 2$ #kw[to] $l$ #kw[do]
  #blok[
    _special treatment of the first element of line $i$_;

    #kw[for] $j arrow.l 2$ #kw[to] $w$ #kw[do]
    #blok[
      #dane[left] $arrow.l$ #funk("FindCompress", [$I m[i, j - 1]$]);

      #dane[up] $arrow.l$ #funk("FindCompress", [$I m[i - 1, ]$]);

      #dane[this] $arrow.l$ #funk("FindCompress", [$I m[i, j]$]);

      #kw[if] #dane[left] _compatible with_ #dane[this] #kw[then]
      #blok[
        #kw[if] #dane[left] $<$ #dane[this] #kw[then] #funk("Union", dane[left], dane[this]);

        ; // pusty wiersz z średnikiem — artefakt \lIf{…}{…}\; w oryginale

        #kw[else] #funk("Union", dane[this], dane[left]);
      ]
      #kw[end]

      #kw[if] #dane[up] _compatible with_ #dane[this] #kw[then]
      #blok[
        #kw[if] #dane[up] $<$ #dane[this] #kw[then] #funk("Union", dane[up], dane[this]);

        ;

        #kw[else] #funk("Union", dane[this], dane[up]);
      ]
      #kw[end]
    ]
    #kw[end]

    #kw[foreach] _element_ $e$ _of the line_ $i$ #kw[do] #funk("FindCompress", [$p$]);
  ]
  #kw[end]
] <algo_disjdecomp>

#pagebreak()
== Schematy

Schematy można wykonać przy użyciu środowiska tikz #footnote[Przykład zaczerpnięty ze strony @przyklad2]:
// Diagram TikZ (mindmap) przeniesiony jako wektorowy SVG; zapasowy PNG: grafika/schemat_mindmap.png
#figure(
  image("grafika/schemat_mindmap.svg", width: 421pt),
  caption: [Computer science mindmap],
) <fig:mindmap>

== Podsumowanie
Do składania prac dyplomowych polecam wieloplatformowy edytor #href("https://www.xm1math.net/texmaker/")[TexMaker] wraz z~dystrybucją  #href("http://miktex.org/")[MikTeX] lub TeX Live.
