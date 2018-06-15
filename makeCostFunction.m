function f = makeCostFunction(pcashape,predscorecont,meanxyzent,costfun)
    f = @costFunction;
    function c = costFunction(params)
        c = costfun(pcashape,predscorecont,meanxyzent,[round(params(1),2),round(params(2),2),round(params(3),2),round(params(4),2)]);
    end
end