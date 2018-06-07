% % Das erste Beispiel dient einerseits dem Vertrautwerden mit Matlab und andererseits
% % dazu, das Verstandis der PCA (Principal Component Analysis) zu vertiefen.
% % Ziel des Beispiels ist die Implementierung einer PCA (Principal Component
% % Analysis) und die Untersuchung ihrer grundlegenden Eigenschaften. Teile des Codes
% % werden zur Verfugung gestellt (Daten, Plotfunktionen, etc) um die Konzentration
% % aufs Wesentliche zu erleichtern.
% 
% % 2.1 Vorhandene Hilfsfunktionen
% % plot2DPCA.m und plot3DPCA.m konnen verwendet werden, um Datenpunkte, Eigenvektoren,
% % Eigenwerte, Ellipsen/Ellipsoide und rekontruierte Daten zu plotten.
% % plotDEMO.m zeigt die Moglichkeiten, open plot2DPCA.m zeigt die Dokumentation
% % und Verwendung.
% % Evtl benotigte Matlab Funktionen sind unter anderem: clear, close all,
% % load, plot (dazu als Parameter ,'.' fur Punkte), axis equal, bar, imagesc,
% % repmat, mean, var, std, sort, mvnrnd und eig. Informationen zu den Matlab-
% % Funktionen mit doc Funktionsname.
% 
% % 2.2 Fragestellung
% % In Klammer jeweils die erreichbare Punktezahl, insgesamt 30 Punkte.
% % Fuer alle Punkte wird angenommen, dass die n Datenpunkte d Dimensionen
% % haben und in einer dxn-Matrix D vorliegen. D.h. 2xn fuer 2D und 3xn fuer 3D.
% 
% % 1. Kovarianzmatrix
% % (a) Schreiben Sie eine Funktion ourCov.m, die die Kovarianzmatrix C fuer
% % D berechnet. Die Verwendung der Matlab Funktion cov ist zur Berechnung
% % nicht erlaubt, aber kann zum Ergebnis-Vergleich verwendet
% % werden (cov erwartet eine nxd Matrix). (2 Punkte)
% 
% % -> ourCov.m
% 
% 
% 
% % (b) Berechnen Sie C fuer die Daten in daten.mat. Zeigen Sie die Daten
% % mit plot in separaten Figures und stellen Sie die Skalierung auf axis
% % equal. Interpretieren Sie die unterschiedlichen C zwischen den Datensets!
% % Welche Informationen stehen an welcher Stelle von C? (2 Punkte)
% 
% D = load('daten.mat');
% 
% D1 = D.data1;
% D2 = D.data2;
% D3 = D.data3;
% D4 = D.data4;
% 
% %c1 = ourCov(D1,1);
% % figure('Name','Matrix 1');
% % plot(D1(1,:), D1(2,:),'*');
% % axis on
% % axis equal
% % 
% % c2 = ourCov(D2,1);
% % figure('Name','Matrix 2');
% % plot(D2(1,:), D2(2,:),'*');
% % axis on
% % axis equal
% % 
% % c3 = ourCov(D3,1);
% % figure('Name','Matrix 3');
% % plot(D3(1,:), D3(2,:),'*');
% % axis on
% % axis equal
% % 
% % c4 = ourCov(D4,1);
% % figure('Name','Matrix 4');
% % plot(D4(1,:), D4(2,:),'*');
% % axis on
% % axis equal
% 
% 
% 
% % 2. PCA { Schreiben Sie eine Funktion pca.m, die die PCA fuer D berechnet. Die
% % Berechnung soll unabhaengig von der Dimension der Daten sein. Ergebnis sind
% % die absteigend sortierten Eigenwerte und die nach absteigenden Eigenwerten
% % sortierten, normierten Eigenvektoren. Sie koennen fuer die Berechnung der
% % Eigenvektoren/-werte die Matlab Funktion eig verwenden. (2 Punkte)
% 
% % -> pca.m
% 
% [eVal1,eVec1]=pca(D1,1);
% [eVal2,eVec2]=pca(D2,1);
% [eVal3,eVec3]=pca(D3,1);
% [eVal4,eVec4]=pca(D4,1);
% 
% 
% % (a) Plotten Sie mit plot2DPCA.m Ihre Ergebnisse fuer die Daten aus daten.mat.
% % ( 1 Punkt)
% 
% % disp('2d pca D1 ')
% % D1trans = transpose(D1);
% % dummyReconstruction1 = D1trans;  % here you would use your reconstructed data
% % plot2DPCA(D1trans, mean(D1trans), dummyReconstruction1, eVec1, eVal1, 1, 1);
% 
% % disp('2d pca D2 ')
% % D2trans = transpose(D2);
% % dummyReconstruction2 = D2trans;  % here you would use your reconstructed data
% % plot2DPCA(D2trans, mean(D2trans), dummyReconstruction2, eVec2, eVal2, 1, 1);
% 
% % disp('2d pca D3 ')
% % D3trans = transpose(D3);
% % dummyReconstruction3 = D3trans;  % here you would use your reconstructed data
% % plot2DPCA(D3trans, mean(D3trans), dummyReconstruction3, eVec3, eVal3, 1, 1);
% % 
% % disp('2d pca D4 ')
% % D4trans = transpose(D4);
% % dummyReconstruction4 = D4trans;  % here you would use your reconstructed data
% % plot2DPCA(D4trans, mean(D4trans), dummyReconstruction4, eVec4, eVal4, 1, 1);
% 
% % (b) Was geben die Eigenvektoren an? Wo sieht man das im Plot? (1.5
% % Punkt)
% 
% 
% 
% % (c) Was geben die Eigenwerte an? Wo sieht man das im Plot? In welcher
% % Relation stehen sie zur Gesamtvarianz? (1.5 Punkte)
% 
% 
% 
% % (d) Welchen Einfluss hat ein fehlender Mittelwertabzug (bei D) auf die
% % Berechnung? (1 Punkt)
% % Eigenvektoren werden auf Nullpunkt verschoben
% % disp('2d pca D1 ')
% % D1trans = transpose(D1);
% % dummyReconstruction1 = D1trans;  % here you would use your reconstructed data
% % plot2DPCA(D1trans, mean(D1trans), dummyReconstruction1, eVec1, eVal1, 1, 1);
% % 
% % [eVal1_0,eVec1_0]=pca(D1,0);
% % disp('2d pca D1 ')
% % D1trans = transpose(D1);
% % dummyReconstruction1 = D1trans;  % here you would use your reconstructed data
% % plot2DPCA(D1trans, mean(D1trans), dummyReconstruction1, eVec1_0, eVal1_0, 1, 1);
% 
% % 3. Unterraum-Projektion
% % (a) Berechnen Sie die PCA fur data3. Projiziieren Sie die Daten in data3
% % auf den Hauptvektor (Plot). Welche Dimension haben Ihre Daten jetzt?
% % Rekonstruieren Sie die Projektion und plotten Sie das Ergebnis mittels
% % plot2DPCA.m. Beschreiben Sie den Eekt von Projektion und Rekonstruktion
% % auf die Datenpunkte. Wie gro ist der Durchschnittliche Fehler
% % zwischen Rekonstruktion und Originaldaten? (3 Punkte)
% [eVal3,eVec3]=pca(D3,1);
% meanD3=mean(transpose(D3));
% 
% D3_hv_zent =  D3-repmat(transpose(meanD3),1,size(D3,2)); %zentrieren
% D3_hv_rot  =  transpose(eVec3)*D3_hv_zent; % Rotation, sodass die Eigenvektoren die X und Y Achse sind
% D3_hv_proj =  [D3_hv_rot(1,:);zeros(1,size(D3_hv_rot,2))];
% D3_hv_rec  =  eVec3*D3_hv_proj; %inverse of eVec3 = transpose of eVec3, wegen gleicher orthonormal basis
% D3_hv_shift =  D3_hv_rec+repmat(transpose(meanD3),1,size(D3,2)); %rezentrieren
% 
% disp('2d pca D3_hv ')
% plot2DPCA(transpose(D3), meanD3, transpose(D3_hv_shift), eVec3, eVal3, 1, 1);
% 
% %Durchschnittlicher Fehler
% 
% 
% D3_hv_diff = D3-D3_hv_shift;
% for i=1:size(D3,2)
%    D3_hv_distance(i)=norm(D3_hv_diff(:,i)); 
% end
% D3_hv_err_hv = mean(transpose(D3_hv_distance))
% 
% % (b) Machen Sie die selbe Untersuchung, nur mit dem Nebenvektor. Welche
% % Eigenvektoren werden Sie verwenden, um eine Datenmatrix mit
% % moglichst wenig Fehler mit moglichst wenig Eigenvektoren (in diesem
% % Fall 1) darzustellen? (1 Punkt)
% [eVal3,eVec3]=pca(D3,1);
% meanD3=mean(transpose(D3));
% 
% D3_nv_zent =  D3-repmat(transpose(meanD3),1,size(D3,2)); %zentrieren
% D3_nv_rot  =  transpose(eVec3)*D3_nv_zent; % Rotation, sodass die Eigenvektoren die X und Y Achse sind
% D3_nv_proj =  [zeros(1,size(D3_nv_rot,2));D3_nv_rot(2,:)];
% D3_nv_rec  =  eVec3*D3_nv_proj; %inverse of eVec3 = transpose of eVec3, wegen gleicher orthonormal basis
% D3_nv_shift =  D3_nv_rec+repmat(transpose(meanD3),1,size(D3,2)); %rezentrieren
% 
% disp('2d pca D3_nv ')
% plot2DPCA(transpose(D3), meanD3, transpose(D3_nv_shift), eVec3, eVal3, 1, 1);
% 
% %Durchschnittlicher Fehler
% 
% D3_nv_diff = D3-D3_nv_shift;
% for i=1:size(D3,2)
%    D3_nv_distance(i)=norm(D3_nv_diff(:,i)); 
% end
% D3_nv_distance;
% D3_nv_err_nv = mean(transpose(D3_nv_distance))
% 
% 
% 
% % 4. Untersuchungen in 3D
% % (a) Berechnen Sie die PCA und plotten Sie Daten und Eigenvektoren fuer
% % die Daten in daten3d.mat. Beschreiben Sie die Relation von Kovarianzmatrix
% % (Varianzen), Eigenwerten und -vektoren und den Ellipsoiden
% % der Standardabweichungen. (2 Punkt)
% 
% D3D=load('daten3d.mat');
% D3D=D3D.data;
% meanD3D=mean(transpose(D3D));
% [eValD3D,eVecD3D]=pca(D3D,1);
% plot3DPCA(transpose(D3D), meanD3D, eVecD3D, eValD3D, 1, 0)
% ourcov(D3D,1)
% % (b) Projiziieren Sie auf den Unterraum, der durch die ersten beiden Eigenvektoren
% % aufgespannt wird. Welche Dimension haben Ihre Daten?
% % Rekonstruieren Sie die Punkte im Originalraum und plotten Sie das
% % Ergebnis. Welche Information ist verloren gegangen? (1 Punkt)
% 
% D3D_zent =  D3D-repmat(transpose(meanD3D),1,size(D3D,2)); %zentrieren
% D3D_rot  =  transpose(eVecD3D)*D3D_zent; % Rotation, sodass die Eigenvektoren die X, Y und Z Achse sind
% D3D_proj =  [D3D_rot(1,:);D3D_rot(2,:);zeros(1,size(D3D_rot,2))];
% D3D_rec  =  eVecD3D*D3D_proj; %inverse of eVec3 = transpose of eVec3, wegen gleicher orthonormal basis
% D3D_shift =  D3D_rec+repmat(transpose(meanD3D),1,size(D3D,2)); %rezentrieren
% 
% plot3DPCA(transpose(D3D_shift), meanD3D, eVecD3D, eValD3D, 1, 1);
% 
% % 5. Shape Modell
% % (a) Berechnen Sie die PCA der Shape Daten in shape.mat { die Matrix
% % aligned hat die Dimensionen nPunkte x nDimensionen x nShapes.
% % Schreiben Sie eine Funktion generateShape, die zu einem Parametervektor
% % b mit einer Laenge entsprechend der Zahl der Eigenvektoren neue
% % Shapes generieren kann.(4 Punkt)
% 
% shapes = load('shapes.mat'); %Daten laden
% shapes = shapes.aligned; %aligned auswaehlen
% 
% %3dim Matrix in 2dim Matrix speichern: ([x(1 1);y(1 1);x(2 1);y(2
% %1);...],...,[x(1 14);...])
% for i=1:14
%     for j=1:128
%         shapesmat(j*2,i)=shapes(j,2,i);
%         shapesmat(j*2-1,i)=shapes(j,1,i);
%     end
% end
% 
% %LÖSCHEN shapes normieren, bzw verzerrung entfernen??
% shapesmean=mean(shapesmat'); %mean aller Punkte
% shapesmatwom=shapesmat-shapesmean'; %shapes without mean
% [shapeseVal,shapeseVec]=pca(shapesmatwom,1); %pca berechnen
% 
% % -> generateShape
% 
% %10Bsp mit random vector (blau) + mean shape (rot):
% plot([shapesmean(1:2:256),shapesmean(1)],[shapesmean(2:2:256),shapesmean(2)],'r')
% hold on
% numposeVal=sum(shapeseVal>0.0000000001);%Anzahl Eigenwerte > 0
% for i=1:10
%     bnew=round(randn(numposeVal,1)*10);
%     xnew=generateShape(bnew,shapeseVec,shapesmean);
%     plot([xnew(1:2:256);xnew(1)],[xnew(2:2:256);xnew(2)],'b')
% end
%     
% % (b) Schreiben Sie eine Funktion plotShape, die die Shapes in blau darstellt
% % und plotten und interpretieren Sie die Einzelnen Modes (d.h. b ist 0
% % bis auf einen Wert) im Bereich von +/-3 lambda, wobei lambda die Standardabweichung
% % des entprechenden Modes bezeichnet. Die Funktion soll gleichzeitig
% % auch das mean shape (d.h. b gleich dem Nullvektor) in rot darstellen.
% % Beschreiben und interpretieren Sie. (4 Punkt)
% 
% %LÖSCHEN "Shapes in blau darstellt" -> alle shapes in grunddaten darstellen? (14
% %stück)??
% plotShape(shapeseVal,shapeseVec,shapesmean);
% 
% % (c) Setzen Sie nun b=randn(1,nEigenvectors).*stddeviations. Beschraenken
% % Sie nun wie in den 2D und 3D Beispielen die Zahl der Eigenvektoren,
% % dementsprechend die Laenge von b, plotten Sie die resultierenden Shapes
% % und interpretieren Sie. Beschraenken Sie so, dass das Shape Modell
% % 100%, 95%, 90% und 80% der Gesamtvarianz beinhaltet.(4 Punkt)
% 
% antgesamtvar=shapeseVal(1:numposeVal)/sum(shapeseVal(1:numposeVal)); %Anteil der Gesamtvarianz
% kumgesamtvar=cumsum(antgesamtvar); %kumulierte Gesamtvarianz
% 
% 
% %Shape Modell mit 100% der Gesamtvarianz
% nEigenvectors=numposeVal;%Gesamtvarianz entspricht der Anzahl aller positiven Eigenwerte
% stddeviations=sqrt(shapeseVal(1:nEigenvectors))'; %Varianz=Stdabw.^2
% b100=randn(1,nEigenvectors).*stddeviations;
% shapenew100=generateShape(b100',shapeseVec,shapesmean);
% 
% %Shape Modell mit 95% der Gesamtvarianz
% nEigenvectors=5;%kumgesamtvar(5)=0.9633
% stddeviations=sqrt(shapeseVal(1:nEigenvectors))'; %Varianz=Stdabw.^2
% b95=randn(1,nEigenvectors).*stddeviations;
% shapenew95=generateShape(b95',shapeseVec,shapesmean);
% 
% %Shape Modell mit 90% der Gesamtvarianz
% nEigenvectors=3;%kumgesamtvar(3)=0.9058
% stddeviations=sqrt(shapeseVal(1:nEigenvectors))'; %Varianz=Stdabw.^2
% b90=randn(1,nEigenvectors).*stddeviations;
% shapenew90=generateShape(b90',shapeseVec,shapesmean);
% 
% %Shape Modell mit 80% der Gesamtvarianz
% nEigenvectors=2;%kumgesamtvar(2)=0.7928
% stddeviations=sqrt(shapeseVal(1:nEigenvectors))'; %Varianz=Stdabw.^2
% b80=randn(1,nEigenvectors).*stddeviations;
% shapenew80=generateShape(b80',shapeseVec,shapesmean);
% 
% %Alles ploten:
% plot([shapenew80(1:2:256);shapenew80(1)],[shapenew80(2:2:256);shapenew80(2)])
% hold on
% plot([shapenew90(1:2:256);shapenew90(1)],[shapenew90(2:2:256);shapenew90(2)])
% plot([shapenew95(1:2:256);shapenew95(1)],[shapenew95(2:2:256);shapenew95(2)])
% plot([shapenew100(1:2:256);shapenew100(1)],[shapenew100(2:2:256);shapenew100(2)])
% plot([shapesmean(1:2:256),shapesmean(1)],[shapesmean(2:2:256),shapesmean(2)])
% hold off
% legend({'80% of Totvar','90% of Totvar','95% of Totvar','100% of Totvar','MeanShape'})
% 
% 
% 
% 
% 
% 

%_______________________________________________________________________________
%_____________________Projekt 2________________________________________
%_____________________________________________________________________


% % 2 Angabe
% % Im zweiten Beispiel geht es darum, das PCA Model aus dem ersten Beispiel in
% % einem Segmentierungsalgorithmus zu verwenden. Es handelt sich dabei um eine
% % vereinfachte Variante von Particle Filters1. Behandelte Themen:
% %  Feature-Berechnung
% %  Klassifikation und Feature-Selection mittels Random Forests
% %  Aufstellung und Optimieren einer Kostenfunktion, d.h. Segmentierung

% % 2.1 Vorhandene Daten bzw Hilfsfunktionen mit Dokumentation
% % im Source Code:
% %  Daten sind in handdata.mat. images enthalt die Bilder, masks die Masken
% % mit den Konturen der Objekte, landmarks die ndim  nlandmarks  nbones 
% % nimages landmarks und aligned die bereits alignten Landmarks fur jeden
% % Knochen fur die PCA.
% %  computeHaarLike.m berechnet Haar-like Features fur ein Bild
% %  optimize.m optimiert eine gegebene Kostenfunktion
% %  optimizeDEMO.m demonstriert optimize.m
% %  cache.m erlaubt das einfache Zwischenspeichern von Ergebnissen (siehe cacheDEMO.m)
% % Evtl benotigte Matlab Funktionen sind unter anderem: gradient, meshgrid,
% % TreeBagger, randperm.

% % 2.2 Fragestellung
% % In Klammer jeweils die erreichbare Punktezahl, insgesamt 40 Punkte. Die Bilder
% % 1-30 sind fur das Training (dh PCA Modell und Klassifikator) und Bilder 31-50
% % fur das Testen zu verwenden.


% % 1. Shape-Modell (5 Punkte) Erweitern Sie Funktion generateShape.m so,
% % dass die Shapes entsprechend den Paramtern r; s; x; y rotiert, skaliert und
% % verschoben werden konnen (Stichwort Rotationsmatrix), dh die Funktion
% % hat dann nmodes+4 Parameter: p = (b; scaling; rotation; x?translation; y?
% % translation). Plotten Sie analog zum ersten Beispiel Shapes fur mehrere
% % Werte von Skalierung und Rotation.
% % 1siehe PDF deBruijne2004MICCAI_ParticleFilters.pdf




handdata = load('handdata.mat');
shapes = handdata.aligned; %aligned auswaehlen

%3dim Matrix in 2dim Matrix speichern: ([x(1 1);y(1 1);x(2 1);y(2
%1);...],...,[x(1 14);...])
for i=1:50
    for j=1:64
        shapesmat(j*2,i)=shapes(j,2,i);
        shapesmat(j*2-1,i)=shapes(j,1,i);
        
    end
end

shapesmean=mean(shapesmat'); %mean aller Punkte
shapesmatwom=shapesmat-shapesmean'; %shapes without mean
[shapeseVal,shapeseVec]=pca(shapesmatwom,1); %pca berechnen
 
bnew=ones(10,1);
sampleshape1=generateShape(bnew,shapeseVec,shapesmean,0,1,0,0);
sampleshape2=generateShape(bnew,shapeseVec,shapesmean,90,1,0,0);
sampleshape3=generateShape(bnew,shapeseVec,shapesmean,90,0.5,50,0);
sampleshape4=generateShape(bnew,shapeseVec,shapesmean,90,1,50,100);
sampleshape5=generateShape(bnew,shapeseVec,shapesmean,60,2,0,0);

hold on
plot([sampleshape1(1,:),sampleshape1(1,1)],[sampleshape1(2,:),sampleshape1(2,1)])
plot([sampleshape2(1,:),sampleshape2(1,1)],[sampleshape2(2,:),sampleshape2(2,1)])
plot([sampleshape3(1,:),sampleshape3(1,1)],[sampleshape3(2,:),sampleshape3(2,1)])
plot([sampleshape4(1,:),sampleshape4(1,1)],[sampleshape4(2,:),sampleshape4(2,1)])
plot([sampleshape5(1,:),sampleshape5(1,1)],[sampleshape5(2,:),sampleshape5(2,1)])
axis equal
legend('normal','r:90deg','r:90deg,s:0.5,tx:50','r:90deg,tx:50,ty:100','r:60deg,s:2')

% % 2. Featureberechnung (7 Punkte) { Schreiben Sie eine Funktion computeFeatures(image),
% % die fur ein Bild die folgenden Features berechnet und als nfeatures  npixels
% % Matrix retourniert:
% %  Grauwert des Pixels
% %  Gradient in x- und y-Richtung
% %  Starke des Gradienten
% %  Haar-like Features2, berechnet auf dem Grauwertbild mithilfe der Funktion
% % computeHaarLike.m.
% %  Haar-like Features, berechnet auf der Gradientenstarke
% %  x- und y-Koordinaten des Pixels
% % Stellen Sie diese Features fur Bild 1 mit imagesc dar (von den Haar-like
% % jeweils nur das erste Feature). Sobald die Featureberechnung funktioniert,
% % kann sie einfach mit cache gecacht werden. Gerne konnen auch weitere Features
% % berechnet und evaluiert werden!

% % 3. Klassifikation & Feature-Selection (11 Punkte) Die Features werden
% % nun verwendet, um einen Klassifikator zu trainieren, der die Kanten des
% % zu segmentierenden Objekts klassifizieren soll. Wir verwenden Random Forests
% % 3, die in Matlab in der Klasse TreeBagger implementiert sind.
% % (a) Schreiben Sie eine Funktion train(images, masks), die fur jedes Bild
% % die Features berechnet und dann fur alle Trainingsbilder einen Random
% % Forest trainiert, mit den Masks als Klassenlabels. Ein Beispielaufruft
% % sieht z.B. so aus:
% % rf = TreeBagger(32,features',labels','OOBVarImp','on'); Hinweis:
% % Um das Trainieren zu beschleunigen, verwenden Sie alle Pixel der
% % Knochenkontur, aber nur ein zufallig auswahltes Subset der Hintergrundpixel
% % (gleichviele Samples fur Kontur/Hintergrund).

% % (b) Untersuchen und Interpretieren Sie den Ein
% % uss der Anzahl von Trees
% % mittels oobError
% % (c) Untersuchen und Interpretieren Sie die Wichtigkeit der verschiedenen
% % Features mittels plot(rf.OOBPermutedVarDeltaError).
% % 2http://www.cognotics.com/opencv/servo_2007_series/part_2/sidebar.html
% % 3http://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm

% % 4. Shape Particle Filters (17 Punkte) Wir formulieren eine Funktion, die
% % die Kosten modelliert, ein Shape auf ein Target-Bild zu plotten. D.h. wir suchen
% % im Parameterraum (Shape-Parameter zzgl Rotation, Skalierung, Translation)
% % einen Punkt, der ein moglichst gut passendes Shape beschreibt, dh eine
% % Segmentierung des Objekts.
% % (a) Erstellen Sie eine Funktion train, die auf den Trainingsbildern den
% % Klassifikator trainiert und das PCA Shape Modell erstellt, und eine
% % Funktion predict, die auf den Testbildern mit dem Klassifikator predicted.

% % (b) Erstellen Sie eine Kostenfunktion, die zu einem Paramtervektor p dem
% % Klassifikatorergebnis auf einem Testbild einen skalaren Wert liefert, der
% % umso kleiner wird, je besser das daraus generierte Shape auf das Klassi
% % katorergebnis (denWahrscheinlichkeiten fur den modellierten Knochen)
% % passt.

% % (c) Optimieren Sie diese Funktion fur jedes der Testbilder. Wir verwenden
% % dazu eine Methode aus dem Bereich der stochastischen Optimierung,
% % genannt Differential Evolution4, die sehr einfach ist, aber robust
% % und schnell konvergiert. Sie wird in optimize.m zur Verfugung gestellt.
% % Ein komplettes Beispiel zur Erstellung/Verwendung von Kostenfunktion/
% % Optimierung ndet sich in optimizeDEMO.m. Alternativ kann auch
% % die Matlab-Funktion ga verwendet werden, die einen genetischen Algorithmus
% % implementiert.

% % (d) Untersuchen Sie die Segmentiergenauigkeit Ihrer Methode (praktisch
% % hierfur zb boxplot). Interpretieren Sie den Ein
% % uss der einzelnen Schritte
% % des Algorithmus, beschreiben Sie von Ihnen untersuchte Varianten,
% % das Konvergenzverhalten etc.