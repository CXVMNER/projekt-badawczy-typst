#import "wipb.typ": *
= Tło projektu

W celu pogłębienia wiedzy dotyczącej tematyki projektu oraz odpowiedniego przygotowania do jego realizacji przeprowadzono konsultacje z ekspertem oraz dokonano analizy istniejących rozwiązań o podobnym charakterze. Działania te miały na celu rozpoznanie dostępnych metod, identyfikację potencjalnych źródeł danych oraz wybór podejść badawczych, które mogą zostać wykorzystane w dalszych etapach prac.

== Konsultacja z ludzkim ekspertem

W ramach przygotowań do realizacji projektu skonsultowano się z profesorem Jackiem Grekowem, aby uzyskać wskazówki dotyczące możliwych kierunków rozwoju rozwiązania. Podczas rozmowy poruszono zagadnienia związane z dostępnością gotowych modeli, pozyskiwaniem zbiorów danych, doborem odpowiednich metod uczenia maszynowego oraz zakresem zagadnień, które powinny zostać uwzględnione w pracy.

Jedną z zaproponowanych koncepcji było wykorzystanie metod ekstrakcji cech akustycznych z sygnału muzycznego, na przykład z zastosowaniem biblioteki *Essentia* @bogdanov2013essentia. W ten sposób możliwe jest uzyskanie zbioru parametrów opisujących poszczególne nagrania. Liczba wyodrębnionych cech może wynosić nawet kilkadziesiąt lub ponad sto, w zależności od przyjętej konfiguracji oraz charakterystyki analizowanego sygnału. Tak przygotowane dane mogłyby następnie posłużyć jako wejście dla algorytmu klasyfikacyjnego, takiego jak drzewo decyzyjne.

Alternatywnym podejściem jest zastosowanie konwolucyjnych sieci neuronowych (CNN, *Convolutional Neural Networks*), które mogą analizować reprezentację sygnału muzycznego w postaci spektrogramu. Rozwiązanie to umożliwia wykorzystanie metod głębokiego uczenia do rozpoznawania wzorców w strukturze czasowo-częstotliwościowej dźwięku. Ekspert zwrócił jednak uwagę na potencjalną wartość badawczą drzew decyzyjnych, między innymi ze względu na możliwość interpretacji procesu klasyfikacji oraz analizowania znaczenia poszczególnych cech wejściowych.

Podczas konsultacji omówiono również możliwość zastosowania zespołu klasyfikatorów. W przypadku opracowania trzech niezależnych modeli można wykorzystać metodę głosowania większościowego (*majority voting*), w której ostateczna predykcja jest wyznaczana na podstawie wyniku wskazanego przez największą liczbę modeli. Podejście to mogłoby stanowić dodatkowy kierunek badań, pozwalający ocenić, czy połączenie kilku algorytmów poprawia skuteczność klasyfikacji.

Jako najbardziej uzasadniony kierunek dalszych prac ekspert zasugerował jednak skoncentrowanie się na porównaniu dwóch odmiennych podejść. W szczególności zaproponowano zestawienie klasyfikatora opartego na cechach akustycznych i drzewie decyzyjnym z modelem wykorzystującym konwolucyjną sieć neuronową analizującą spektrogramy. Takie porównanie pozwoliłoby ocenić skuteczność obu metod w realizacji założonego zadania, a także określić ich zalety i ograniczenia.

== Konsultacja ze sztuczną inteligencją

W ramach przygotowań do realizacji projektu przeprowadzono konsultację ze sztuczną inteligencją. Wykorzystano w tym celu model językowy *ChatGPT* (OpenAI) dnia 20.10.2026. Celem konsultacji było uzyskanie dodatkowych wskazówek dotyczących wyboru zbiorów danych, metod uczenia maszynowego oraz sposobu przeprowadzenia eksperymentów. Konsultacja pozwoliła zidentyfikować potencjalne kierunki badań oraz zagadnienia, które warto uwzględnić podczas projektowania i oceny systemu rozpoznawania gatunków muzycznych.

