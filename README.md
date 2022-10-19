# Dumitru Elena-Bianca 331CC

# Tema - Limbaje formale si automate (Obiecte 3D - Varianta C)

In cadrul acestei teme, am programat analizorul lexical (FLEX) pentru a parsa un
input din diferite fisiere text si a extrage informatiile relevante.

Un cod flex este compus din 3 parti: 2 de cod C si 1 de reguli de parsare.

## Prima parte de cod C:
Am declarat variabilele globale (deci pot fi modificate in restul programului).
Cate o variabila pentru numarul de vertexi si numarul de fete.
Un char* pentru a tine minte textura si un int cu valori 0/1 pentru a sti daca
avem textura sau nu.
Variabila notFinished care tine cont daca avem obiecte intercalate sau nu - pentru a face corect indentarea.
Variabila firstObject retine daca suntem sau nu la primul obiect pentru a putea
afisa caracterele de tip '\n' in mod corespunzator.

## Partea de reguli:
Am ales sa separ logica de parsare pe mai multe stari in functie de informatia
cautata in text.
Starea INITIAL este starea cu care incepe automatul si din care vom putea intra
in alte stari.
Noile stari (FINDOBJECT, FINDVERTEXES, FINDFACES, FINDTEXTURE) sunt marcate cu
%x si nu cu %s, fiind deci exclusive si executand doar regulile corespunzatoare
propriei stari. <br />

In initial vom cauta mai intai cuvantul "Object". Daca nu suntem la primul 
obiect si avem obiecte neterminate, inseamna ca trebuie sa afisam informatiile
capatate si sa indentam corespunzator urmatorul obiect.
Resetam variabilele pentru a reincepe cautarea de la 0 pentru celalalte obiecte. <br />

Intram in starea FINDOBJECT pentru a afla numele obiectului.
In aceasta stare printam tot sirul ramas de parcurs pana la \n si trecem din nou
in starea INITIAL. <br />

In INITIAL cautam cuvantul "vertexes" si trecem in starea FINDVERTEXES pentru a
contoriza numarul de varfuri. Vom numara (incrementand variabile vertexesNumber)
in functie de nr de "(". Analog pentru "faces" si caracterul ";". <br />

Pentru a ne asigura ca avem si informatii despre textura, parsam pentru cuvinte-
le "texture", respectiv "img". Folosim yymore() pentru a retine numele intreg al
texturii, pana gasim \n. Apoi vom sterge caracterul \n "yyless(yyleng - 1)" si
vom retine textura. <br />

## A doua parte de cod C:
Citim din fisier (numele fisierului il primim in linia de comanda).
Rulam functia de flex yylex().












 
