global VarMinF;
global VarMaxF;
global VarMin;
global VarMax;
global nVar;
global it;

nVar=19;             % Number of Decision Variables


VarSize=[1 nVar];   % Size of Decision Variables Matrix

% Boundaries of feasible areas, static
VarMinF=[1 1 1 1 2 2 2  400 400 400 400 30 30 30 30 1200 1200 1200 1200];          % Lower Bound of Feasible Area
VarMaxF=[3 3 3 3 5 5 5  600 600 600 600 50 50 50 50 1500 1500 1500 1500];          % Upper Bound of Feasible Area

% Position(n1 n2 n3 n4 , doc1 doc2 doc3 
%     vs1 vs2 vs3 vs4 , vw1 vw2 vw3 vw4 
% fa1 fa2 fa3 fa4 )

% Boundaries of Variables (Used to create grid, self adaptive) 
VarMin= VarMinF; % Lower Bound of Variables 
VarMax= VarMaxF; % Upper Bound of Variables

it = 1;


% Cost Function
CostFunction=@(x) Fitness(x);      
% f1 roughce,      f2 roughr
% f3 simifinishce, f4 simifinishr
% f5 finishce,     f6 finishr
% f7 sparkoutce,   f8 sparkoutr

%% MOPSO Parameters
% global values
global cSum1;
global cSum2;
global cEq1;
global cEq2;

MaxIt=150;           % Maximum Number of Iterations

PopNum=150;            % Population Size

nRep=100;             % Repository Size

w1=0.9;              % Initial Inertia Weight
w2=0.4;              % Final Inertia Weight
c1i = 2.5;           % Initial Personal Learning Coefficient   
c1f = 0.5;           % Final Personal Learning Coefficient 
c2i = 0.5;           % Initial Global Learning Coefficient 
c2f = 2.5;           % Final Global Learning Coefficient 




nGrid=5;            % Number of Grids per Dimension


alpha=0.1;          % Inflation Rate
beta=2;             % Leader Selection Pressure
gamma=2;            % Deletion Selection Pressure


mu1 = 0;             % Mutation Rate
mu2 = 0;


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
pop = repmat(empty_particle,PopNum,1);
popNew = repmat(empty_particle,PopNum,1);
%% Initialize Particles 
flag = 0;
for itInit = 1:80000
    i = 1;
    fprintf('Initializing NUMBER : %d\n',itInit)
    while(i < 100)
        %Initialize Position
        for j = 1 : nVar
            pop(i).Position(j)=randi([VarMinF(j) VarMaxF(j)],1,1);
        end%end position Init
       %Initialize Feasibility 
        pop(i).CF = fesibJudge(pop(i)); 
        i = i+1;
    end%end while
    if flag == 0
    popNew = pop([pop.CF]>0);
    flag = flag+1;
    else
    popNew = [popNew;pop([pop.CF]>0)];
    end% end if 
    nPop = numel(popNew);
    if nPop > PopNum
        break;
    end
end% end for 



pop = popNew;
nPop = numel(popNew);
i = 1;
for i = 1: nPop
    pop(i).Velocity=zeros(VarSize);
    %Evaluate Cost
    x = pop(i).Position;
    pop(i).Cost=CostFunction(x); 
    
    %Initialize Feasibility 
    pop(i).CF = fesibJudge(pop(i)); 
    % Update Personal Best
    pop(i).Best.Position=pop(i).Position;
    pop(i).Best.Cost=pop(i).Cost;
    pop(i).Best.CF = fesibJudge(pop(i)); 
    pop(i).Best.PF = pop(i).CF;
end
%% Determine Domination and update the repository

pop=DetermineDomination(pop);% set pop.IsDominated

rep=pop(~[pop.IsDominated]); % rep=is not dominated


Grid=CreateGrid(rep,nGrid,alpha); % Initialize Grid

% Find Grid Index for non-domniated solutions
% meanCost = mean([rep.Cost],2); % find mean cost of each function 
for i=1:numel(rep)
    rep(i)=FindGridIndex(rep(i),Grid,rep);
end



%% MOPSO Main Loop