W zakresie doboru danych zaproponowano wykorzystanie zbioru *FMA-medium (Free Music Archive)* @defferrard2017fma jako głównego źródła nagrań oraz zbioru *GTZAN* @tzanetakis2002 do przeprowadzenia dodatkowych testów porównawczych. Zwrócono uwagę na ograniczenia zbioru GTZAN, w tym występowanie duplikatów nagrań, błędnych etykiet @sturm2014gtzan oraz ryzyko uzyskania zawyżonych wyników w sytuacji, gdy utwory tego samego wykonawcy znajdują się jednocześnie w zbiorze treningowym i testowym. W związku z tym podkreślono znaczenie odpowiedniego podziału danych, uwzględniającego tożsamość wykonawców @flexer2007artist, co pozwala na bardziej wiarygodną ocenę zdolności modelu do klasyfikowania nieznanych wcześniej nagrań.

W odniesieniu do metod klasyfikacji zaproponowano rozważenie kilku podejść o różnym stopniu złożoności. Pierwszym z nich jest zastosowanie klasycznych algorytmów uczenia maszynowego, takich jak drzewa decyzyjne, Random Forest lub SVM, wykorzystujących cechy akustyczne wyodrębnione z nagrań. Do cech tych mogą należeć między innymi współczynniki MFCC, charakterystyki widmowe, chroma oraz tempo utworu. Drugim podejściem jest wykorzystanie konwolucyjnych sieci neuronowych (CNN), które analizują spektrogramy muzyczne i samodzielnie uczą się rozpoznawać wzorce charakterystyczne dla poszczególnych gatunków. Dodatkowo wskazano możliwość wykorzystania gotowych, wcześniej wytrenowanych modeli, których reprezentacje dźwięku mogą stanowić dane wejściowe dla prostszego klasyfikatora.

Podczas konsultacji podkreślono, że istotnym elementem pracy powinno być nie tylko uzyskanie wysokiej skuteczności klasyfikacji, lecz także rzetelne porównanie zastosowanych metod. W tym celu zalecono uwzględnienie odpowiednich miar oceny, takich jak macro-F1, która umożliwia bardziej sprawiedliwe porównanie wyników dla poszczególnych klas w przypadku niezrównoważonego zbioru danych. Wskazano również na przydatność macierzy pomyłek, pozwalającej określić, które gatunki muzyczne są najczęściej ze sobą mylone. Ponadto zaproponowano przeprowadzenie eksperymentów z różnymi sposobami podziału danych oraz sprawdzenie, czy modele zachowują skuteczność podczas testowania na nagraniach pochodzących z innego zbioru niż ten wykorzystany w procesie uczenia.

Jako rekomendowany kierunek dalszych prac wskazano porównanie klasycznego podejścia opartego na ręcznie wyodrębnionych cechach akustycznych z metodą wykorzystującą głębokie uczenie na spektrogramach. Dodatkowym elementem badania mogłaby być ocena wpływu sposobu przygotowania danych na uzyskiwane wyniki. Takie podejście pozwoliłoby określić nie tylko, która z metod osiąga lepsze rezultaty, ale również jakie są jej ograniczenia oraz w jakim stopniu wyniki eksperymentalne odzwierciedlają rzeczywistą zdolność rozpoznawania gatunków muzycznych.

Wnioski z konsultacji ze sztuczną inteligencją stanowią uzupełnienie wskazówek uzyskanych podczas rozmowy z ekspertem. Pomagają doprecyzować plan badań, wskazać potencjalne problemy związane z jakością danych oraz zaplanować sposób porównania wybranych algorytmów. Ostateczny wybór zbiorów danych i metod powinien jednak uwzględniać zakres projektu, dostępne zasoby obliczeniowe oraz wyniki przeprowadzonych eksperymentów.

== Przegląd podobnych rozwiązań

Automatyczne rozpoznawanie gatunków muzycznych (ang. _music genre recognition_, MGR) jest jednym z klasycznych zadań dziedziny pozyskiwania informacji z muzyki (_Music Information Retrieval_, MIR). Jedną z pierwszych szeroko cytowanych prac jest artykuł Tzanetakisa i Cooka @tzanetakis2002, w którym klasyfikację oparto na ręcznie zaprojektowanych cechach opisujących barwę, rytm i wysokość dźwięku oraz na klasyfikatorach statystycznych. Praca ta wprowadziła również zbiór GTZAN, który przez kolejne lata stał się najczęściej używanym zbiorem testowym w tej dziedzinie @sturm2014gtzan.

Istniejące rozwiązania można podzielić na trzy grupy, odpowiadające podejściom omawianym podczas konsultacji.

