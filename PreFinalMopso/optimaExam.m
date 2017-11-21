% Run MOPSO
clear;
clc;

global cSum1;
global cSum2;
global cEq1; 
global cEq2;

cSum1 = 0.048;
cSum2 = 0.46;
cEq1  = 0.025;
cEq2  = 0.3;

% itTimes = 10;
% for itt = 1:itTimes
% 	mopsoTest;
% 	clc;
% end
itt = 1;
mopsoTest;
% itt = 2;
% mopsoTest2;
% itt = 3;
% mopsoTest3;
% for i = 1 : itTimes
% 	fprintf('********************************');
% % 	pos = optima(i).Position;
% 	cos = abs(optima(i).Cost);
% 
% % 	for j = 1:19
% % 	    	fprintf('%d \n',pos(j));
% % 	end
% 	    
% 	for k = 1: 5
% 	    	fprintf('%d \n',cos(i));
% 	end
% end


