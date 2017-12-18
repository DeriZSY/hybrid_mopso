function value = Fitness(x,varMin,varMax)
	value1 = SPR(x);
	nVar = numel(x);
	G = 0;
	for i = 1:nVar
  		G = G + sqrt((x(i) - max (varMin(i), x(i) ) )^2 +(x(i) - min(x(i) ,  varMax(i)))^2);
	end

	f1 = value1(1) + G;
	f2 = value1(2) + G;
	value = [f1
	         f2];
	         
end
	
	%%%%% BfK Function %%%%%
	function value = BfK(X)
		x = X(1);
		y = X(2);
		f1 = 4*x^2 + 4*y^2;
		f2 = (x-5)^2 + (y-5)^2;
		value = [f1
		     f2];
	end


	%%%%%% ZDT 1 %%%%%%%%%%
	function value = ZDT1(x)	
		n=numel(x);

	    f1=x(1);
	    
	    g=1+9/(n-1)*sum(x(2:end));
	    
	    h=1-sqrt(f1/g);
	    
	    f2=g*h;
	    value = [f1
		     f2];
	end

    %%%%%%% ZDT 2 %%%%%%%%%%%%%
	function value = ZDT2(x)
	     n=numel(x);

	    f1=x(1);
	    
	    g=1+9/(n-1)*sum(x(2:end));
	    
	    h=1-(f1/g)^2;
	    
	    f2=g*h;
	    value = [f1
		     f2];
	end 

    %%%%%%%% ZDT 3 %%%%%%%%%%%
	function value = ZDT3(x)
	    n=numel(x);

	    f1=x(1);
	    
	    g=1+9/(n-1)*sum(x(2:end));
	    
	    h=1-sqrt(f1/g) -f1/g *sin(10*pi*f1);
	    
	    f2=g*h;
	    value = [f1
		     f2];
	end
    
    %%%%%%%%%%%%%% ZDT 4 %%%%%%%%%%%%%%%%%%%%%
	function value = ZDT4(x)
	    n=numel(x);

	    f1=x(1);
	    for i = 1:n
	    	k(i) = x(i)^2 - 10 * cos(4*pi*x(i));
	   	end
	    
	    g=1+10*(n-1)*sum(k(2:end));
	    
	    h=1-sqrt(f1/g);
	    
	    f2=g*h;
	    value = [f1
		     f2];
	end



    %%%%%%%%%%%%% Single Path Rolling %%%%%%%%%%%%%%%%%%%%%%%%%%%
    function value = SPR(x)
	    docu = x(1) ;
		vs     = x(2) ;
		fa     = x(3) ;	
		y =7.2323+0.0429*(vs-19)/5 ...
		  +4.3068*(docu-0.003)/0.002 ...
		  +0.3855*(fa-740)/260 ...
		  -0.146*((vs-19)/5)*((docu-0.003)/0.002) ...
		  -0.1765*((vs-19)/5)*((fa-740)/260) ...
		  +0.1453*((docu-0.003)/0.002)*((fa-740)/260) ...
		  +3.3457*((docu-0.003)/0.002)*((docu-0.003)/0.002) ...
		  -0.0217*((fa-740)/260)*((fa-740)/260);

		f2 = -docu * fa;

		f1 = y ;
		value = [f1
		     f2];
	end



