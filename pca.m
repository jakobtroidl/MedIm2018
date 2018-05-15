function [ evaldesc,evecdesc ] = pca( matrix )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
C=ourCov(matrix);
[evec,eval]=eig(C);
[evaldesc,id]=sort(diag(eval),'descend');
evecdesc=evec(:,id);
end

