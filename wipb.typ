// =============================================================================
//  wipb.typ — szablon pracy dyplomowej WI PB
//  Odpowiednik klas LaTeX-a wipb3.cls + mbook.cls (xelatex, Times New Roman 12 pt)
//  Wymaga: Typst >= 0.13
//
//  Wartości liczbowe (marginesy, odstępy, wcięcia) zostały odmierzone na
//  wzorcowym main.pdf zbudowanym z wersji LaTeX-owej.
// =============================================================================

// ------------------------------------------------------------------ czcionki --
// main.tex: \setmainfont{Times New Roman}. Dalsze pozycje to zamienniki
// o identycznych metrykach, używane tylko gdy Times New Roman nie jest zainstalowany.
#let font-main = ("Times New Roman", "Liberation Serif", "Tinos")
// algorithm2e: \textsf (dane) i \texttt (funkcje) — w LaTeX-u Latin Modern
#let font-sans = ("Latin Modern Sans", "New Computer Modern Sans", "Liberation Sans")
#let font-mono = ("Latin Modern Mono", "New Computer Modern Mono")
// strona-tytulowa.pdf (LibreOffice): Liberation Sans Narrow (zamiennik Arial Narrow)
#let font-tytulowa = ("Liberation Sans Narrow", "Arial Narrow")

// -------------------------------------------------------------------- stałe ---
// \linespread{1.5} przy 12 pt: odstęp między liniami bazowymi 21,75 pt.
// W Typście "leading" liczy się od dołu linii (linia bazowa) do góry następnej
// (wysokość wersalików TNR ≈ 7,95 pt), więc 21,75 − 7,95 ≈ 13,8 pt.
#let interlinia = 13.8pt
// hyperref: urlcolor domyślnie magenta (linkcolor i citecolor ustawione na czarny)
#let kolor-url = rgb(255, 0, 255)

// ------------------------------------------------------------ drobne pomocnicze --
// \href{url}{tekst}
#let href(url, body) = link(url, text(fill: kolor-url, body))

// akapit bez wcięcia pierwszego wiersza (kontynuacja po wzorze wyświetlanym)
#let noindent(body) = {
  set par(first-line-indent: 0pt)
  body
}

// \paragraph{tytuł} — nagłówek śródakapitowy (pogrubiony, bez numeru)
#let paragraf(tytul, body) = block(above: 25.7pt, below: interlinia, {
  set par(first-line-indent: 0pt)
  strong(tytul)
  h(1em)
  body
})

// \ref{equ} zwracający sam numer równania (bez nawiasów), jak w LaTeX-u
#let eqref(etykieta) = link(etykieta, context {
  let rozdzial = counter(heading).at(etykieta).first()
  let nr = counter(math.equation).at(etykieta).first()
  numbering("1.1", rozdzial, nr)
})

// Numeracja pozycji bibliograficznych w kolejności alfabetycznej (jak plabbrv):
// Typst numeruje wg pierwszego cytowania, więc w main.typ wywołujemy
// niewidoczne cytowanie wszystkich pozycji w żądanej kolejności.
#let kolejnosc-bibliografii(..klucze) = place(top + left, hide({
  for k in klucze.pos() {
    cite(k)
  }
}))

// ------------------------------------------------------------- algorithm2e ----
#let kw(x) = strong(x)                                // słowa kluczowe: for, to, do, if, then, else, end
#let dane(x) = text(font: font-sans, x)               // \SetKwData  → bezszeryfowa
#let funk(nazwa, ..arg) = {                           // \SetKwFunction → maszynowa
  text(font: font-mono, nazwa)
  [(]
  arg.pos().join[,]
  [)]
}
// \SetKwInOut: etykieta pogrubiona, dopełnienie wyrównuje dwukropki
#let wejscie(etykieta, dopelnienie, body) = [#strong[#etykieta#h(dopelnienie):] #body]
// blok z pionową kreską po lewej (for … do … end)
#let blok(body) = block(
  above: 16.5pt,
  below: 16.5pt,
  inset: (left: 6.75pt),
  block(
    stroke: (left: 0.4pt),
    outset: (top: 4.7pt, bottom: 9pt),
    inset: (left: 11.55pt),
    body,
  ),
)
// środowisko algorithm ([ruled]) — numeracja ciągła: Algorytm 1, 2, …
#let algorytm(tytul, body) = figure(
  body,
  caption: tytul,
  kind: "algorithm",
  supplement: [Algorytm],
  numbering: "1",
)

