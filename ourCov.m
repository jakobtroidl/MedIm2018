%author: oliver
function [ ausgabe ] = ourCov( matrix )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    med=mean(transpose(matrix));
    rep = repmat(transpose(med),1,size(matrix,2));
    matomed=matrix-rep;
    
    for i=1:size(matomed,1)
       for j=i:size(matomed,1)
           ausgabe(j,i)=sum(matomed(i,:).*(matomed(j,:)))/(size(matomed,2)-1);
           if i~=j
               ausgabe(i,j)=ausgabe(j,i);
           end 
       end     
    end
    
end

