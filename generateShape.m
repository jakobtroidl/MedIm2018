%bnew...Parametervektor 
function [ xnew ] = generateShape( bnew,shapeseVec,shapesmean)
shapeseVech=shapeseVec(:,1:size(bnew,1));%relevanten Eigenvektoren, abhaengig von der Laenge von bnew, z.b. size(bnew)=4 --> erste 4 eigenvektoren
xnew=shapeseVech*bnew+shapesmean';%neues shape berechnen (Formel aus den Folien umgeformt)
%inv(transpose(shapeseVech)) = shapeseVech da die Kovarianzmatrix orthogonal ist und damit auch die Eigenvektoren
end

