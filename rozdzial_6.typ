= Szczegółowa specyfikacja projektu i opis wymagań

== Specyfikacja problemu

Problem sprowadza się do klasyfikacji wieloklasowej (5 klas) sygnału audio. Każda próbka to fragment nagrania o długości 30 s (standard FMA/GTZAN). Etykieta jest gatunkiem nadrzędnym z metadanych. Model zwraca jedną z klas: Classical, Hip-Hop, Jazz, Pop, Rock.

*Wejście:*
- dla drzewa decyzyjnego – wektor cech akustycznych (rzędu 50–150 wymiarów, w zależności od konfiguracji ekstraktora),
- dla CNN – mel-spektrogram (np. 128 pasm × T ramek, normalizowany).

*Wyjście:* etykieta klasy oraz (opcjonalnie) wektor prawdopodobieństw.

== Architektura rozwiązań

=== Drzewo decyzyjne

- Ekstrakcja cech: librosa (lub Essentia) – MFCC (i ich delty), chroma, spectral centroid/bandwidth/rolloff, zero-crossing rate, tempo.
- Klasyfikator: `DecisionTreeClassifier` lub `RandomForestClassifier` z scikit-learn.
- Strojenie: głębokość drzewa, minimalna liczba próbek w liściu, liczba drzew (w przypadku lasu) – siatka lub optymalizacja bayesowska na zbiorze walidacyjnym.
- Interpretacja: ranking ważności cech (feature importance / permutation importance).

=== Sieć CNN

- Wejście: mel-spektrogram (log-amplituda).
- Architektura bazowa: kilka bloków konwolucyjnych (3×3 lub 5×5) + pooling + warstwy w pełni połączone + softmax; możliwa lekka adaptacja znanego modelu (np. uproszczona musicnn lub CRNN).
- Regularizacja: dropout, early stopping na macro-F1 walidacyjnym.
- Optymalizator: Adam; funkcja straty: cross-entropy (ew. ważona przy residualnej nierównowadze).

Oba modele są trenowane i ewaluowane w tym samym podziale danych i z tymi samymi miarami, co umożliwia bezpośrednie porównanie.

== Specyfikacja danych

- *FMA-medium (główny):* 5 wybranych gatunków, zbalansowane do min. 300 utworów/klasa, podział 70/15/15 rozłączny względem wykonawcy.
- *GTZAN (kontrolny):* te same 5 gatunków, wyłącznie do testu finalnego (bez dotrenowywania).
- Brak rozpowszechniania plików audio – w repozytorium tylko identyfikatory i skrypty pobierania.

== Specyfikacja ewaluacji

Miary główne i pomocnicze:
- macro-F1 (główna),
- F1 per klasa,
- accuracy,
- macierz pomyłek,
- odchylenie standardowe macro-F1 z 3 niezależnych ziaren,
- 95% przedział ufności bootstrap dla różnicy macro-F1 między modelami.

Kryteria sukcesu i hipoteza – zgodnie z @tab:cele i rozdziałem 4.

== Wymagania funkcjonalne (uszczegółowione)

1. Pipeline wczytywania metadanych FMA i budowy podzbioru z podziałem artist-filtered.
2. Funkcje ekstrakcji cech i generowania mel-spektrogramów z możliwością cache’owania wyników.
3. Trening i zapis modeli (checkpointy).
4. Skrypt ewaluacji generujący tabele i wykresy (macierz pomyłek, ranking cech).
5. Możliwość uruchomienia pełnego eksperymentu z zadanym ziarnem (reproducibility).

== Wymagania niefunkcjonalne (uszczegółowione)

- *Powtarzalność:* stałe ziarna, zapisany podział, wersje bibliotek w `requirements.txt` / `environment.yml`.
- *Wydajność:* trening CNN na pojedynczej karcie GPU (lub CPU w trybie ograniczonym) w czasie akceptowalnym w harmonogramie (rzędu godzin, nie dni).
- *Czytelność kodu:* modularność (dane / cechy / modele / ewaluacja), komentarze, README.
- *Zgodność licencyjna:* brak dystrybucji nagrań; atrybucja źródeł; modele traktowane jako niekomercyjne przy danych NC.

== Interfejsy i narzędzia

- Język: Python 3.10+.
- Biblioteki: librosa, scikit-learn, PyTorch (lub TensorFlow), numpy, pandas, matplotlib/seaborn.
- Opcjonalnie Essentia do porównania ekstraktorów cech.
- Kontrola wersji: Git; wyniki eksperymentów logowane (np. CSV + wykresy).

== Kryteria akceptacji

Projekt uznaje się za zrealizowany, gdy:
- oba modele osiągną wyniki powyżej progu „nieudanego eksperymentu” (macro-F1 ≥ 0,40 na FMA),
- hipoteza badawcza zostanie zweryfikowana (potwierdzona lub obalona) na podstawie zadeklarowanych testów statystycznych,
- kod pozwala odtworzyć główne tabele wyników,
- dokumentacja opisuje ograniczenia (jakość etykiet FMA, wady GTZAN, zasoby obliczeniowe).