*Cechy akustyczne i klasyczne uczenie maszynowe.* Z nagrania wyznaczany jest wektor cech (np. MFCC, charakterystyki widmowe, chroma, tempo), który trafia do klasyfikatora takiego jak drzewo decyzyjne, Random Forest lub SVM. Do ekstrakcji cech służą m.in. biblioteka Essentia @bogdanov2013essentia oraz librosa @mcfee2015librosa, a do klasyfikacji – scikit-learn @pedregosa2011sklearn. Zaletą tej grupy jest niewielkie zapotrzebowanie na zasoby obliczeniowe i możliwość interpretacji modelu.

*Konwolucyjne sieci neuronowe na spektrogramach.* Sygnał jest przekształcany do reprezentacji czasowo-częstotliwościowej (np. mel-spektrogramu), a sieć sama uczy się cech istotnych dla klasyfikacji. Przykładem są konwolucyjno-rekurencyjne sieci do klasyfikacji muzyki @choi2017crnn oraz sieci _musicnn_ @pons2019musicnn, zaprojektowane z myślą o dźwięku muzycznym.

*Wstępnie wytrenowane reprezentacje (embeddingi).* Model wytrenowany na dużym zbiorze (np. VGGish @hershey2017vggish, model Google powiązany z AudioSet, lub transformery z rodziny MAEST @alonso2023maest) zamienia nagranie na wektor, który następnie klasyfikuje prosty model, na przykład perceptron wielowarstwowy. Gotowe modele tego typu udostępnia projekt Essentia @essentia_models; MAEST przewiduje taksonomię 400 stylów muzycznych opartą na metadanych serwisu Discogs.

Projekt realizowany w ramach niniejszej pracy koncentruje się na porównaniu dwóch pierwszych grup w jednolitym protokole eksperymentalnym, zgodnie z rekomendacją eksperta. Trzecia grupa pozostaje dodatkowym kierunkiem, który może posłużyć jako przyszły punkt odniesienia w możliwym dalszym rozwoju projektu (np. do implementacji majority voting, tak jak sugerował to ekspert).

== Stan wiedzy

Z literatury dotyczącej rozpoznawania gatunków muzycznych wynika kilka wniosków, które bezpośrednio wpływają na projekt eksperymentów.

Po pierwsze, jakość i sposób użycia zbioru danych mają równie duże znaczenie jak wybór algorytmu. Sturm @sturm2014gtzan wykazał, że w GTZAN występują powtórzenia nagrań, błędne etykiety i zniekształcenia, a także liczne fragmenty tego samego wykonawcy w jednej klasie. Wnioskiem autora nie jest jednak porzucenie zbioru, lecz stosowanie go z uwzględnieniem jego wad. W projekcie GTZAN będzie zatem pełnił rolę pomocniczego zbioru kontrolnego, a nie jedynego źródła wniosków.

Po drugie, podział danych musi uwzględniać wykonawców. Flexer @flexer2007artist pokazał, że umieszczenie utworów tego samego wykonawcy zarówno w zbiorze uczącym, jak i testowym zawyża wyniki klasyfikacji, ponieważ model uczy się rozpoznawać wykonawcę lub realizację nagrania, a nie gatunek. Dlatego w projekcie przyjęto podział rozłączny względem wykonawców (por. rozdział 4).

Po trzecie, zbiory o większej skali, takie jak FMA @defferrard2017fma, powstały, ponieważ pozostałe zbiory z dostępnym dźwiękiem wysokiej jakości są o dwa rzędy wielkości mniejsze @defferrard2017fma. Wiąże się z tym jednak inna trudność: etykiety gatunkowe pochodzą z metadanych serwisu, a nie z niezależnej anotacji eksperckiej, więc granice między gatunkami bywają nieostre, a zbiór jest niezrównoważony.

Po czwarte, rozwój metod przesunął się od ręcznie projektowanych cech ku sieciom neuronowym i wstępnie wytrenowanym reprezentacjom @choi2017crnn @pons2019musicnn @alonso2023maest. Zalety klasycznego podejścia, przede wszystkim interpretowalność drzew decyzyjnych, uzasadniają jednak jego ponowne zestawienie z CNN. Do oceny stosuje się miary uwzględniające klasy niezrównoważone (macro-F1) oraz macierz pomyłek, wskazującą gatunki najczęściej ze sobą mylone.

== Uwarunkowania licencyjne

