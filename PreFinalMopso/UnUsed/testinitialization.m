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

nRep=80;             % Repository Size

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


mu1 = 1;             % Mutation Rate
mu2 = 0.3;


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
poptest = repmat(empty_particle,PopNum,1);
popNewtest = repmat(empty_particle,PopNum,1);
%% Initialize Particles 
flagtest = 0;
for itInit = 1:80000
    i = 1;
    fprintf('Initializing NUMBER : %d\n',itInit)
    while(i < 100)
        %Initialize Position
        for j = 1 : nVar
            poptest(i).Position(j)=randi([VarMinF(j) VarMaxF(j)],1,1);
        end%end position Init
       %Initialize Feasibility 
        poptest(i).CF = fesibJudge(poptest(i)); 
        i = i+1;
    end%end while
    if flagtest == 0
    popNewtest = poptest([poptest.CF]>0);
    flagtest = flagtest+1;
    else
    popNewtest = [popNewtest;poptest([poptest.CF]>0)];
    end% end if 
    nPoptest = numel(popNewtest);
    if nPoptest > PopNum
        break;
    end
end% end for 