// ----------------------------------------------------------- listings (lstlisting) --
// plik: ścieżka względem wipb.typ; rozmiar: \footnotesize = 10 pt, \normalsize = 12 pt
// ListingS używa stałej szerokości kolumny 0,6 em (LM Mono ma 0,525 em → tracking 0,075 em)
#let listing(
  plik,
  podpis: none,
  rozmiar: 10pt,
  ramka: false,
  podpis-na-dole: false,
) = {
  let kod = read(plik).trim("\n", at: end)
  let tresc = {
    set text(font: font-mono, size: rozmiar, tracking: 0.075em, hyphenate: false)
    set par(justify: false, first-line-indent: 0pt, leading: rozmiar * 1.18)
    raw(kod, block: true)
  }
  let blok = if ramka {
    block(
      width: 100%,
      stroke: 0.4pt,
      inset: (x: 3pt, top: 10.8pt, bottom: 9.5pt),
      tresc,
    )
  } else {
    tresc
  }
  figure(
    blok,
    kind: raw,
    supplement: [Listing],
    caption: if podpis == none {
      none
    } else {
      figure.caption(position: if podpis-na-dole { bottom } else { top }, podpis)
    },
  )
}

// --------------------------------------------------------- rozdział bez numeru --
// odpowiednik \chapter*{…} (Spis treści, Bibliografia, Spis tabel …)
#let rozdzial-bez-numeru(body) = heading(level: 1, numbering: none, outlined: false, body)

// ------------------------------------------------------------ spisy (toc, lof…) --
// jedna pozycja spisu: wcięcie, szerokość numeru, wiodące kropki (\@dottedtocline)
#let _wpis(
  loc,
  wciecie,
  szer,
  numer,
  tekst,
  pogrubiony: false,
  kropki: true,
  nad: interlinia,
) = {
  let strona = numbering("1", ..counter(page).at(loc))
  block(width: 100%, above: nad, below: interlinia, {
    set par(first-line-indent: 0pt, justify: false, hanging-indent: wciecie + szer)
    set text(weight: if pogrubiony { "bold" } else { "regular" })
    link(loc)[#h(wciecie)#box(width: szer, numer)#tekst#if kropki [#box(width: 1fr, repeat(gap: 0.5em)[.])#h(1em)] else [#h(1fr)]#box(width: 1.5em, align(right, strona))]
  })
}

#let spis-tresci(tytul: [Spis treści]) = {
  rozdzial-bez-numeru(tytul)
  context {
    let pierwszy = true
    for h in query(heading.where(outlined: true)) {
      let loc = h.location()
      let numer = if h.numbering != none {
        numbering(h.numbering, ..counter(heading).at(loc))
      } else {
        none
      }
      if h.level == 1 {
        // \l@chapter: 1 em odstępu nad wpisem, pogrubienie, brak kropek
        let nad = if pierwszy { 65.8pt } else { 25.8pt }
        pierwszy = false
        _wpis(loc, 0pt, 1.5em, numer, h.body, pogrubiony: true, kropki: false, nad: nad)
      } else if h.level == 2 {
        _wpis(loc, 1.5em, 2.3em, numer, h.body)
      } else if h.level == 3 {
        _wpis(loc, 3.8em, 3.2em, numer, h.body)
      } else {
        _wpis(loc, 7em, 4.1em, numer, h.body)
      }
    }
  }
}

