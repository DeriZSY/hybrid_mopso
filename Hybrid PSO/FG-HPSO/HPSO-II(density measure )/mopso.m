clc;
clear;
close all;

%% Problem Definition



nVar=2;             % Number of Decision Variables

% One cost function and 5 decision variables
%doc, fa, vs
VarSize=[1 nVar];   % Size of Decision Variables Matrix


VarMinF=[0   0 ];          % Lower Bound of Variables
VarMaxF=[5   3 ];          % Upper Bound of Variables


VarMin= VarMinF;          % Lower Bound of Variables
VarMax= VarMaxF;          % Upper Bound of Variables

CostFunction=@(x) Fitness(x,VarMinF,VarMaxF);      % Cost Function

%% MOPSO Parameters

MaxIt=200;           % Maximum Number of Iterations

nPop=200;            % Population Size

nRep=150;            % Repository Size

w=0.5;              % Inertia Weight
wdamp=0.99;         % Intertia Weight Damping Rate
c1=1.47;               % Personal Learning Coefficient
c2=2;               % Global Learning Coefficient

nGrid=7;            % Number of Grids per Dimension
alpha=0.1;          % Inflation Rate

beta=2;             % Leader Selection Pressure
gamma=2;            % Deletion Selection Pressure
epsilon = 1;        % Relative Weight on each function

mu=0.3;             % Mutation Rate

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

% pop is an array of 200 populations of structure
% with : Position, velocity,cost, best, IsDominated, GridIndex, GirdSubIndex
pop=repmat(empty_particle,nPop,1);

for i=1:nPop %go over all praticles and Initialize
    
    for j=1:nVar
        pop(i).Position(j)=VarMinF(j)+(VarMaxF(j)-VarMinF(j))*rand();%initialize position
    end

    pop(i).Velocity=zeros(VarSize);%set original velocity to 0
    
    pop(i).Cost=CostFunction(pop(i).Position);%calculate the cost at certain position
    
    
    pop(i).CF = fesibJudge(pop(i),VarMinF,VarMaxF,nVar); % decide the personal state 
    % Update Personal Best
    pop(i).Best.Position=pop(i).Position;
    pop(i).Best.Cost=pop(i).Cost;
    pop(i).Best.CF = fesibJudge(pop(i),VarMinF,VarMaxF,nVar); 
    pop(i).Best.PF = pop(i).CF;
end

% Determine Domination
% pick out the ones with smallest cost, only one will be chosen for each time
pop=DetermineDomination(pop);%set pop.IsDominated

rep=pop(~[pop.IsDominated]);%rep = is not dominated

Grid=CreateGrid(rep,nGrid,alpha); % for not dominated, put into rep and create Grid

for i=1:numel(rep)
    rep(i)=FindGridIndex(rep(i),Grid,epsilon);
end


%% MOPSO Main Loop

for it=1:MaxIt % Iterate inside the limitation
    
    for i=1:nPop % go through all the population
        
        leader=SelectLeader(rep,beta); % get leader, return GridIndex of leader
        % get velocity of pop
        
        % w2 = (1-w)/2;
        pop(i).Velocity = w*pop(i).Velocity ...
            +c1*rand(VarSize).*(pop(i).Best.Position-pop(i).Position) ...
            +c2*rand(VarSize).*(leader.Position-pop(i).Position);
        % get new Position
        pop(i).Position = pop(i).Position + pop(i).Velocity;
        %Position to fit boundary

        for j=1:nVar
            VarMin(j) = min(pop(i).Position(j), VarMin(j));
            VarMax(j) = max(pop(i).Position(j), VarMax(j));
        end

        % calculate cost 
        pop(i).Cost = CostFunction(pop(i).Position);
        
        % Evaluate the constraints 
        pop(i).CF = fesibJudge(pop(i),VarMinF,VarMaxF,nVar);

        % Apply Mutation
        % it is iteration times 
        pm=(1-(it-1)/(MaxIt-1))^(1/mu);
        if rand<pm
        % Apply mutation and keep the better one with costs
            %Apply Mutation
            NewSol = pop(i);
            NewSol.Position=Mutate(pop(i).Position,pm,min(VarMin),max(VarMax));
            NewSol.Cost= CostFunction(NewSol.Position);
            NewSol.CF  = fesibJudge(NewSol,VarMinF,VarMaxF,nVar);

            %% Upgrade pop(i) with newSol
            % if cost of NewSol(ution) dominates pop(i) cover pop(i) with newSol
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
    
    % Plot Costs
    figure(1);
    PlotCosts(pop,rep);
    pause(0.3);
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Number of Rep Members = ' num2str(numel(rep))]);
    % Damping Inertia Weight
       w=w*wdamp;
%     if it == 300
%         w = 0.3;
%     end
end
hold on;
optima = FindOptima(rep,beta);
plot(optima.Cost(1,:),optima.Cost(2,:),'bs','MarkerSize',15);
   

%% Resluts

