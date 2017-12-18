clc;
clear;
close all;

%% Problem Definition

CostFunction=@(x) ZDT(x);      % Cost Function

nVar=5;             % Number of Decision Variables

% One cost function and 5 decision variables

VarSize=[1 nVar];   % Size of Decision Variables Matrix

VarMin=0;          % Lower Bound of Variables
VarMax=1;          % Upper Bound of Variables


%% MOPSO Parameters

MaxIt=200;           % Maximum Number of Iterations

nPop=200;            % Population Size

nRep=100;            % Repository Size

w=0.5;              % Inertia Weight
wdamp=0.99;         % Intertia Weight Damping Rate
c1=1;               % Personal Learning Coefficient
c2=2;               % Global Learning Coefficient

nGrid=7;            % Number of Grids per Dimension
alpha=0.1;          % Inflation Rate

beta=2;             % Leader Selection Pressure
gamma=2;            % Deletion Selection Pressure

mu=0.1;             % Mutation Rate

%% Initialization

empty_particle.Position=[];
empty_particle.Velocity=[];
empty_particle.Cost=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
empty_particle.IsDominated=[];
empty_particle.GridIndex=[];
empty_particle.GridSubIndex=[];

% pop is an array of 200 populations of structure
% with : Position, velocity,cost, best, IsDominated, GridIndex, GirdSubIndex
pop=repmat(empty_particle,nPop,1);

for i=1:nPop %go over all praticles and Initialize
    
    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);%initialize position
    
    pop(i).Velocity=zeros(VarSize);%set original velocity to 0
    
    pop(i).Cost=CostFunction(pop(i).Position);%calculate the cost at certain position
    
    
    % Update Personal Best
    pop(i).Best.Position=pop(i).Position;
    pop(i).Best.Cost=pop(i).Cost;
    
end

% Determine Domination
% pick out the ones with smaller cost, and put the rest ones into repository
pop=DetermineDomination(pop);%set pop.IsDominated

rep=pop(~[pop.IsDominated]);%rep = is not dominated

Grid=CreateGrid(rep,nGrid,alpha); % for not dominated, put into rep and create Grid

for i=1:numel(rep)
    rep(i)=FindGridIndex(rep(i),Grid);
end


%% MOPSO Main Loop

for it=1:MaxIt % Iterate in the limitation
    
    for i=1:nPop % go through all the population
        
        leader=SelectLeader(rep,beta); % get leader 
        % get velocity of population
        pop(i).Velocity = w*pop(i).Velocity ...
            +c1*rand(VarSize).*(pop(i).Best.Position-pop(i).Position) ...
            +c2*rand(VarSize).*(leader.Position-pop(i).Position);
        % get new Position
        pop(i).Position = pop(i).Position + pop(i).Velocity;
        % reset boundary to fit Position
        pop(i).Position = max(pop(i).Position, VarMin);
        pop(i).Position = min(pop(i).Position, VarMax);
        % calculate cost
        pop(i).Cost = CostFunction(pop(i).Position);
        
        % Apply Mutation
        % it is iteration times 
        pm=(1-(it-1)/(MaxIt-1))^(1/mu);
        if rand<pm
        % Apply mutation and keep the better one with costs
            %Apply Mutation
            NewSol.Position=Mutate(pop(i).Position,pm,VarMin,VarMax);
            NewSol.Cost=CostFunction(NewSol.Position);
            %% Upgrade pop(i) with newSol
            % if cost of NewSol(ution) dominates pop(i) cover pop(i) with newSol
            if Dominates(NewSol,pop(i))
                pop(i).Position=NewSol.Position;
                pop(i).Cost=NewSol.Cost;
            % else, nothing will be done
            elseif Dominates(pop(i),NewSol)
                % Do Nothing
             % if cost of pop(i) and newSol does not dominate each other & rand<0.5, cover pop(i) with new Sol        
            else
                if rand<0.5
                    pop(i).Position=NewSol.Position;
                    pop(i).Cost=NewSol.Cost;
                end
            end
        end
         % Upgrade pbest with pop(i)
            pop(i).Best.Position=pop(i).Position;
            pop(i).Best.Cost=pop(i).Cost;
            
        elseif Dominates(pop(i).Best,pop(i))
            % Do Nothing
            
        else
            if rand<0.5
                pop(i).Best.Position=pop(i).Position;
                pop(i).Best.Cost=pop(i).Cost;
            end
        end
        
    end
    
    % Add Non-Dominated Particles to REPOSITORY
    rep=[rep
         pop(~[pop.IsDominated])]; %#ok
    
    % Determine Domination of New Resository Members
    rep=DetermineDomination(rep);
    
    % Keep only Non-Dminated Memebrs in the Repository
    rep=rep(~[rep.IsDominated]);
    
    % Update Grid
    Grid=CreateGrid(rep,nGrid,alpha);

    % Update Grid Index for repository
    for i=1:numel(rep)
        rep(i)=FindGridIndex(rep(i),Grid);
    end
    
    % Check if Repository is Full
    if numel(rep)>nRep
        
        Extra=numel(rep)-nRep;
        for e=1:Extra
            rep=DeleteOneRepMemebr(rep,gamma);
        end
        
    end
    
    % Plot Costs
    figure(1);
    PlotCosts(pop,rep);
    pause(0.01);
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Number of Rep Members = ' num2str(numel(rep))]);
    
    % Damping Inertia Weight
    w=w*wdamp;
    
end

%% Resluts

