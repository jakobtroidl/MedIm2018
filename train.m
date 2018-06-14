function [rf,pcashape] = train(images,masks,shapes,bsp4)
%treebagger matlab funktion
pcashape=0; %output bei bsp3

rng(1) %zur Reproduzierbarkeit der Ergebnisse

for i=1:30
    %Featurematrizen der Trainingsbilder Blockspaltenweise in einer
    %Gesamtmatrix gespeichert
    if i==1
        features=computeFeatures(cell2mat(images(i)));
    else
        features=[features,computeFeatures(cell2mat(images(i)))];
    end
    
    
    %masks als Klassenlabels verwenden (10=Kontur, 0=Hintergrund) ->
    %gleichviele, zufällige Hintergrundpixel wie Konturpixel als Label verwenden
    currentmask=cell2mat(masks(i));
    %Currentmask als Zeilenvektor speichern
    clear label
    for j=1:size(currentmask,1)
        label(1,((j-1)*size(currentmask,2)+1):(j*size(currentmask,2)))=currentmask(j,:); 
    end
    anzkonturpixel=sum(sum(label==10)); %Anzahl Konturpixel
    zeoroind=find(label==0); %Indizes wo label==0 (Hintergrundpixel)
    backgroundlabel=zeoroind(randperm(size(zeoroind,2),anzkonturpixel)); %Zufällige Auswahl an Hintergrundpixelindizes
    label(backgroundlabel)=5; %Zuweisung der Hintergrundpixel zum Label(label<>0), aber mit 5 gespeichert zur Unterscheidung von Konturpixel

    %Labels in Gesamtmatrix abspeichern
    if i==1
        labelgesamt=label;
    else    
        labelgesamt=[labelgesamt,label];
    end
    
end

%Training beschraenken auf die Konturpixel und das zufaellig ausgewaehlte
%Subset der Hintergrundpixel
impLabelsInd=find(labelgesamt~=0); %Indizes aller trainingsrelevanten Pixel
LabelFeatures=double(features(:,impLabelsInd)); %Die zugehoerigen Features zu den trainingsrelevanten Pixel und die Umwandlung von uint8 in double um die implementierte TreeBagger Funktion ordentlich verwenden zu koennen.
impLabels=labelgesamt(impLabelsInd); %Labels aller trainingsrelevanten Pixel

%Aufruf der implementierten TreeBagger Funktion:
rf=TreeBagger(32,LabelFeatures',impLabels','OOBVarImp','on'); %Baumanzahl:32

    if bsp4
        
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
        pcashape=[shapesmean',shapeseVal,shapeseVec]; %ausgabe bei bsp4       
    end
end

