function [sparkoutcevalue]=sparkoutce(n_sparkout,vs_sparkout,vw_sparkout,fa_sparkout)
  n=n_sparkout-2;
  vs=(vs_sparkout-500)/100;
  vw=(vw_sparkout-40)/10;
  fa=(fa_sparkout-1350)/150;
  sparkoutcevalue=0.002481-0.000556*n+0.002389*vs+0.001667*vw+0.004889*fa+0.000917*n*vs+0.000556*n*vw+0.001772*n*fa-0.0005*vs*vw-0.000167*vs*fa+0.000194*vw*fa-0.000111*n*n-0.001278*vs*vs-0.000444*vw*vw-0.003667*fa*fa;
end