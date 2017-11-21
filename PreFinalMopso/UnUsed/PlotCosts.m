function PlotCosts(pop,rep,temOpt)
%Plot the cost of selected particles
    % popCost = [pop.Cost];
    % pop_costs1=-[popCost(1,:)];
    % pop_costs2=-[popCost(2,:)];
    % plot(pop_costs1,pop_costs2,'ko');
    % hold on;
    
    temCost = [temOpt.Cost];
    tem_cost1 = -[temCost(1)];
    tem_cost2 = -[temCost(2)];
    plot(tem_cost1,tem_cost2,'bs');
    hold on;
    
    repCost = [rep.Cost];
    rep_costs1=-[repCost(1,:)];
    rep_costs2=-[repCost(2,:)];
    plot(rep_costs1,rep_costs2,'r*');
    
    xlabel('1^{st} Objective');
    ylabel('2^{nd} Objective');
    
    grid on;
    
    hold off;
    pause(0.1);


end