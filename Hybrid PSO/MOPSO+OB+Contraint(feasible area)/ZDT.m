function z =Fitness(x)
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
	z = [y,f2];
end 