for it=1:MaxIt % Iterate inside the limitation
     % Get Inertia Weigth
      
     w = (w1 - w2) * ( (MaxIt - it) / MaxIt ) +w2;
     % Get Learning Coefficients
     c1 = (c1f - c1i) * (it / MaxIt) + c1i;
     c2 = (c2f - c2i) * (it / MaxIt) + c2i;


    for i=1:nPop
        fprintf('Total It %d START **********************\n',it);
        fprintf('Iteration Number %d START **********************\n',it);
        fprintf('PARTICLE  NUMBER %d START **********************\n',i);
        leader=SelectLeader(rep,beta); % Set leader for the group

        % Get Velocity
        pop(i).Velocity = w*pop(i).Velocity ...
            +c1*rand(VarSize).*(pop(i).Best.Position-pop(i).Position) ...
            +c2*rand(VarSize).*(leader.Position-pop(i).Position);
        
        % Get new Position
        pop(i).Position = nearestInt(pop(i).Position + pop(i).Velocity);
        
        % Evaluate Cost
        pop(i).Cost = CostFunction(pop(i).Position);
        
        % Evaluate Feasiblity
        pop(i).CF = fesibJudge(pop(i));

        % Get Mutation Rate
        % pm=(1-(it-1)/(MaxIt-1))^(1/mu); 
        mu = (mu1 - mu2) * ( (MaxIt - it) / MaxIt ) +mu2;
        if rand  <  mu
            % Apply Mutation    
            NewSol = pop(i);
            NewSol.Position= Mutate(pop(i).Position,mu,VarMinF,VarMaxF);
            NewSol.Cost= CostFunction(NewSol.Position);
            NewSol.CF  = fesibJudge(NewSol);

            %% Update pop(i) with newSol
            if (~Dominates(pop(i),NewSol))
                pop(i).Position=NewSol.Position;
                pop(i).Cost=NewSol.Cost;
                pop(i).CF= fesibJudge(pop(i));

            % else, nothing will be done
            elseif Dominates(pop(i),NewSol)
                % Do Nothing
            % if cost of pop(i) and newSol does not dominate each other & rand<0.5, cover pop(i) with new Sol        
            else
                if rand < 0.5
                    pop(i).Position=NewSol.Position;
                    pop(i).Cost=NewSol.Cost;
                    pop(i).CF= fesibJudge(pop(i));
                end
            end
        end%end mutate if
        
        % Upgrade pbest with pop(i)
        if Dominates(pop(i),pop(i).Best)
            pop(i).Best.Position=pop(i).Position;
            pop(i).Best.Cost=pop(i).Cost;
            pop(i).PF = pop(i).CF;

        elseif Dominates(pop(i).Best,pop(i))
            %doNothing
            
        else
            if rand<0.5
                pop(i).Best.Position=pop(i).Position;
                pop(i).Best.Cost=pop(i).Cost;
            end%if
        end
        


    % Add new Non-Dominated Particle to REPOSITORY (a new leader)
    pop = DetermineDomination(pop);
    rep=[rep 
        pop(~[pop.IsDominated])]; 
    
    % Determine Domination of New Resository Members
    rep=DetermineDomination(rep);
    
    % Keep Only the Non-Dminated Memebr in the Repository
    rep=rep(~[rep.IsDominated]);
    
    % Update Variable Boundary
    for idx = 1: numel(rep)
            for j=1:nVar
                VarMin(j) = min(rep(idx).Position(j), VarMin(j));
                VarMax(j) = max(rep(idx).Position(j), VarMax(j));
            end
    end
      

    % Update Grid for repository
    Grid=CreateGrid(rep,nGrid,alpha);

    % Update Grid Index for repository
    % meanCost = mean([rep.Cost],2); % find mean cost of each function 
    for i=1:numel(rep)
    rep(i)=FindGridIndex(rep(i),Grid,rep);
    end
    
    % Check if Repository is Full
    if numel(rep)>nRep
        % if full, delete extra members
        % uses same way of select leader, assign greater probability to those with greater fitness 
        Extra=numel(rep)-nRep;
        for e=1:Extra
            rep=DeleteOneRepMemebr(rep,gamma);
        end
        
    end%if
 
end% end for all particles
	
	meanCost = -mean([rep.Cost],2); 
	meanCost(5) = -meanCost(5);
	%Find Optima Solution
	optimaTemp=tempOpt(rep,meanCost);
	CostRep(:,it) = [optimaTemp.Cost];
    
    cost = CostRep;
    % figure(1),PlotCosts(pop,rep,optimaTemp),pause(0.1);
    

end% end for max iteration

% % Find optima solution
x_cord = 1:MaxIt;
Plot(x_cord,cost),pause(0.1);
% get absolute mean value of each function 
meanCost = -mean([rep.Cost],2); 
meanCost(5) = -meanCost(5);
%Find Optima Solution
optima(itt) =tempOpt(rep,meanCost);

