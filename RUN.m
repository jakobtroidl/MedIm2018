% 2 Angabe
% Das erste Beispiel dient einerseits dem Vertrautwerden mit Matlab und andererseits
% dazu, das Verstandis der PCA (Principal Component Analysis) zu vertiefen.
% Ziel des Beispiels ist die Implementierung einer PCA (Principal Component
% Analysis) und die Untersuchung ihrer grundlegenden Eigenschaften. Teile des Codes
% werden zur Verfugung gestellt (Daten, Plotfunktionen, etc) um die Konzentration
% aufs Wesentliche zu erleichtern.

% 2.1 Vorhandene Hilfsfunktionen
% plot2DPCA.m und plot3DPCA.m konnen verwendet werden, um Datenpunkte, Eigenvektoren,
% Eigenwerte, Ellipsen/Ellipsoide und rekontruierte Daten zu plotten.
% plotDEMO.m zeigt die Moglichkeiten, open plot2DPCA.m zeigt die Dokumentation
% und Verwendung.
% Evtl benotigte Matlab Funktionen sind unter anderem: clear, close all,
% load, plot (dazu als Parameter ,'.' fur Punkte), axis equal, bar, imagesc,
% repmat, mean, var, std, sort, mvnrnd und eig. Informationen zu den Matlab-
% Funktionen mit doc Funktionsname.

% 2.2 Fragestellung
% In Klammer jeweils die erreichbare Punktezahl, insgesamt 30 Punkte.
% Fuer alle Punkte wird angenommen, dass die n Datenpunkte d Dimensionen
% haben und in einer dxn-Matrix D vorliegen. D.h. 2xn fuer 2D und 3xn fuer 3D.

% 1. Kovarianzmatrix
% (a) Schreiben Sie eine Funktion ourCov.m, die die Kovarianzmatrix C fuer
% D berechnet. Die Verwendung der Matlab Funktion cov ist zur Berechnung
% nicht erlaubt, aber kann zum Ergebnis-Vergleich verwendet
% werden (cov erwartet eine nxd Matrix). (2 Punkte)

% -> ourCov.m



% (b) Berechnen Sie C fuer die Daten in daten.mat. Zeigen Sie die Daten
% mit plot in separaten Figures und stellen Sie die Skalierung auf axis
% equal. Interpretieren Sie die unterschiedlichen C zwischen den Datensets!
% Welche Informationen stehen an welcher Stelle von C? (2 Punkte)

%LÖSCHEN was sind die 4 Arrays mit je 2x50 matrizen?
% LÖSCHEN!!!!!!!!!!!!!!!!!!!... 4x 2-dim Vektoren? mit 50 einträgen....

daten=load('daten.mat');
D=cell2mat(struct2cell(daten)); %Dim: d x n (8x50)
C=ourCov(D); %mit dxn
% LÖSCHEN cov(transpose(D)) %mit nxd

%LÖSCHEN wie ploten??
figure
subplot(1,2,1)
plot(transpose(D))

subplot(1,2,2)
plot(C)

axis on
axis equal

% 2. PCA { Schreiben Sie eine Funktion pca.m, die die PCA fuer D berechnet. Die
% Berechnung soll unabhaengig von der Dimension der Daten sein. Ergebnis sind
% die absteigend sortierten Eigenwerte und die nach absteigenden Eigenwerten
% sortierten, normierten Eigenvektoren. Sie koennen fuer die Berechnung der
% Eigenvektoren/-werte die Matlab Funktion eig verwenden. (2 Punkte)

% -> pca.m

[eva,eve]=pca(D);

% (a) Plotten Sie mit plot2DPCA.m Ihre Ergebnisse fuer die Daten aus daten.mat.
% ( 1 Punkt)

% LÖSCHEN!!!!!!!!... 4x 2-dim Vektoren? mit 50 einträgen....


% (b) Was geben die Eigenvektoren an? Wo sieht man das im Plot? (1.5
% Punkt)



% (c) Was geben die Eigenwerte an? Wo sieht man das im Plot? In welcher
% Relation stehen sie zur Gesamtvarianz? (1.5 Punkte)



% (d) Welchen Einfluss hat ein fehlender Mittelwertabzug (bei D) auf die
% Berechnung? (1 Punkt)



% 3. Unterraum-Projektion
% (a) Berechnen Sie die PCA fur data3. Projiziieren Sie die Daten in data3
% auf den Hauptvektor (Plot). Welche Dimension haben Ihre Daten jetzt?
% Rekonstruieren Sie die Projektion und plotten Sie das Ergebnis mittels
% plot2DPCA.m. Beschreiben Sie den Eekt von Projektion und Rekonstruktion
% auf die Datenpunkte. Wie gro ist der Durchschnittliche Fehler
% zwischen Rekonstruktion und Originaldaten? (3 Punkte)



% (b) Machen Sie die selbe Untersuchung, nur mit dem Nebenvektor. Welche
% Eigenvektoren werden Sie verwenden, um eine Datenmatrix mit
% moglichst wenig Fehler mit moglichst wenig Eigenvektoren (in diesem
% Fall 1) darzustellen? (1 Punkt)



% 4. Untersuchungen in 3D
% (a) Berechnen Sie die PCA und plotten Sie Daten und Eigenvektoren fur
% die Daten in daten3d.mat. Beschreiben Sie die Relation von Kovarianzmatrix
% (Varianzen), Eigenwerten und -vektoren und den Ellipsoiden
% der Standardabweichungen. (2 Punkt)



% (b) Projiziieren Sie auf den Unterraum, der durch die ersten beiden Eigenvektoren
% aufgespannt wird. Welche Dimension haben Ihre Daten?
% Rekonstruieren Sie die Punkte im Originalraum und plotten Sie das
% Ergebnis. Welche Information ist verloren gegangen? (1 Punkt)



% 5. Shape Modell
% (a) Berechnen Sie die PCA der Shape Daten in shape.mat { die Matrix
% aligned hat die Dimensionen nPunkte x nDimensionen x nShapes.
% Schreiben Sie eine Funktion generateShape, die zu einem Parametervektor
% b mit einer Lange entsprechend der Zahl der Eigenvektoren neue
% Shapes generieren kann.(4 Punkt)



% (b) Schreiben Sie eine Funktion plotShape, die die Shapes in blau darstellt
% und plotten und interpretieren Sie die Einzelnen Modes (d.h. b ist 0
% bis auf einen Wert) im Bereich von 3, wobei  die Standardabweichung
% des entprechenden Modes bezeichnet. Die Funktion soll gleichzeitig
% auch das mean shape (d.h. b gleich dem Nullvektor) in rot darstellen.
% Beschreiben und interpretieren Sie. (4 Punkt)



% (c) Setzen Sie nun b=randn(1,nEigenvectors).*stddeviations. Beschranken
% Sie nun wie in den 2D und 3D Beispielen die Zahl der Eigenvektoren,
% dementsprechend die Lange von b, plotten Sie die resultierenden Shapes
% und interpretieren Sie. Beschranken Sie so, dass das Shape Modell
% 100%, 95%, 90% und 80% der Gesamtvarianz beinhaltet.(4 Punkt)




