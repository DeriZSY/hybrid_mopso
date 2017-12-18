clc;
clear;
close all;


nVar=2;             % Number of Decision Variables


VarSize=[1 nVar];   % Size of Decision Variables Matrix


VarMinF=[0   0 ];          % Lower Bound of Feasible Area
VarMaxF=[1   1 ];          % Upper Bound of Feasible Area


VarMin= VarMinF;          % Lower Bound of Variables
VarMax= VarMaxF;          % Upper Bound of Variables

CostFunction=@(x) Fitness(x,VarMinF,VarMaxF);      % Cost Function

%% MOPSO Parameters

MaxIt=100;           % Maximum Number of Iterations

nPop=100;            % Population Size

nRep=50;            % Repository Size
w=0.6;              % Inertia Weight
wdamp=0.996;        % Intertia Weight Damping Rate
c1=1.41;            % Personal Learning Coefficient
c2=2;               % Global Learning Coefficient

nGrid=3;            % Number of Grids per Dimension
alpha=0.1;          % Inflation Rate

beta=2;             % Leader Selection Pressure
gamma=2;            % Deletion Selection Pressure
epsilon = 1;        % Weight between each objective

mu=0.4;             % Mutation Rate

%% Initialization
empty_particle.Position=[];
empty_particle.Velocity=[];
empty_particle.Cost=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
empty_particle.IsDominated=[];
empty_particle.GridIndex=[];
empty_particle.GridSubIndex=[];

empty_particle.PF=[];% Feseability of personal best position
empty_particle.CF=[];% Feseability of current position


pop=repmat(empty_particle,nPop,1);

%% Initialize Particles
for i=1:nPop 
    %Initialize Position
    for j=1:nVar
        pop(i).Position(j)=VarMinF(j)+(VarMaxF(j)-VarMinF(j))*rand();
    end
    %Initialize Velocity
    pop(i).Velocity=zeros(VarSize);
    
    %Evaluate Cost
    pop(i).Cost=CostFunction(pop(i).Position); 
    
    %Initialize Feasibility 
    pop(i).CF = fesibJudge(pop(i),VarMinF,VarMaxF,nVar); 
    % Update Personal Best
    pop(i).Best.Position=pop(i).Position;
    pop(i).Best.Cost=pop(i).Cost;
    pop(i).Best.CF = fesibJudge(pop(i),VarMinF,VarMaxF,nVar); 
    pop(i).Best.PF = pop(i).CF;
end

% Determine Domination
pop=DetermineDomination(pop);%set pop.IsDominated

rep=pop(~[pop.IsDominated]);%rep = is not dominated

Grid=CreateGrid(rep,nGrid,alpha); % for not dominated, put into rep and create Grid

% Find Grid Index for non-domniated solutions
for i=1:numel(rep)
    rep(i)=FindGridIndex(rep(i),Grid,epsilon);
end

% Print Lines
fprintf('[ 0 ]');


%% MOPSO Main Loop

