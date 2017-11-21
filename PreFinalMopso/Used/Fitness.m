function Cost = Fitness(x)
	% Fitness Function
	n = zeros(1,4);
	doc_ = zeros(1,4);
	vs = zeros(1,4);
	vw = zeros(1,4);
	fa = zeros(1,4);
    doc_(1)=x(5);
    doc_(2)=x(6);
    doc_(3)=x(7);
	for i = 1:4
		n(i)=x(i);
		vs(i) = x(i+7);
		vw(i) = x(i+11);
		fa(i) = x(i+15);
	end	
  
  f1 = -max1(doc_(1),fa(1));
  f2 = -max2(doc_(2),fa(2));
  f3 = -max3(doc_(3),fa(3));
  f4 = -max4(fa(4));
  f5 = min1(n(1),n(2),n(3),n(4));

	Cost = [f1; f2; f3; f4; f5];
end

  function f1 = max1(doc_rough, fa_rough)
    f1 = doc_rough * fa_rough;
  end

  function f2 = max2(doc_simifinish, fa_simifinish)
    f2 = doc_simifinish * fa_simifinish;
  end

  function f3 = max3(doc_finish,fa_finish)
    f3 = doc_finish * fa_finish;
  end

  function f4 = max4(fa_sparkout)
    f4 = fa_sparkout;
  end

  function f5 = min1(n_rough,n_simifinish,n_finish,n_sparkout)
    f5 = n_rough + n_simifinish + n_finish + n_sparkout;
  end


