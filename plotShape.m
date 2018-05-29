function [] = plotShape( shapeseVal,shapeseVec,shapesmean )
numposeVal=sum(shapeseVal>0.0000000001);%Anzahl Eigenwerte > 0

B=eye(numposeVal); %Einheitsmatrix, um die einzelnen Modes (Informationen der einzelnen Eigenvektoren) darstellen zu können
for i=1:numposeVal
    %Zufallszahl im Bereich +/-3*Standardabweichung (=sqrt(Varianz)) aller
    %Spalten, wobei die Varianz dem Eigenwert entspricht des jeweiligen Modes. 
    B(i,i)=(rand-1/2)*2*sqrt(shapeseVal(i))*3; %Zuf�llige Genierierung von neuen b's im Intervall der 3 fachen Standardabweichung des i-ten Parameters
    genmat(:,i)=generateShape(B(:,i),shapeseVec,shapesmean);%shape generieren mit dem jeweiligen Mode
end

%set(p(1),'Color','red', 'LineWidth', 3);

%plotten von shapes mean
b0=zeros(numposeVal,1);%Nullvektor
genmean=generateShape(b0,shapeseVec,shapesmean);%generiere mean shape mit Nullvektor

subplot(2,2,1)
hold on
plot([genmat(1:2:256,1);genmat(1,1)],[genmat(2:2:256,1);genmat(2,1)],'b');%plotten des 1. Modes in blau
plot([genmean(1:2:256);genmean(1)],[genmean(2:2:256);genmean(2)],'r');%plot generierte mean shape in rot
axis equal
hold off
legend('1. Mode', 'Mean Shape')
title('1.Mode')

subplot(2,2,2)
hold on
plot([genmat(1:2:256,2);genmat(1,2)],[genmat(2:2:256,2);genmat(2,2)],'b');%plotten des 2. Modes in blau   
plot([genmean(1:2:256);genmean(1)],[genmean(2:2:256);genmean(2)],'r');%plot generierte mean shape in rot
axis equal
hold off
legend('2. Mode', 'Mean Shape')
title('2.Mode')

subplot(2,2,3)
hold on
plot([genmat(1:2:256,3);genmat(1,3)],[genmat(2:2:256,3);genmat(2,3)],'b');%plotten des 3. Modes in blau   
plot([genmean(1:2:256);genmean(1)],[genmean(2:2:256);genmean(2)],'r');%plot generierte mean shape in rot
axis equal
hold off
legend('3. Mode', 'Mean Shape')
title('3.Mode')

subplot(2,2,4)
hold on
for i=4:numposeVal
    plot([genmat(1:2:256,i);genmat(1,i)],[genmat(2:2:256,i);genmat(2,i)],'b');%plotten des 4.-13. Modes in blau   
end
plot([genmean(1:2:256);genmean(1)],[genmean(2:2:256);genmean(2)],'r');%plot generierte mean shape in rot
axis equal
hold off
title('4.-13.Mode')