// spis tabel / rysunków / listingów / algorytmów
// skroty: słownik "etykieta" → krótki podpis do spisu (\caption[krótki]{długi})
#let _spis(tytul, selektor, algorytmy: false, skroty: (:)) = {
  rozdzial-bez-numeru(tytul)
  context {
    for f in query(selektor) {
      if f.caption == none { continue }
      let loc = f.location()
      let n = counter(figure.where(kind: f.kind)).at(loc).first()
      let numer = if algorytmy {
        str(n)
      } else {
        str(counter(heading).at(loc).first()) + "." + str(n)
      }
      let tekst = f.caption.body
      if f.label != none and str(f.label) in skroty {
        tekst = skroty.at(str(f.label))
      }
      _wpis(loc, if algorytmy { 1em } else { 1.5em }, 2.3em, numer, tekst)
    }
  }
}

#let spis-tabel(tytul: [Spis tabel]) = _spis(tytul, figure.where(kind: table))
#let spis-rysunkow(tytul: [Spis rysunków]) = _spis(tytul, figure.where(kind: image))
#let spis-listingow(tytul: [Spis listingów], skroty: (:)) = _spis(tytul, figure.where(kind: raw), skroty: skroty)
#let spis-algorytmow(tytul: [Spis algorytmów]) = _spis(tytul, figure.where(kind: "algorithm"), algorytmy: true)

// ------------------------------------------------------------- bibliografia ---
// plabbrv (BibTeX) → najbliższy styl wbudowany w Typst: IEEE (inicjały imion, numeracja [n])
#let bibliografia(plik: "bibliografia.bib", tytul: [Bibliografia]) = {
  show bibliography: set heading(outlined: false)
  show bibliography: set par(
    first-line-indent: 0pt,
    justify: true,
    leading: interlinia,
    spacing: 23.8pt,
  )
  bibliography(plik, title: tytul, style: "ieee")
}

