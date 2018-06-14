
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

addpath(genpath('providedFunctions'))

image1 = cell2mat(handdata.images(1)); %Image 1 auswaehlen
imagesccache=cache(@computeFeatures,image1); %FEHLER!!!!!!!! welcher input par???

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

% % % % % % % LOESCHEN!! nur zur Darstellung 
% % % % % % landmarks1=cell2mat(handdata.landmarks(1));
% % % % % % figure();
% % % % % % imshow(image1);
% % % % % % hold on
% % % % % % plot([landmarks1(1,:),landmarks1(1,1)],[landmarks1(2,:),landmarks1(2,1)]);
% % % % % % hold off
% % % % % % masks1=cell2mat(handdata.masks(1));
% % % % % % figure();
% % % % % % imshow(masks1);

images=handdata.images;
masks=handdata.masks;
[rf,pcan]=cache(@train,images,masks,shapes,0); %shapes=aligned (=landmarks)
%%%%%%%%%%%%%LOESCHEN!! view(rf.Trees{1},'Mode','graph'); 

% % (b) Untersuchen und Interpretieren Sie den Einfluss der Anzahl von
% % Trees mittels oobError

figure;
oobErrorBaggedEnsemble = oobError(rf);
plot(oobErrorBaggedEnsemble)
xlabel 'Number of grown trees';
ylabel 'Out-of-bag classification error';

%--> Der 'out-of-bag error' nimmt mit wachsender Anzahl an Baeumen ab. ->
%15 wäre schon sehr gut und bezueglich Laufzeit eventuell besser.

% % (c) Untersuchen und Interpretieren Sie die Wichtigkeit der verschiedenen
% % Features mittels plot(rf.OOBPermutedVarDeltaError).

figure;
bar(rf.OOBPermutedVarDeltaError);
title('Curvature Test');
ylabel('Predictor importance estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = ({'Grauwerte','Grad-x','Grad-y','Grad-Staerke','HL Grauw','HL Grad-Staerke','x-Koord','y-Koord'});
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';

%--> In diesem Fall ist die x-Koordinate der wichtigste Prädikator, gefolgt
%von der y-Koordinate, der Gradientenstaerke und dem Grauwert.


% % 4. Shape Particle Filters (17 Punkte) Wir formulieren eine Funktion, die
% % die Kosten modelliert, ein Shape auf ein Target-Bild zu plotten. D.h. wir suchen
% % im Parameterraum (Shape-Parameter zzgl Rotation, Skalierung, Translation)
% % einen Punkt, der ein moglichst gut passendes Shape beschreibt, dh eine
% % Segmentierung des Objekts.

% % (a) Erstellen Sie eine Funktion train, die auf den Trainingsbildern den
% % Klassifikator trainiert und das PCA Shape Modell erstellt, und eine
% % Funktion predict, die auf den Testbildern mit dem Klassifikator predicted.

[rf,pcashape]=train(images,masks,shapes,1); %pcashape enthält PCA der 30 Trainingsbilder (pcashape=[shapesmean,shapeseVal,shapeseVec])

% LOESCHEN: (fuer Report)
image31 = cell2mat(handdata.images(31)); %Image 31 auswaehlen (1. Testimage)
[label,score,imagefeat]=predictsegmentation(rf,image31); 
predcont = vec2mat(label,imagefeat(7,size(label,1)));
predscorecont= vec2mat(score(:,1),imagefeat(7,size(label,1))); %Wahrscheinlichkeit, dass ein Pixel Kontur ist
predcont = uint8(predcont);
predcont(predcont==5)=0;
predcont(predcont==10)=255;
imshow(predcont)
hold on
landmarks31=cell2mat(handdata.landmarks(31));
plot([landmarks31(1,:),landmarks31(1,1)],[landmarks31(2,:),landmarks31(2,1)]);
hold off

% % (b) Erstellen Sie eine Kostenfunktion, die zu einem Paramtervektor p dem
% % Klassifikatorergebnis auf einem Testbild einen skalaren Wert liefert, der
% % umso kleiner wird, je besser das daraus generierte Shape auf das Klassi
% % katorergebnis (denWahrscheinlichkeiten fur den modellierten Knochen)
% % passt.

%LOESCHEN, fuer image31
costfunct(pcashape,predscorecont,[0,1,0,0])
costfunct(pcashape,predscorecont,[0,1,70,160])

% % (c) Optimieren Sie diese Funktion fuer jedes der Testbilder. Wir verwenden
% % dazu eine Methode aus dem Bereich der stochastischen Optimierung,
% % genannt Differential Evolution4, die sehr einfach ist, aber robust
% % und schnell konvergiert. Sie wird in optimize.m zur Verfugung gestellt.
% % Ein komplettes Beispiel zur Erstellung/Verwendung von Kostenfunktion/
% % Optimierung ndet sich in optimizeDEMO.m. Alternativ kann auch
% % die Matlab-Funktion ga verwendet werden, die einen genetischen Algorithmus
% % implementiert.



minimums = [-30;0.75;-200;-200];
maximums = [30;1.25;200;200];
costFunction = makeCostFunction(pcashape,predscorecont,@costfunct);
optparameters=optimize(costFunction,minimums,maximums);

costfunct(pcashape,predscorecont,optparameters')

bnew=ones(sum((pcashape(:,2)/sum(pcashape(:,2)))>0.001),1); %nur jene Modes verwenden die mindest 0.1% der Gesamtvarianz beitragen.
currentshape=generateShape(bnew,pcashape(:,3:end),pcashape(:,1)',optparameters(1),optparameters(2),optparameters(3),optparameters(4));
imshow(image31)
hold on
plot([currentshape(1,:),currentshape(1,1)],[currentshape(2,:),currentshape(2,1)])
hold off

%mit darstellung.. 
%optimize(costFunction,minimums,maximums,@drawPopulation);
function h = drawPopulation(population, bestInd)
    h(1) = plot(population(1,:),population(2,:),'wx'); hold on
    h(2) = plot(population(1,:),population(2,:),'b+'); hold on
    h(3) = plot(population(1,bestInd),population(2,bestInd),'g+');
end



% % (d) Untersuchen Sie die Segmentiergenauigkeit Ihrer Methode (praktisch
% % hierfur zb boxplot). Interpretieren Sie den Ein
% % uss der einzelnen Schritte
% % des Algorithmus, beschreiben Sie von Ihnen untersuchte Varianten,
% % das Konvergenzverhalten etc.

%kontrast des bildes aendern