function fesiableState=fesibJudge(particle,VarMinF,VarMaxF,nVar)
% judge if it's in position
fesiableState = true;
    for i = 1:nVar
%         disp(particle.Position(i));
%         disp(VarMinF(i));
%         disp( VarMaxF(i));
%         disp(fesiableState);
%         disp('roundStrat');
    	if particle.Position(i) <= VarMinF(i) || particle.Position(i) >= VarMaxF(i)
    		fesiableState = false;
        end
%         disp(fesiableState);
%         disp('roundend ');
    end
end