// ------------------------------------------------------------- strona tytułowa --
// Odtworzenie strona-tytulowa.pdf (w main.tex włączanej przez \includepdf).
// Współrzędne to linie bazowe odmierzone na oryginale (A4, pt).
// wypelnij: false → puste pola z kropkami (jak w oryginale); true → dane z `meta`.
#let strona-tytulowa(meta: (:), wypelnij: false, tresc-dodatkowa: none) = {
  let pole(klucz, kropek) = {
    let v = meta.at(klucz, default: none)
    if wypelnij and v != none { v } else { "." * kropek }
  }
  let w(x, y, rozmiar, tresc, waga: "regular", styl: "normal") = place(
    top + left,
    dx: x,
    dy: y,
    text(size: rozmiar, weight: waga, style: styl, top-edge: "baseline", bottom-edge: "baseline", tresc),
  )
  let sr(y, rozmiar, tresc, waga: "regular") = place(
    top + left,
    dy: y,
    block(
      width: 100%,
      align(center, text(size: rozmiar, weight: waga, top-edge: "baseline", bottom-edge: "baseline", tresc)),
    ),
  )
  let typ = upper(meta.at("typ-pracy", default: "inżynierska"))
  let rok = datetime.today().year()

  page(margin: 0pt, numbering: none, footer: none)[
    #set par(first-line-indent: 0pt, justify: false)
    #set text(font: font-tytulowa, lang: "pl", fill: black)
    #tresc-dodatkowa
    #sr(64.2pt, 20pt, "POLITECHNIKA BIAŁOSTOCKA", waga: "bold")
    #sr(103.5pt, 14pt, "WYDZIAŁ INFORMATYKI", waga: "bold")
    #sr(162.6pt, 18pt, [PRACA DYPLOMOWA #typ])
    #w(71pt, 235.3pt, 14pt, [TEMAT: #pole("temat", 110)])
    #w(248pt, 362.2pt, 14pt, [WYKONAWCA: #pole("autor", 49)])
    #w(389.6pt, 378pt, 11pt, [imiona i nazwisko], styl: "italic")
    #w(71pt, 487.4pt, 14pt, [OPIEKUN PRACY DYPLOMOWEJ : #pole("promotor", 51)])
    #w(303.4pt, 503.2pt, 11pt, [imiona i nazwisko], styl: "italic")
    #if wypelnij {
      sr(729.9pt, 14pt, [#strong[BIAŁYSTOK] #rok #strong[ROK]])
    } else {
      sr(729.9pt, 14pt, [#strong[BIAŁYSTOK] #("." * 12) #strong[ROK]])
    }
  ]
}

// Tytułowa „klasowa” (\maketitle z wipb3.cls) — w main.tex wyłączona, jak w oryginale.
// W LaTeX-u \textsc przy Times New Roman nie zmienia wyglądu, więc tu zwykły tekst.
#let maketitle(meta) = page(numbering: none)[
  #set par(first-line-indent: 0pt, justify: false)
  #set align(center)
  #text(size: 24.88pt)[Politechnika Białostocka]
  #v(0.3fr)
  #text(size: 20.74pt)[Wydział Informatyki]
  #v(0.3fr)
  #text(size: 17.28pt)[Katedra #meta.katedra]
  #v(1fr)
  #text(size: 20.74pt)[Praca dyplomowa \ #meta.at("typ-pracy")]
  #v(2fr)
  #text(size: 24.88pt)[Temat: #meta.temat]
  #v(2fr)
  #align(right, text(size: 20.74pt)[Wykonawca: #meta.autor])
  #v(1fr)
  #align(left, text(size: 20.74pt)[Opiekun pracy dyplomowej: #meta.promotor])
  #v(2fr)
  #text(size: 20.74pt)[Białystok #datetime.today().year() r.]
]

// \biblioteka{tak/nie} — oświadczenie o udostępnieniu pracy w Bibliotece PB
#let _miesiace = (
  "stycznia", "lutego", "marca", "kwietnia", "maja", "czerwca",
  "lipca", "sierpnia", "września", "października", "listopada", "grudnia",
)
#let biblioteka(meta, zgoda: true) = page(numbering: none)[
  #set par(first-line-indent: 0pt)
  #v(2cm)
  #align(center, text(size: 17.28pt)[Oświadczenie])
  #v(2cm)
  Ja, #meta.autor, #if zgoda [wyrażam zgodę] else [nie wyrażam zgody] na udostępnienie mojej pracy dyplomowej, pt: „#meta.temat” w Bibliotece Politechniki Białostockiej.
  #v(2cm)
  #align(right)[
    #box(width: 30%)[
      #set align(center)
      #("." * 35) \
      #{
        let d = datetime.today()
        [#d.day() #_miesiace.at(d.month() - 1) #d.year()]
      } \
      #text(size: 10pt)[czytelny podpis]
    ]#h(1cm)
  ]
]

