= Analiza wymagań

== Cel projektu

Celem projektu jest opracowanie i ocena modelu uczenia maszynowego umożliwiającego automatyczne rozpoznawanie gatunków muzycznych na podstawie sygnału audio. Zadanie polega na przyporządkowaniu utworu do jednej z wcześniej zdefiniowanych kategorii, takich jak rock, jazz, klasyka, hip-hop czy pop.

== Charakterystyka problemu

Rozpoznawanie gatunków muzycznych jest problemem klasyfikacji nadzorowanej. Model uczy się na podstawie utworów z przypisanymi etykietami, a następnie klasyfikuje nieznane próbki. Trudność wynika z podobieństw między gatunkami oraz różnorodności tempa, instrumentacji, aranżacji i jakości nagrań.

== Metody badawcze

W projekcie zostaną wykorzystane sieci neuronowe typu CNN oraz drzewa decyzyjne. Modele zostaną wytrenowane i przetestowane na przygotowanym zbiorze danych, a następnie porównane pod względem skuteczności rozpoznawania gatunków muzycznych. Dane zostaną podzielone na zbiór treningowy i testowy.

== Oczekiwane rezultaty

Oczekiwanym rezultatem jest opracowanie modelu klasyfikującego utwory muzyczne oraz porównanie skuteczności wybranych metod. Analiza pozwoli określić, które cechy audio i algorytmy sprawdzają się najlepiej oraz jakie ograniczenia występują w procesie klasyfikacji.

== Wymagania funkcjonalne

- Wczytanie nagrania audio i przygotowanie danych wejściowych (cechy akustyczne dla drzewa decyzyjnego, spektrogramy dla sieci CNN).
- Klasyfikacja utworu do jednego ze zdefiniowanych gatunków muzycznych.
- Ocena obu modeli na zbiorze testowym i porównanie ich wyników.

== Wymagania niefunkcjonalne

- Powtarzalność eksperymentów (stały podział danych i ziarno losowości).
- Ocena skuteczności za pomocą standardowych miar, takich jak dokładność, F1 i macierz pomyłek.

== Założenia i kwestie do ustalenia

Zbiór danych oraz lista rozpoznawanych gatunków nie zostały jeszcze wybrane i zostaną określone w kolejnych etapach projektu, z uwzględnieniem dostępności danych i konsultacji z ekspertem. Zakłada się, że każdy utwór jest przypisany do jednego gatunku.
