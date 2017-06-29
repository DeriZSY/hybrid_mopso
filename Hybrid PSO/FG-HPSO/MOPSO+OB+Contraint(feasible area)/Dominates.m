function b=Dominates(x,y)
% if x dominates y, return true
   b = false;
   costXDominates=all(x.Cost<=y.Cost) && any(x.Cost<y.Cost);
   xF = x.CF;
   yF = y.CF;
   if yF
     	if xF &&  costXDominates
     		b = true;
        end
   else
     	if xF 
     		b = true;
     	else
     		if costXDominates
     			b = true;
            end
        end
   end