// =============================================================================
//  Szablon dokumentu: `#show: wipb.with(...)`
// =============================================================================
#let wipb(autor: "", temat: "", slowa-kluczowe: (), body) = {
  set document(author: autor, title: temat, keywords: slowa-kluczowe)

  // \textwidth 15.5 cm, \oddsidemargin 3.5 cm, \textheight 23.5 cm.
  // Góra: dopasowana tak, by pierwsza linia bazowa leżała jak w LaTeX-u
  // (79,5 pt + topskip 12 pt − wysokość wersalików 7,95 pt).
  set page(
    paper: "a4",
    margin: (left: 3.5cm, right: 2cm, top: 83.6pt, bottom: 96.3pt),
    footer-descent: 22pt,
  )

  set text(font: font-main, size: 12pt, lang: "pl", region: "PL")
  set par(
    justify: true,
    leading: interlinia,
    spacing: interlinia,
    // \parindent=1cm + pakiet indentfirst (wcięcie także po nagłówkach)
    first-line-indent: (amount: 1cm, all: true),
  )

  show raw: set text(font: font-mono)

  // ------------------------------------------------------------- nagłówki ----
  set heading(numbering: "1.1")
  show heading: it => {
    let numer = if it.numbering != none {
      counter(heading).display(it.numbering)
    } else {
      none
    }
    if it.level == 1 {
      // \chapter: nowa strona, tytuł \Large\bfseries, numer z kropką
      pagebreak(weak: true)
      if it.numbering != none {
        // numeracja rysunków, tabel, listingów i równań liczona w obrębie rozdziału
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: table)).update(0)
        counter(figure.where(kind: raw)).update(0)
        counter(math.equation).update(0)
        counter(footnote).update(0)
      } else {
        // \chapter*: \vspace*{50pt} + dodatkowy odstęp zmierzony na wzorcu
        v(82.7pt)
      }
      let kopf = if numer != none { numer + [. ] + it.body } else { it.body }
      block(
        width: 100%,
        above: 0pt,
        below: if it.numbering == none { 53.8pt } else { 38.7pt },
        sticky: true,
        {
          set par(first-line-indent: 0pt, justify: false)
          set text(size: 17.28pt, weight: "bold", top-edge: 7.94pt)
          kopf
        },
      )
    } else {
      // \section, \subsection: \large\bfseries, numer + 1 em
      let kopf = if numer != none { numer + h(1em) + it.body } else { it.body }
      block(
        width: 100%,
        above: 31pt,
        below: 25.7pt,
        sticky: true,
        {
          set par(first-line-indent: 0pt, justify: false)
          set text(size: 14.4pt, weight: "bold", top-edge: 7.94pt)
          kopf
        },
      )
    }
  }

  // -------------------------------------------------------- rysunki, tabele ----
  set figure(
    gap: 17pt,
    numbering: (..n) => numbering("1.1", counter(heading).get().first(), ..n),
  )
  show figure.where(kind: image): set figure(supplement: [Rysunek])
  show figure.where(kind: table): set figure(supplement: [Tabela])
  show figure.where(kind: raw): set figure(supplement: [Listing])
  // caption: tableposition=top
  show figure.where(kind: table): set figure.caption(position: top)
  // listingi mogą się łamać między stronami
  show figure.where(kind: raw): set block(breakable: true)
  show figure: set block(above: 19.8pt, below: 19.8pt)
  show figure: set par(first-line-indent: 0pt)
  show figure.caption: set par(justify: true)

  // tabela: \tabcolsep 6 pt, wiersz 21,75 pt (strut przy \linespread{1.5}), linie 0,4 pt
  set table(stroke: 0.4pt, inset: (x: 6pt, top: 7.3pt, bottom: 6.5pt))
  show table: set par(first-line-indent: 0pt)

  // algorithm2e [ruled]
  show figure.where(kind: "algorithm"): it => {
    let regula = block(width: 100%, height: 0pt, spacing: 0pt, stroke: (top: 0.8pt))
    block(width: 100%, above: 19.8pt, below: 19.8pt, breakable: false, {
      set par(first-line-indent: 0pt, justify: false)
      set block(spacing: 0pt)
      regula
      block(inset: (left: 9pt, top: 3pt, bottom: 4.5pt))[
        #strong[#it.supplement #counter(figure.where(kind: "algorithm")).display("1"):] #it.caption.body
      ]
      regula
      block(inset: (left: 18.3pt, top: 3pt, bottom: 8pt), it.body)
      regula
    })
  }

  // ------------------------------------------------------------------ listy ----
  // \leftmargini 2,5 em, \labelsep 0,5 em, \itemsep+\parsep ≈ 10 pt
  set list(indent: 1.65em, body-indent: 0.5em, spacing: 23.8pt)
  set enum(indent: 1.25em, body-indent: 0.5em, spacing: 23.8pt, numbering: "1.")
  show list: set par(first-line-indent: 0pt)
  show enum: set par(first-line-indent: 0pt)

  // ----------------------------------------------------------------- wzory ----
  set math.equation(numbering: (..n) => numbering("(1.1)", counter(heading).get().first(), ..n))
  show math.equation.where(block: true): set block(above: 23pt, below: 23pt)

  // ------------------------------------------------------------ przypisy -----
  set footnote.entry(separator: line(length: 40%, stroke: 0.4pt))
  show footnote.entry: set text(size: 10pt)
  show footnote.entry: set par(first-line-indent: 0pt)

  body
}
