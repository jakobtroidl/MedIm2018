
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

%verschiedene paramter zum generieren der shapes ausprobieren:
bnew=ones(10,1);
sampleshape1=generateShape(bnew,shapeseVec,shapesmean,0,1,0,0);
sampleshape2=generateShape(bnew,shapeseVec,shapesmean,90,1,0,0);
sampleshape3=generateShape(bnew,shapeseVec,shapesmean,90,0.5,50,0);
sampleshape4=generateShape(bnew,shapeseVec,shapesmean,90,1,50,100);
sampleshape5=generateShape(bnew,shapeseVec,shapesmean,60,2,0,0);

%plotten der generierten shapes:
figure();
hold on
plot([sampleshape1(1,:),sampleshape1(1,1)],[sampleshape1(2,:),sampleshape1(2,1)])
plot([sampleshape2(1,:),sampleshape2(1,1)],[sampleshape2(2,:),sampleshape2(2,1)])
plot([sampleshape3(1,:),sampleshape3(1,1)],[sampleshape3(2,:),sampleshape3(2,1)])
plot([sampleshape4(1,:),sampleshape4(1,1)],[sampleshape4(2,:),sampleshape4(2,1)])
plot([sampleshape5(1,:),sampleshape5(1,1)],[sampleshape5(2,:),sampleshape5(2,1)])
axis equal
legend('normal','r:90deg','r:90deg,s:0.5,tx:50','r:90deg,tx:50,ty:100','r:60deg,s:2')
hold off