for it=1:MaxIt % Iterate inside the limitation
    
    for i=1:nPop
        
        leader=SelectLeader(rep,beta); % Select a leader for the group

        % Get Velocity
        pop(i).Velocity = w*pop(i).Velocity ...
            +c1*rand(VarSize).*(pop(i).Best.Position-pop(i).Position) ...
            +c2*rand(VarSize).*(leader.Position-pop(i).Position);
        
        % Get new Position
        pop(i).Position = pop(i).Position + pop(i).Velocity;
        
        % Extend Variable Boundary
        for j=1:nVar
            VarMin(j) = min(pop(i).Position(j), VarMin(j));
            VarMax(j) = max(pop(i).Position(j), VarMax(j));
        end

        % Evaluate Cost
        pop(i).Cost = CostFunction(pop(i).Position);
        
        % Evaluate Feasiblity
        pop(i).CF = fesibJudge(pop(i),VarMinF,VarMaxF,nVar);

        % Get Mutation Rate
        pm=(1-(it-1)/(MaxIt-1))^(1/mu); 
        if rand<pm
            % Apply Mutation    
            NewSol = pop(i);
            NewSol.Position=Mutate(pop(i).Position,pm,min(VarMin),max(VarMax));
            NewSol.Cost= CostFunction(NewSol.Position);
            NewSol.CF  = fesibJudge(NewSol,VarMinF,VarMaxF,nVar);

            %% Update pop(i) with newSol
            if Dominates(NewSol,pop(i))
                pop(i).Position=NewSol.Position;
                pop(i).Cost=NewSol.Cost;
                pop(i).CF= fesibJudge(pop(i),VarMinF,VarMaxF,nVar);

            % else, nothing will be done
            elseif Dominates(pop(i),NewSol)
                % Do Nothing
            % if cost of pop(i) and newSol does not dominate each other & rand<0.5, cover pop(i) with new Sol        
            else
                if rand<0.5
                    pop(i).Position=NewSol.Position;
                    pop(i).Cost=NewSol.Cost;
                    pop(i).CF= fesibJudge(pop(i),VarMinF,VarMaxF,nVar);
                end
            end
        end
        
        % Upgrade pbest with pop(i)
        if Dominates(pop(i),pop(i).Best)
            pop(i).Best.Position=pop(i).Position;
            pop(i).Best.Cost=pop(i).Cost;
            pop(i).PF = pop(i).CF;

        elseif Dominates(pop(i).Best,pop(i))
            % Do Nothing
            
        else
            if rand<0.5
                pop(i).Best.Position=pop(i).Position;
                pop(i).Best.Cost=pop(i).Cost;
            end
        end
        
    end
    

    % Add new Non-Dominated Particle to REPOSITORY (a new leader)
    rep=[rep 
        pop(~[pop.IsDominated])]; 
    
    % Determine Domination of New Resository Members
    rep=DetermineDomination(rep);
    
    % Keep Only the Non-Dminated Memebr in the Repository
    rep=rep(~[rep.IsDominated]);
    
    % Update Grid for repository
    Grid=CreateGrid(rep,nGrid,alpha);

    % Update Grid Index for repository
    for i=1:numel(rep)
        rep(i)=FindGridIndex(rep(i),Grid,epsilon);
    end
    
    % Check if Repository is Full
    if numel(rep)>nRep
        % if full, delete extra members
        % uses same way of select leader, assign greater probability to those with greater fitness 
        Extra=numel(rep)-nRep;
        for e=1:Extra
            rep=DeleteOneRepMemebr(rep,gamma);
        end
        
    end
    
    %% Plot Costs

    % figure(1);
    % PlotCosts(pop,rep);
    % pause(0.3);
    
    % Show Iteration Information
    % disp(['Iteration ' num2str(it) ': Number of Rep Members = ' num2str(numel(rep))]);
    % Damping Inertia Weight
       w=w*wdamp;
    % Plot Process Bar
    if rem(it,5) == 0   
        clc;
        fprintf('Run %d\n',it);   
        finRate = it/MaxIt * 100;
        fprintf('[');
        for i = 1:finRate
            fprintf('*');
        end
            fprintf('  %s%% ',num2str(finRate)); 
            fprintf(']');  
    end     
end

%% Results
optima =FindOptima(rep,beta);

for i = 1 : numel(rep)
    fprintf('Cost functions:\nf1: %d\nf2: %d\n',optima.Cost(1),optima.Cost(2));
    fprintf('Grid Index: %d\nGrid SubIndex %d (x) and %d (y)\n\n',optima.GridIndex(1),optima.GridSubIndex);
end
% Plot Pareto Surface  
figure;
    rep_costs=[rep.Cost];
    plot(rep_costs(1,:),rep_costs(2,:),'r*');
    xlabel('1^{st} Objective');
    ylabel('2^{nd} Objective');
    grid on; 
    hold on;
% Plot Optima 
plot(optima.Cost(1,:),optima.Cost(2,:),'bs','MarkerSize',15);


