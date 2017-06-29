function PlotCosts(pop,rep)
%Plot the cost of selected particles
    pop_costs=[pop.Cost];
    plot(pop_costs(1,:),pop_costs(2,:),'ko');
    hold on;
    
    rep_costs=[rep.Cost];
    plot(rep_costs(1,:),rep_costs(2,:),'r*');
    
    xlabel('1^{st} Objective');
    ylabel('2^{nd} Objective');
    
    grid on;
    
    hold off;

end