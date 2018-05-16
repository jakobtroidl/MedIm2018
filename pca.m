function [ evaldesc,evecdescnorm ] = pca( matrix, withMean )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
C=ourCov(matrix,withMean);
[evec,eval]=eig(C);
[evaldesc,id]=sort(diag(eval),'descend');
evecdesc=evec(:,id);
evecdescnorm = evecdesc./repmat(sqrt(sum(evecdesc.^2)),[size(evecdesc,1) ones(1,ndims(evecdesc)-1)]);
end

