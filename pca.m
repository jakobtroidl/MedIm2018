function [ evaldesc,evecdescnorm ] = pca( matrix, withMean )
C=ourCov(matrix,withMean); %Varianz Kovarianz Matrix berechnen
[evec,eval]=eig(C); %Eigenvektor und Eigenwerte der Varianz Kovarianz Matrix berechnen
[evaldesc,id]=sort(diag(eval),'descend'); %Eigenwerte absteigend sortieren und Sortierung in id speichern
evecdesc=evec(:,id); %Eigenvekoteren mit der Sortierung der Eigenwerte umsortieren
evecdescnorm = evecdesc./repmat(sqrt(sum(evecdesc.^2)),[size(evecdesc,1) ones(1,ndims(evecdesc)-1)]); %Eigenvektoren normieren
end
