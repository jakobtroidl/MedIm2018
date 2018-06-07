%bnew...Parametervektor 
function [xnewty] = generateShape( bnew,shapeseVec,shapesmean,r,s,tx,ty)
shapeseVech=shapeseVec(:,1:size(bnew,1));%relevanten Eigenvektoren, abhaengig von der Laenge von bnew, z.b. size(bnew)=4 --> erste 4 eigenvektoren
xnew=shapeseVech*bnew+shapesmean';%neues shape berechnen (Formel aus den Folien umgeformt)

xnewums(1,:)=xnew(1:2:128);
xnewums(2,:)=xnew(2:2:128);

%skalierungsmatrix
S=[ s 0; 0 s];
xnewskal=S*xnewums;

%rotationsmatrix
R=[ cosd(r) -sind(r); sind(r) cosd(r)];
xnewrot=R*xnewskal;

%transx
xnewtx=xnewrot+[tx;0];

%transy
xnewty=xnewtx+[0;ty];
end
