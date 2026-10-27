= Analiza wymagań

== Cel projektu

Celem projektu jest opracowanie i ocena modelu uczenia maszynowego umożliwiającego automatyczne rozpoznawanie gatunków muzycznych na podstawie sygnału audio. Zadanie polega na przyporządkowaniu utworu do jednej z *5 wcześniej zdefiniowanych kategorii (gatunków)* wybranych ze zbioru FMA (por. podrozdział _Zakres danych i kryteria sukcesu_). Sukces projektu mierzony jest ilościowo: celem jest osiągnięcie przez sieć CNN wartości macro-F1 co najmniej 0,60 oraz F1 co najmniej 0,50 dla co najmniej 3 z 5 gatunków, a przez drzewo decyzyjne macro-F1 co najmniej 0,45 (szczegóły w @tab:cele).

== Charakterystyka problemu

Rozpoznawanie gatunków muzycznych jest problemem klasyfikacji nadzorowanej. Model uczy się na podstawie utworów z przypisanymi etykietami, a następnie klasyfikuje nieznane próbki. Trudność wynika z podobieństw między gatunkami oraz różnorodności tempa, instrumentacji, aranżacji i jakości nagrań.

== Metody badawcze

W projekcie zostaną wykorzystane sieci neuronowe typu CNN oraz drzewa decyzyjne. Modele zostaną wytrenowane i przetestowane na przygotowanym zbiorze danych, a następnie porównane pod względem skuteczności rozpoznawania gatunków muzycznych. Dane zostaną podzielone na zbiór treningowy, walidacyjny i testowy w proporcji 70/15/15, przy czym podział będzie rozłączny względem wykonawców (żaden wykonawca nie wystąpi w więcej niż jednym zbiorze) @flexer2007artist.

== Oczekiwane rezultaty

Oczekiwanym rezultatem jest opracowanie modelu klasyfikującego utwory muzyczne oraz porównanie skuteczności wybranych metod. Analiza pozwoli określić, które cechy audio i algorytmy sprawdzają się najlepiej oraz jakie ograniczenia występują w procesie klasyfikacji.

== Zakres danych i kryteria sukcesu

Zbiorem głównym jest FMA-medium, w którym dostępnych jest 16 gatunków nadrzędnych o bardzo nierównej liczebności @defferrard2017fma. Do eksperymentów wybrano *5 gatunków*: Classical, Hip-Hop, Jazz, Pop i Rock. Liczba ta pozwala utrzymać zbalansowane klasy przy rozsądnej liczbie nagrań. Przy 5 klasach skuteczność klasyfikatora losowego wynosi 20%, co jest punktem odniesienia dla wyników. Liczebność klas zostanie wyrównana przez losowe ograniczenie liczby utworów do najmniejszej z wybranych klas (nie mniej niż 300 utworów na klasę). // TODO: zatwierdzić listę po sprawdzeniu liczebności klas w tracks.csv

Do oceny na danych z innego źródła wykorzystany zostanie zbiór GTZAN @tzanetakis2002 ograniczony do *5 gatunków wspólnych* z listą FMA: Classical, Hip-Hop, Jazz, Pop i Rock.

*Kryteria sukcesu.* Przyjęto następujące cele ilościowe. Mają one charakter roboczy i zostaną zweryfikowane po pierwszym eksperymencie wstępnym.

#figure(
  table(
    columns: (1fr, 2.6cm, 3.6cm),
    align: (left, center, center),
    stroke: none,
    inset: (x: 5pt, y: 4pt),
    table.hline(stroke: 0.8pt),
    table.header(
      [*Kryterium*], [*CNN*], [*Drzewo decyzyjne*],
    ),
    table.hline(stroke: 0.5pt),
    [macro-F1 na zbiorze testowym FMA (5 klas)], [≥ 0,60], [≥ 0,45],
    [liczba klas z F1 ≥ 0,50 (udział klas)], [≥ 3 z 5 (60%)], [≥ 2 z 5 (40%)],
    [najgorsza klasa: F1], [≥ 0,30], [≥ 0,20],
    [macro-F1 na GTZAN (5 klas wspólnych)], [≥ 0,40], [≥ 0,30],
    [powtarzalność: odchylenie standardowe macro-F1 z 3 ziaren], [≤ 0,03], [≤ 0,03],
    table.hline(stroke: 0.8pt),
  ),
  caption: [Cele ilościowe projektu],
) <tab:cele>

Wartości te należy odnosić do skuteczności klasyfikatora losowego (20% przy 5 klasach, zarówno na FMA, jak i na GTZAN). Za wynik minimalny, poniżej którego eksperyment uznaje się za nieudany, przyjmuje się macro-F1 niższe niż dwukrotność tej wartości. O przewadze jednej metody nad drugą wnioskuje się wyłącznie wtedy, gdy różnica macro-F1 przekracza zmienność między uruchomieniami (3 ziarna losowości) i mieści się poza 95% przedziałem ufności wyznaczonym metodą bootstrap. Dodatkowo raportowana będzie dokładność (accuracy) oraz macierz pomyłek.

== Wymagania funkcjonalne

- Wczytanie nagrania audio i przygotowanie danych wejściowych (cechy akustyczne dla drzewa decyzyjnego, spektrogramy dla sieci CNN).
- Klasyfikacja utworu do jednego ze zdefiniowanych gatunków muzycznych.
- Ocena obu modeli na zbiorze testowym i porównanie ich wyników.

== Wymagania niefunkcjonalne

- Powtarzalność eksperymentów (stały podział danych rozłączny względem wykonawców, zapisane ziarno losowości, 3 uruchomienia z różnymi ziarnami).
- Ocena skuteczności za pomocą standardowych miar: macro-F1 (miara główna), dokładność, F1 dla każdej klasy i macierz pomyłek.

== Założenia i kwestie do ustalenia

Zakłada się, że każdy utwór jest przypisany do jednego gatunku, a jako etykiety przyjmowany jest gatunek nadrzędny z metadanych FMA. Zbiór główny (FMA-medium) i zbiór pomocniczy (GTZAN) zostały wybrane na podstawie analizy opisanej w rozdziale 3. Do ostatecznego zatwierdzenia pozostają: lista 5 gatunków (po sprawdzeniu liczebności klas) oraz progi z @tab:cele, które mogą zostać skorygowane po eksperymencie wstępnym.
