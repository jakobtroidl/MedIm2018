function [ xnew ] = generateShape( bnew,shapeseVec,shapesmean)
shapeseVech=shapeseVec(:,1:size(bnew,1));%relevanten Eigenvektoren, abhaengig von der Laenge von bnew
xnew=shapeseVech*bnew+shapesmean';%neues shape berechnen
end

