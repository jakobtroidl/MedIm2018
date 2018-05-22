function [] = plotShape( shapeseVal,shapeseVec,shapesmean )
numposeVal=sum(shapeseVal>0.0000000001);%Anzahl Eigenwerte > 0

hold on
B=eye(numposeVal); %Einheitsmatrix 
for i=1:numposeVal;
    %Zufallszahl im Bereich +/-3*Standardabweichung (=sqrt(Varianz)) aller
    %Spalten, wobei die Varianz dem Eigenwert entspricht des jeweiligen Modes. 
    B(i,i)=(rand-1/2)*2*sqrt(shapeseVal(i))*3;
    genmat(:,i)=generateShape(B(:,i),shapeseVec,shapesmean);%shape generieren mit dem jeweiligen Mode
    plot([genmat(1:2:256,i);genmat(1,i)],[genmat(2:2:256,i);genmat(2,i)],'b');%plotten des shapes in blau
end

b0=zeros(numposeVal,1);%Nullvektor
genmean=generateShape(b0,shapeseVec,shapesmean);%generiere mean shape mit Nullvektor
plot([genmean(1:2:256);genmean(1)],[genmean(2:2:256);genmean(2)],'r');%plot generierte mean shape in rot
hold off
