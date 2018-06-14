function totalcost = costfunct( pcashape, contscore,p )
%Input Variables: pcashape=[shapesmean,shapeseVal,shapeseVec] .. Array der
%PCA der Trainingsbilder (1-30)
%p=[r,s,tx,ty].. Parametervektor(r=rotation, s=skalierung, tx=translation
%in x, ty=translation in y)
%contscore.. Wahrscheinlichkeit das ein Pixel eine Kontur ist.

bnew=ones(sum((pcashape(:,2)/sum(pcashape(:,2)))>0.001),1); %nur jene Modes verwenden die mindest 0.1% der Gesamtvarianz beitragen.
currentshape=generateShape(bnew,pcashape(:,3:end),pcashape(:,1)',p(1),p(2),p(3),p(4));

totalcost=0;
for i=1:size(currentshape,2) %Schleifenberechnung ueber alle Punkte
    [c1,c2,contprob]=improfile(contscore,currentshape(1,i),currentshape(2,i)); %contprob.. Wahrscheinlichkeit, dass der Punkt auf der Kontur liegt( also im Intervall [0,1])
    if isnan(contprob)
        cost=100000; %wenn contprob=NaN, dann werden enorm hohe Kosten aufgeschlagen (100000), denn dann liegt der Punkt nicht mal auf dem Klassifikatorergebnis/Pixelbild
    else
        cost=abs(contprob-1)*1000; %den Wahrscheinlichkeiten Kosten zuordnen, wobei bei einer Wahrscheinlichkeit von 0, dass der Punkt eine Kontur ist Kosten von 1000 aufgeschlagen werden und diese bis zur Wahrscheinlichkeit 1 auf 0 sinken.
    end
    totalcost=totalcost+cost; %Die Kosten des einzelnen Punktes den Gesamtkosten aufschlagen
end

end