Poniżej zestawiono licencje elementów, z których projekt korzysta lub może skorzystać: zbiorów danych, bibliotek oraz gotowych modeli. Informacje pochodzą ze stron projektów i dokumentacji wskazanych w bibliografii (stan na 27.10.2026). Przed publikacją wyników lub wydaniem kodu należy sprawdzić je ponownie, ponieważ licencje mogą ulec zmianie.

#figure(
  table(
    columns: (1.15fr, 1.75fr, 2.7fr),
    align: (left, left, left),
    stroke: none,
    inset: (x: 5pt, y: 4pt),
    table.hline(stroke: 0.8pt),
    table.header(
      [*Element*], [*Licencja*], [*Konsekwencje dla projektu*],
    ),
    table.hline(stroke: 0.5pt),
    [FMA – metadane], [CC BY 4.0], [Dowolne użycie z podaniem autorów zbioru @defferrard2017fma.],
    [FMA – nagrania], [różne licencje Creative Commons, ustalane przez wykonawców], [Użycie badawcze jest dopuszczalne. Część nagrań ma klauzule NC (bez użycia komercyjnego) lub ND (bez utworów zależnych) @fma_github @fma_licencje_hf.],
    [GTZAN], [brak jawnej licencji], [Zbiór zawiera fragmenty komercyjnych nagrań @sturm2014gtzan. Użycie wyłącznie badawcze, bez dalszego rozpowszechniania nagrań.],
    [MTG-Jamendo], [nagrania na licencjach Creative Commons (część z klauzulą NC); kod i metadane repozytorium Apache 2.0], [Użycie badawcze jest dopuszczalne; użycie komercyjne wymaga wyboru nagrań na licencjach bez NC @bogdanov2019mtgjamendo.],
    [Essentia (biblioteka)], [AGPL-3.0; licencja komercyjna na zamówienie], [Dla pracy dyplomowej bez udostępniania usługi sieciowej obowiązki są ograniczone. Wdrożenie komercyjne wymaga licencji lub zamiany biblioteki @essentia_licensing.],
    [Modele Essentia, MAEST], [CC BY-NC-SA 4.0 (wg pliku licencji modeli); licencja zastrzeżona na zamówienie], [Wyłącznie użycie niekomercyjne. Strona opisująca licencjonowanie wymienia wariant BY-NC-ND, dlatego warunki konkretnego modelu należy sprawdzić przy jego pobraniu @essentia_models_license @essentia_licensing.],
    [VGGish, YAMNet], [Apache 2.0], [Dopuszczalne także użycie komercyjne @essentia_models_license.],
    [musicnn], [ISC], [Licencja permisywna @essentia_models_license.],
    [librosa], [ISC], [Licencja permisywna @mcfee2015librosa.],
    [scikit-learn], [BSD 3-Clause], [Licencja permisywna @pedregosa2011sklearn.],
    [PyTorch / TensorFlow], [BSD / Apache 2.0], [Licencje permisywne, dozwolone użycie komercyjne.],
    table.hline(stroke: 0.8pt),
  ),
  caption: [Licencje zbiorów danych, bibliotek i modeli],
) <tab:licencje>

// TODO: zweryfikować licencje librosa, scikit-learn, PyTorch, TensorFlow w repozytoriach przed oddaniem pracy

Z zestawienia (@tab:licencje) wynikają dwie obserwacje. Po pierwsze, licencje Creative Commons z klauzulą NC lub ND dotyczą większości nagrań w zbiorze FMA, a udział nagrań na licencji CC BY 4.0 jest niewielki @fma_licencje_hf. Po drugie, wstępnie wytrenowane modele Essentia i MAEST są udostępniane na licencji niekomercyjnej, a prawo do użycia komercyjnego trzeba uzyskać odrębnie.

Warto zaznaczyć, że sam proces uczenia modelu nie polega na redystrybucji nagrań, lecz na ich analizie. Dyrektywa (UE) 2019/790 przewiduje wyjątki dla eksploracji tekstu i danych (art. 3 dla organizacji badawczych, art. 4 z możliwością zastrzeżenia przez uprawnionych) @dyrektywa_dsm. Nie rozstrzyga to jednak wszystkich wątpliwości dotyczących nagrań z klauzulą ND, dlatego przyjęto ostrożne podejście opisane w kolejnym podrozdziale.

== Uwarunkowania komercyjne

Projekt jest pracą dyplomową o charakterze badawczym i edukacyjnym, a jego wyniki nie będą oferowane jako produkt ani usługa. W tych warunkach:

