function z = Plot(x_cord,cost)
	figure(1),
	legend('Rough Cut');
	plot(x_cord,-cost(1,:),'-rs','MarkerFaceColor','red');

	figure(2),
	legend('Simifinish Cut');
	plot(x_cord,-cost(2,:),'-bo','MarkerFaceColor','blue');

	figure(3),
	legend('Finish Cut');
	plot(x_cord,-cost(3,:),'-yellow*','MarkerFaceColor','yellow');

	figure(4),
	legend('Sparkout Cut');
	plot(x_cord,-cost(4,:),'--gs','MarkerFaceColor','green');

	figure(5),
	legend('Cutting Times');
	plot(x_cord,cost(5,:),'--k>','MarkerFaceColor','red');

	figure(6),
	legend('Total Sum');
	plot(x_cord,sum([cost]),'--b')
	% legend('rough','simifin','finish','sparkout','cuttting times');
end
