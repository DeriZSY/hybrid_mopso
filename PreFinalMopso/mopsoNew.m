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
% Position(
%     n1 n2 n3 n4
%     doc1 doc2 doc3
%     vs1 vs2 vs3 vs4
%     vw1 vw2 vw3 vw4
%     fa1 fa2 fa3 fa4 )

% Boundaries of Variables
VarMin= VarMinF;
VarMax= VarMaxF;

% Cost Function
CostFunction=@(x) Fitness(x);

%% MOPSO Parameters
% global values
global cSum1;
global cSum2;
global cEq1;
global cEq2;

MaxIt=80;           % Maximum Number of Iterations
PopNum=20;            % Population Size
nRep=80;             % Repository Size

w1  = 0.9;              % Initial Inertia Weight
w2  = 0.4;              % Final Inertia Weight
c1i = 2.5;           % Initial Personal Learning Coefficient
c1f = 0.5;           % Final Personal Learning Coefficient
c2i = 0.5;           % Initial Global Learning Coefficient
c2f = 2.5;           % Final Global Learning Coefficient

nGrid = 5;            % Number of Grids per Dimension

alpha = 0.1;          % Inflation Rate
beta  = 2;             % Leader Selection Pressure
gamma = 2;            % Deletion Selection Pressure

mu1 = 0.9;             % Starting Mutation Rate
mu2 = 0.2;             % Ending Mutation Rate

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
it = 1;
% flag = 0;
% for itInit = 1:80000
%     i = 1;
%     fprintf('Initializing NUMBER : %d\n',itInit)
%     while(i < 100)
%         %Initialize Position
%         for j = 1 : nVar
%             pop(i).Position(j)=randi([VarMinF(j) VarMaxF(j)],1,1);
%         end%end position Init

%        %Initialize Feasibility
%         pop(i).CF = fesibJudge(pop(i));
%         i = i+1;
%     end%end while

%     if flag == 0
%         popNew = pop([pop.CF]>0);
%         flag = flag+1;
%     else
%         popNew = [popNew;pop([pop.CF]>0)];
%     end% end if
%         nPop = numel(popNew);

%     if nPop > PopNum
%         break;
%     end% end if
% end% end for



% pop = popNew;
% nPop = numel(popNew);

% i = 1;
% for i = 1: nPop
%     pop(i).Velocity=zeros(VarSize);
%     %Evaluate Cost
%     x = pop(i).Position;
%     pop(i).Cost=CostFunction(x);

%     %Initialize Feasibility
%     pop(i).CF = fesibJudge(pop(i));
%     % Update Personal Best
%     pop(i).Best.Position=pop(i).Position;
%     pop(i).Best.Cost=pop(i).Cost;
%     pop(i).Best.CF = fesibJudge(pop(i));
%     pop(i).Best.PF = pop(i).CF;
% end
%% Determine Domination and update the repository
load pop;
pop = pop(1:100);
nPop = numel(pop);

pop = DetermineDomination(pop);% set pop.IsDominated

rep = pop(~[pop.IsDominated]); % rep=is not dominated


Grid = CreateGrid(rep,nGrid,alpha); % Initialize Grid


% Find Grid Index for non-domniated solutions
for i=1:numel(rep)
    rep(i)=FindGridIndex(rep(i),Grid,rep);
end

fprintf('END1\n');


%% MOPSO Main Loop

for it = 1 : MaxIt
    % Get Inertia Weigth
    w = (w1 - w2) * ( (MaxIt - it) / MaxIt ) +w2;

    % Get Learning Coefficients
    c1 = (c1f - c1i) * (it / MaxIt) + c1i;
    c2 = (c2f - c2i) * (it / MaxIt) + c2i;


    for i=1:nPop

        fprintf('T %d   P %d    \n',it,i);

        % Select a leader
        leader = SelectLeader(rep,beta);

        % Update Velocity
        pop(i).Velocity = w*pop(i).Velocity ...
            +c1*rand(VarSize).*(pop(i).Best.Position-pop(i).Position) ...
            +c2*rand(VarSize).*(leader.Position-pop(i).Position);

        % Update new Position
        pop(i).Position = nearestInt(pop(i).Position + pop(i).Velocity);

        % Evaluate Cost
        pop(i).Cost = CostFunction(pop(i).Position);

        % Evaluate Feasiblity
        pop(i).CF = fesibJudge(pop(i));


        %% Mutation
        % Get Mutation Rate
        mu = (mu1 - mu2) * ( (MaxIt - it) / MaxIt ) +mu2;
        if rand  <  mu
            % Apply Mutation
            NewSol = pop(i);
            NewSol.Position = Mutate(pop(i).Position,mu);
            NewSol.Cost     = CostFunction(NewSol.Position);
            NewSol.CF       = fesibJudge(NewSol);

            %% Update pop(i) with newSol
            if (~Dominates(pop(i),NewSol))
                pop(i).Position=NewSol.Position;
                pop(i).Cost=NewSol.Cost;
                pop(i).CF= fesibJudge(pop(i));

            % else, nothing will be done
            elseif Dominates(pop(i),NewSol)
                % Do Nothing
            else
                if rand < 0.5
                    pop(i).Position=NewSol.Position;
                    pop(i).Cost=NewSol.Cost;
                    pop(i).CF= fesibJudge(pop(i));
                end
            end% end update

        end% end mutate if


        %% Updaee pbest with pop(i)
        if Dominates(pop(i),pop(i).Best)
            pop(i).Best.Position = pop(i).Position;
            pop(i).Best.Cost     = pop(i).Cost;
            pop(i).PF            = pop(i).CF;

        elseif Dominates(pop(i).Best,pop(i))
            % Do Nothing

        else
            if rand<0.5
                pop(i).Best.Position = pop(i).Position;
                pop(i).Best.Cost     = pop(i).Cost;
            end%if
        end



    %% Update Repository
    pop = DetermineDomination(pop);
    rep = [rep
           pop(~[pop.IsDominated])];
    rep = DetermineDomination(rep);
    rep=rep(~[rep.IsDominated]);

    % Update Variable Boundary
    % for idx = 1: numel(rep)
    %         for j=1:nVar
    %             VarMin(j) = min(rep(idx).Position(j), VarMin(j));
    %             VarMax(j) = max(rep(idx).Position(j), VarMax(j));
    %         end
    % end

    % Update Gird and GridIndex
    Grid = CreateGrid(rep,nGrid,alpha);
    for i=1:numel(rep)
        rep(i)=FindGridIndex(rep(i),Grid,rep);
    end

    % Delete extra particles in the repository
    if numel(rep)>nRep
        Extra=numel(rep)-nRep;
        for e=1:Extra
            rep=DeleteOneRepMemebr(rep,gamma);
        end

    end% end if

end% end for all particles

  %% Find Current Optima
	meanCost = -mean([rep.Cost],2);
	meanCost(5) = -meanCost(5);

	optimaTemp=tempOpt(rep,meanCost);
	CostRep(:,it) = [optimaTemp.Cost];
  cost = CostRep;

  % figure(1),PlotCosts(pop,rep,optimaTemp),pause(0.1);


end% end for max iteration

% % Find optima solution in the rep
  x_cord = 1:MaxIt;
  Plot(x_cord,cost),pause(0.1);

  meanCost = -mean([rep.Cost],2);
  meanCost(5) = -meanCost(5);
  optima(itt) =tempOpt(rep,meanCost);