% % 2. Featureberechnung (7 Punkte) { Schreiben Sie eine Funktion computeFeatures(image),
% % die fur ein Bild die folgenden Features berechnet und als nfeatures x npixels
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
% % berechnet und evaluiert werden.

addpath(genpath('providedFunctions'))%um auf die Funktionen des 'providedFunctions' Ordner direkt zuzugreifen zu können

image1 = cell2mat(handdata.images(1)); %Image 1 auswaehlen
imagesccache=computeFeatures(image1); %Features von Image 1 berechnen

%Features Zeilenvektoren in Matrix umschreiben und darstellen.
grayValues = vec2mat(imagesccache(1,:), 143);
xGradient = vec2mat(imagesccache(2,:), 143);
yGradient = vec2mat(imagesccache(3,:), 143);
gradientStrength = vec2mat(imagesccache(4,:), 143);
haarLike = vec2mat(imagesccache(5,:), 143);
haarLikeGradStrength = vec2mat(imagesccache(6,:), 143);
xCoord = vec2mat(imagesccache(7,:), 143);
yCoord = vec2mat(imagesccache(8,:), 143);

figure;
imagesc(grayValues);
axis equal
title('gray Values');

figure;
imagesc(xGradient);
axis equal
title('x Gradient');

figure;
imagesc(yGradient);
axis equal
title('y Gradient');

figure;
imagesc(gradientStrength);
axis equal
title('gradient Strength');

figure;
imagesc(haarLike);
axis equal
title('haar Like Features');

figure;
imagesc(haarLikeGradStrength);
axis equal
title('Haar features gradienr strength');

figure;
imagesc(xCoord);
axis equal
title('x-Coordinates');

figure;
imagesc(yCoord);
axis equal
title('y-Coordinates');

% % 3. Klassifikation & Feature-Selection (11 Punkte) Die Features werden
% % nun verwendet, um einen Klassifikator zu trainieren, der die Kanten des
% % zu segmentierenden Objekts klassifizieren soll. Wir verwenden Random Forests
% % 3, die in Matlab in der Klasse TreeBagger implementiert sind.
% % (a) Schreiben Sie eine Funktion train(images, masks), die fuer jedes Bild
% % die Features berechnet und dann fuer alle Trainingsbilder einen Random
% % Forest trainiert, mit den Masks als Klassenlabels. Ein Beispielaufruf
% % sieht z.B. so aus:
% % rf = TreeBagger(32,features',labels','OOBVarImp','on'); Hinweis:
% % Um das Trainieren zu beschleunigen, verwenden Sie alle Pixel der
% % Knochenkontur, aber nur ein zufaellig ausgewaehltes Subset der Hintergrundpixel
% % (gleichviele Samples fuer Kontur/Hintergrund).

images=handdata.images;
masks=handdata.masks;
[rf1,pcan]=cache(@train,images,masks,shapes,0); %shapes=aligned (=landmarks)
%view(rf.Trees{1},'Mode','graph'); %Tree anzeigen

% % (b) Untersuchen und Interpretieren Sie den Einfluss der Anzahl von
% % Trees mittels oobError

figure;
oobErrorBaggedEnsemble = oobError(rf1);
plot(oobErrorBaggedEnsemble)
xlabel 'Number of grown trees';
ylabel 'Out-of-bag classification error';

% % (c) Untersuchen und Interpretieren Sie die Wichtigkeit der verschiedenen
% % Features mittels plot(rf.OOBPermutedVarDeltaError).

figure;
bar(rf1.OOBPermutedVarDeltaError);
title('Curvature Test');
ylabel('Predictor importance estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = ({'Grauwerte','Grad-x','Grad-y','Grad-Staerke','HL Grauw','HL Grad-Staerke','x-Koord','y-Koord'});
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';

% % 4. Shape Particle Filters (17 Punkte) Wir formulieren eine Funktion, die
% % die Kosten modelliert, ein Shape auf ein Target-Bild zu plotten. D.h. wir suchen
% % im Parameterraum (Shape-Parameter zzgl Rotation, Skalierung, Translation)
% % einen Punkt, der ein moeglichst gut passendes Shape beschreibt, dh eine
% % Segmentierung des Objekts.

% % (a) Erstellen Sie eine Funktion train, die auf den Trainingsbildern den
% % Klassifikator trainiert und das PCA Shape Modell erstellt, und eine
% % Funktion predict, die auf den Testbildern mit dem Klassifikator predicted.

[rf,pcashape]=cache(@train,images,masks,shapes,1); %pcashape enthält PCA der 30 Trainingsbilder (pcashape=[shapesmean,shapeseVal,shapeseVec])

% -> predict.m

% Beispielhafte Darstellung (image 31):
testimage = cell2mat(handdata.images(31)); %Image 31 auswaehlen (1. Testimage)
[label,score,imagefeat]=predictsegmentation(rf,testimage); 
predcont = vec2mat(score(:,1),imagefeat(7,size(label,1)));
predcont = uint8(predcont.*255);
imshow(predcont)

% % (b) Erstellen Sie eine Kostenfunktion, die zu einem Paramtervektor p dem
% % Klassifikatorergebnis auf einem Testbild einen skalaren Wert liefert, der
% % umso kleiner wird, je besser das daraus generierte Shape auf das Klassi
% % katorergebnis (denWahrscheinlichkeiten fur den modellierten Knochen)
% % passt.

% -> costfunct.m

% % (c) Optimieren Sie diese Funktion fuer jedes der Testbilder. Wir verwenden
% % dazu eine Methode aus dem Bereich der stochastischen Optimierung,
% % genannt Differential Evolution4, die sehr einfach ist, aber robust
% % und schnell konvergiert. Sie wird in optimize.m zur Verfuegung gestellt.
% % Ein komplettes Beispiel zur Erstellung/Verwendung von Kostenfunktion/
% % Optimierung befindet sich in optimizeDEMO.m. Alternativ kann auch
% % die Matlab-Funktion ga() verwendet werden, die einen genetischen Algorithmus
% % implementiert.

minimums = [-30;0.75;-200;-200];
maximums = [30;1.25;200;200];

%fuer alle Testbiler berechnen (31-50):
for i=31:50
    clear testimage label score imagefeat predcont predscorecont testlandmarks
    tic
    testimage = cell2mat(handdata.images(i)); %Testimage auswaehlen
    [label,score,imagefeat]=predictsegmentation(rf,testimage); 
    predscorecont= vec2mat(score(:,2),imagefeat(7,size(label,1))); %Wahrscheinlichkeit, dass ein Pixel im Hintergrund liegt.
    
    costFunction = makeCostFunction(pcashape,predscorecont,@costfunct);
    drawPop = makedrawPopulation(pcashape,@drawPopulation);
    
    %ohne Ausgabe:
    optparameters=optimize(costFunction,minimums,maximums);
    
    %mit Ausgabe:
    %imshow(testimage)
    %hold on
    %optparameters=optimize(costFunction,minimums,maximums,drawPop);
    %hold off
    
    bnew=ones(sum((pcashape(:,2)/sum(pcashape(:,2)))>0.001),1); %nur jene Modes verwenden die mindest 0.1% der Gesamtvarianz beitragen.
    currentshape=generateShape(bnew,pcashape(:,3:end),pcashape(:,1)',optparameters(1),optparameters(2),optparameters(3),optparameters(4));
    
    %Speichern der Optima:
    optimum((i-30),1:4)=optparameters(1:4); %Optimumparameter
    optshapes((((i-30)*2)-1):((i-30)*2),:)=currentshape; %Optimumshapes
    opttime((i-30))=toc; %Berechnungszeit des Optimums
end

% %Darstellung der predicted und wahren Shape von image k (in unserem
% Report fuer k=31,37)
k=31;
bnew=ones(sum((pcashape(:,2)/sum(pcashape(:,2)))>0.001),1); %nur jene Modes verwenden die mindest 0.1% der Gesamtvarianz beitragen.
pcalandmarks=generateShape(bnew,pcashape(:,3:end),pcashape(:,1)',0,1,0,0);
truelandmarks= cell2mat(handdata.landmarks(k));
predlandmarks= optshapes(((k-31)*2+1):(k-30)*2,:);
imshow(uint8(cell2mat(handdata.images(k))))
hold on
plot([truelandmarks(1,:),truelandmarks(1,1)],[truelandmarks(2,:),truelandmarks(2,1)])
plot([predlandmarks(1,:),predlandmarks(1,1)],[predlandmarks(2,:),predlandmarks(2,1)])
plot([pcalandmarks(1,:),pcalandmarks(1,1)],[pcalandmarks(2,:),pcalandmarks(2,1)])
legend('TrueShape','PredictedShape','PcaShape')
hold off

% % (d) Untersuchen Sie die Segmentiergenauigkeit Ihrer Methode (praktisch
% % hierfur zb boxplot). Interpretieren Sie den Ein
% % uss der einzelnen Schritte
% % des Algorithmus, beschreiben Sie von Ihnen untersuchte Varianten,
% % das Konvergenzverhalten etc.

%Evaluierung der Segmentierungsgenauigkeit
landmarks = handdata.landmarks;
optshapes = load('optshapes.mat', 'optshapes');
optshapes = optshapes.optshapes;
j = 1;

for i = 31:50 %iteriere über alle Testshapes
    currLandmarks = cell2mat(landmarks(i));
    
    poly1 = polyshape(currLandmarks(1,:), currLandmarks(2,:)); %erstelle ein Polygon mit den "wahren" Shape-Landmarks
    poly2 = polyshape(optshapes(2 * (j-1) + 1,:), optshapes(2*(j-1) + 2,:)); %erstelle ein Polygon mit den predicted Shape-Landmarks
    
    intersection = intersect(poly1, poly2); %berechne das Durchschnittspolygon von poly1 und poly2
    
    values(:,j) = (area(poly1) + area(poly2) - 2 * area(intersection)) / area(poly1); %Validierungsformel aus der Vorlesung
    j= j + 1;
end

boxplot(values, {'Optimierter Algorithmus'}) %Validierungswerte sämtlicher Testimages in Boxplot darstellen.


%Vergleich des langsamen aber genauen Algorithmus mit dem Algorithmus, der in der
%Laufzeit verbessert wurde (siehe 4d im Bericht)
%Werte wurden vorher berechnet und im Workspace abgespeichert
short = load('segQualityShort.mat');
short = short.shortValues;

opt = load('segQualityOpt.mat');
opt = opt.optValues;

boxplot([opt; short]', {'32', '10'});