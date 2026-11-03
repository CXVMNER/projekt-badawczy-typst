= Zakres projektu i harmonogram

== Zakres projektu

Projekt obejmuje następujące elementy:

- *Przygotowanie danych.* Pobranie i przygotowanie podzbioru FMA-medium (5 gatunków: Classical, Hip-Hop, Jazz, Pop, Rock) z podziałem rozłącznym względem wykonawców (70/15/15). Przygotowanie analogicznego podzbioru GTZAN do testów transferu.
- *Ekstrakcja cech i reprezentacji.* Wyznaczenie cech akustycznych (MFCC, chroma, tempo, charakterystyki widmowe) za pomocą librosa/Essentia oraz generowanie mel-spektrogramów.
- *Modele.* Implementacja i trenowanie drzewa decyzyjnego (scikit-learn) oraz sieci CNN (PyTorch) w jednolitym protokole eksperymentalnym.
- *Ewaluacja.* Obliczenie macro-F1, F1 per klasa, dokładności i macierzy pomyłek; testy powtarzalności (3 ziarna); ocena na GTZAN; analiza istotności różnic (bootstrap).
- *Dokumentacja i kod.* Opis wyników, wnioski, repozytorium z kodem odtwarzającym eksperymenty (bez rozpowszechniania nagrań).

Poza zakresem pozostają: zadanie wieloetykietowe, trening od zera modeli typu transformer na pełnym FMA-large, komercyjne wdrożenie oraz majority voting z więcej niż dwoma modelami (może być rozważone jako rozszerzenie).

== Harmonogram

Harmonogram obejmuje okres od października 2026 do końca stycznia 2027 (zakończenie przed końcem stycznia). Uwzględnia zadania już wykonane oraz planowane etapy. Diagram Gantta pokazuje nakładanie się prac.

#figure(
  {
    set text(size: 8pt)

    let periods = (
      [X 1–15],
      [X 16–31],
      [XI 1–15],
      [XI 16–30],
      [XII 1–15],
      [XII 16–31],
      [I 1–15],
      [I 16–31],
    )

    // Zadanie, początek, koniec (wyłącznie), wykonane
    let tasks = (
      ([Konsultacje i przegląd literatury], 0, 2, true),
      ([Wybór zbiorów i kryteriów sukcesu], 0, 3, true),
      ([Analiza wymagań i hipoteza], 1, 3, true),
      ([Przygotowanie danych FMA + GTZAN], 2, 4, false),
      ([Ekstrakcja cech i spektrogramów], 3, 5, false),
      ([Implementacja drzewa decyzyjnego], 4, 6, false),
      ([Implementacja i trening CNN], 4, 7, false),
      ([Ewaluacja i porównanie modeli], 6, 8, false),
      ([Testy na GTZAN + analiza], 6, 8, false),
      ([Redakcja pracy i dokumentacja kodu], 4, 8, false),
    )

    let n = periods.len()
    let cell-w = 1.2cm
    let label-w = 5.8cm
    let row-h = 0.55cm

    block(
      stroke: 0.4pt,
      inset: 0pt,
      {
        // Nagłówek
        grid(
          columns: (label-w, ..(cell-w,) * n),
          rows: row-h,
          fill: luma(230),
          stroke: 0.3pt,
          align: center + horizon,
          [*Zadanie*],
          ..periods.map(p => strong(p)),
        )

        // Wiersze z zadaniami
        for (i, (name, from, to, done)) in tasks.enumerate() {
          let bg = if calc.even(i) {
            luma(250)
          } else {
            white
          }

          grid(
            columns: (label-w, ..(cell-w,) * n),
            rows: row-h,
            fill: bg,
            stroke: 0.3pt,
            align: (left + horizon, ..(center + horizon,) * n),
            inset: (x: 4pt, y: 2pt),
            text(size: 8pt, name),

            ..range(n).map(j => {
              if j >= from and j < to {
                rect(
                  width: 100%,
                  height: 70%,
                  fill: if done {
                    rgb("#2e7d32")
                  } else {
                    rgb("#1565c0")
                  },
                  radius: 1pt,
                )
              } else {
                []
              }
            }),
          )
        }
      },
    )

    v(0.4em)

    // Legenda
    grid(
      columns: (auto, auto, auto, auto),
      column-gutter: 1.2em,
      align: horizon,

      rect(
        width: 12pt,
        height: 8pt,
        fill: rgb("#2e7d32"),
        radius: 1pt,
      ),
      text(size: 8.5pt)[wykonane],

      rect(
        width: 12pt,
        height: 8pt,
        fill: rgb("#1565c0"),
        radius: 1pt,
      ),
      text(size: 8.5pt)[planowane],
    )
  },
  caption: [
    Diagram Gantta projektu w podziale na okresy dwutygodniowe
    (październik 2026 – styczeń 2027).
    Zielone paski oznaczają zadania już zrealizowane,
    a niebieskie – zadania planowane.
  ],
) <fig:gantt>

*Komentarz do harmonogramu.*
- Październik 2026: konsultacje (ekspert + GenAI) i przegląd literatury – *zakończone*.
- Październik–listopad 2026: wybór FMA/GTZAN, kryteria sukcesu, analiza wymagań i hipoteza – *zakończone* (stan na początek listopada).
- Listopad 2026: przygotowanie podzbioru danych oraz ekstrakcja cech i spektrogramów.
- Grudzień 2026: implementacja drzewa decyzyjnego i sieci CNN, początek redakcji.
- Styczeń 2027 (do końca miesiąca): dokończenie treningu CNN, ewaluacja, testy na GTZAN, dokumentacja kodu i zamknięcie tekstu pracy.

Harmonogram jest napięty i zakłada równoległą pracę nad kodem i tekstem oraz dostęp do GPU (lub równoważnych zasobów) do treningu CNN.
