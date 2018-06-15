function h = drawPopulation(pcashape,meanxyzent,params,bestInd)
    bnew=ones(sum((pcashape(:,2)/sum(pcashape(:,2)))>0.001),1);
    %for i=1:size(params,2)
    %    currentshape=generateShape(bnew,pcashape(:,3:end),pcashape(:,1)',params(1,i),params(2,i),params(3,i)+meanxyzent(1),params(4,i)+meanxyzent(2));
    %    h(i) = plot(currentshape(1,:),currentshape(2,:),'wx'); hold on
    %end
    currentshape=generateShape(bnew,pcashape(:,3:end),pcashape(:,1)',params(1,bestInd),params(2,bestInd),params(3,bestInd)+meanxyzent(1),params(4,bestInd)+meanxyzent(2));    
    h(size(params,2)+1) = plot([currentshape(1,:),currentshape(1,1)],[currentshape(2,:),currentshape(2,1)],'g');
end