- korzystanie z nagrań FMA, MTG-Jamendo i GTZAN w celach badawczych jest dopuszczalne,
- korzystanie z biblioteki Essentia na licencji AGPL-3.0 oraz z jej modeli na licencji niekomercyjnej jest dopuszczalne,
- nagrania, spektrogramy ani inne dane pochodne nie będą rozpowszechniane; w repozytorium publikowane będą identyfikatory utworów i skrypty pobierania danych,
- w pracy podane zostaną źródła zbiorów i bibliotek zgodnie z wymaganiami ich licencji (w szczególności atrybucja dla CC BY).

Modele wytrenowane w projekcie na danych z klauzulą NC będą traktowane jako niekomercyjne, nawet jeśli prawne skutki takiego uczenia nie są jednoznaczne. Ewentualna komercjalizacja rozwiązania wymagałaby: ograniczenia danych do nagrań na licencjach bez NC i ND albo pozyskania własnych praw do nagrań, zastąpienia biblioteki Essentia i jej modeli rozwiązaniami permisywnymi (np. librosa, VGGish) albo wykupienia licencji komercyjnej oraz ponownego wytrenowania modeli.

== Dostępne bazy danych

W projekcie rozważano trzy zbiory danych. Ich podstawowe parametry zestawiono w @tab:bazy.

#figure(
  table(
    columns: (1.05fr, 1.45fr, 1.9fr, 2.6fr),
    align: (left, left, left, left),
    stroke: none,
    inset: (x: 5pt, y: 4pt),
    table.hline(stroke: 0.8pt),
    table.header(
      [*Zbiór*], [*Rozmiar*], [*Etykiety*], [*Uwagi*],
    ),
    table.hline(stroke: 0.5pt),
    [GTZAN], [1000 fragmentów po 30 s], [10 gatunków po 100 fragmentów], [Zbalansowany i mały; znane wady: powtórzenia, błędne etykiety, silna obecność pojedynczych wykonawców w klasach @sturm2014gtzan.],
    [FMA (small)], [8000 fragmentów po 30 s], [8 gatunków po 1000 fragmentów], [Najmniejszy wariant FMA, zbalansowany @defferrard2017fma.],
    [FMA (medium)], [25 000 fragmentów po 30 s], [16 gatunków nadrzędnych, niezrównoważone], [Główny kandydat projektu. Dostępne metadane z wykonawcą, co umożliwia podział rozłączny względem wykonawców @defferrard2017fma.],
    [FMA (large, full)], [106 574 utwory], [161 gatunków w hierarchii], [Wariant _large_ zawiera fragmenty 30 s, wariant _full_ pełne nagrania. Bardzo duże, przekraczające założone zasoby obliczeniowe projektu @defferrard2017fma.],
    [MTG-Jamendo], [ponad 55 000 pełnych nagrań], [195 tagów, w tym 87 gatunkowych; wielokrotne etykiety], [Zadanie wieloetykietowe, co odbiega od założenia jednego gatunku na utwór @bogdanov2019mtgjamendo.],
    table.hline(stroke: 0.8pt),
  ),
  caption: [Porównanie dostępnych zbiorów danych],
) <tab:bazy>

*GTZAN* jest najczęściej używanym zbiorem w literaturze, dzięki czemu pozwala porównać wyniki z pracami innych autorów, ale ze względu na wady opisane w stanie wiedzy nie nadaje się na jedyny zbiór oceny. *FMA* jest największym otwartym zbiorem z nagraniami o dobrej jakości, metadanymi wykonawców i hierarchią gatunków, a zostało przygotowane do oceny algorytmów MIR @defferrard2017fma. Wariant _medium_ stanowi kompromis między liczbą danych a zasobami obliczeniowymi. *MTG-Jamendo* jest przeznaczony do automatycznego tagowania, czyli zadania wieloetykietowego, więc jego użycie wymagałoby zmiany sformułowania problemu. W pozostałych zbiorach spotykanych w literaturze (np. MagnaTagATune, Million Song Dataset, AudioSet) dostępność nagrań lub ich jakość stanowią ograniczenie @defferrard2017fma, dlatego nie zostały uwzględnione.

Na podstawie powyższej analizy jako zbiór główny wybrano FMA (medium), a jako zbiór do dodatkowych testów porównawczych i oceny na danych z innego źródła – GTZAN. Konkretny podzbiór gatunków i kryteria sukcesu opisano w rozdziale 4.
