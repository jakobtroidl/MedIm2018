function [ ausgabe ] = ourCov( matrix, withMean )
    med=mean(transpose(matrix)); %Mittelwerte berechnen
    rep = repmat(transpose(med),1,size(matrix,2));
    matomed=matrix-withMean.*rep; %Mittelwerte von der Matrix subtrahieren
    
    %Kovarianzen berechnen: Cov(x(i),x(j))
    for i=1:size(matomed,1)
       for j=i:size(matomed,1)
           ausgabe(j,i)=sum(matomed(i,:).*(matomed(j,:)))/(size(matomed,2)-1); %untere Dreiecksmatrix berechnen wobei in der Hauptdiagonale die Varianzen stehen (Cov(x(i),x(i))=Var(x(i)))
           if i~=j
               ausgabe(i,j)=ausgabe(j,i); %obere Dreiecksmatrix auffüllen, da die Kovarianzmatrix symmetrisch ist
           end 
       end     
    end
    
end
