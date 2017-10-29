function [sparkoutrvalue]=sparkoutr(n_sparkout,vs_sparkout,vw_sparkout,fa_sparkout)
n=n_sparkout-2;
vs=(vs_sparkout-500)/100;
vw=(vw_sparkout-40)/10;
fa=(fa_sparkout-1350)/150;
sparkoutrvalue=0.09037-0.0037*n-0.08267*vs+0.04569*vw+0.06359*fa-0.0375*n*vs+0.01936*n*vw+0.02783*n*fa-0.00942*vs*vw-0.01536*vs*fa+0.00083*vw*fa-0.0007*n*n-0.05881*vs*vs-0.03909*vw*vw-0.04393*fa*fa;
end