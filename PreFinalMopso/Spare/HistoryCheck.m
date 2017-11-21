function Used = HistoryCheck(particle, hisotryRep)
	itNum = numel(hisotryRep);
	Used = false;
	for it = 1:itNum
		if hisotryRep(it).Position == particle.Position 
			Used = true;
		end
	end
	
