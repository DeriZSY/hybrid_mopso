function z = Plot(x_cord,cost)
	figure(1),
	plot(x_cord,-cost(1,:),'-rs','MarkerFaceColor','red');
	figure(2),
	plot(x_cord,-cost(2,:),'-bo','MarkerFaceColor','blue');
	figure(3),
	plot(x_cord,-cost(3,:),'-yellow*','MarkerFaceColor','yellow');
	figure(4),
	plot(x_cord,-cost(4,:),'--gs','MarkerFaceColor','green');
	figure(5),
	plot(x_cord,cost(5,:),'--k>','MarkerFaceColor','red');
	figure(6),
	legend('rough','simifin','finish','sparkout','cuttting times');
end
