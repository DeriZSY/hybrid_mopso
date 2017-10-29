function fesiableState=fesibJudge(particle,VarMinF,VarMaxF,nVar)
  % judge if the position is in feasible area 
  global cSum1;
  global cSum2;
  global cEq1;
  global cEq2;
  global VarMinF;
  global VarMaxF;
  global VarMin;
  global VarMax;
  global nVar;
  global it;
  % particle = pop(1);
  fesiableState= true;
      for i = 1:nVar
        if particle.Position(i) < VarMinF(i) || particle.Position(i) > VarMaxF(i)
          fesiableState = false;
          end
      end
    x = [particle.Position];
    n = zeros(1,4);
    doc_ = zeros(1,3);
    vs = zeros(1,4);
    vw = zeros(1,4);
    fa = zeros(1,4);
    doc_(1)=x(5);
    doc_(2)=x(6);
    doc_(3)=x(7);
    for j = 1:4
      n(j)=x(j);
      vs(j) = x(j+7);
      vw(j) = x(j+11);
      fa(j) = x(j+15);
    end

      % rough
    f1 = roughce(n(1),doc_(1),vs(1),vw(1),fa(1));
    f2 = roughr(n(1),doc_(1),vs(1),vw(1),fa(1));

    % simifinish
    f3 = simifinishce(n(2),doc_(2),vs(2),vw(2),fa(2));
    f4 = simifinishr(n(2),doc_(2),vs(2),vw(2),fa(2));

    % finish
    f5 = finishce(n(3),doc_(3),vs(3),vw(3),fa(3));
    f6 = finishr(n(3),doc_(3),vs(3),vw(3),fa(3));

    % sparkout
    f7 = sparkoutce(n(4),vs(4),vw(4),fa(4));
    f8 = sparkoutr(n(4),vs(4),vw(4),fa(4));
    
      
    sum1 = f1 + f3 + f5 + f7 + cSum1 - cEq1; 
    sum2 = f2 + f4 + f6 + f8 + cSum2 - cEq2;
    particle.sum1 = sum1;
    particle.sum2 = sum2;

  
    fesiable2 = false;   
    fesiable2 = (sum1 > -0.005)&&(sum2 > -0.05)&&(sum1 < 0)&&(sum2 < 0);
   fesiable3 = false;
    if (doc_(1)>=doc_(2))&(doc_(2)>=doc_(3))
      fesiable3 = true;
    end%end if
fesiable4=false;
if(fa(1)>fa(2) & fa(2) >fa(3) & fa(3)>fa(4))
    fesiable4=true;
end
    % fesiable2 = true;
    fesiableState = fesiableState && fesiable2 & fesiable3&fesiable4;
    % fesiableState = fesiable1;    
end%end


  function [finishcevalue]=finishce(n_finish,doc_finish,vs_finish,vw_finish,fa_finish)
  n=n_finish-2;%对变量编�?  
  doc=(doc_finish-3.5)/1.5;%对变量编�?  
  vs=(vs_finish-500)/100;%对变量编�?  
  vw=(vw_finish-40)/10;%对变量编�?  
  fa=(fa_finish-1350)/150;%对变量编�?  
  finishcevalue=0.003363-0.000056*n+0.006826*doc-0.001605*vs+0.001199*vw+0.0032*fa+0.0032*n*doc-0.0005*n*vs+0.000792*n*vw+0.001208*n*fa+0.000322*doc*vs-0.000127*doc*vw-0.00084*doc*fa-0.000449*vs*vw-0.000395*vs*fa-0.000396*vw*fa-0.000111*n*n-0.001333*doc*doc-0.000718*vs*vs-0.00061*vw*vw-0.001271*fa*fa;
end

function [finishrvalue]=finishr(n_finish,doc_finish,vs_finish,vw_finish,fa_finish)
  n=n_finish-2;%对变量编�?  
  doc=(doc_finish-3.5)/1.5;%对变量编�?  
  vs=(vs_finish-500)/100;%对变量编�?  
  vw=(vw_finish-40)/10;%对变量编�?  
  fa=(fa_finish-1350)/150;%对变量编�?  
  finishrvalue=0.0301-0.0004*n+0.1011*doc-0.0598*vs+0.0261*vw+0.0388*fa+0.0512*n*doc-0.0264*n*vs+0.016*n*vw+0.0181*n*fa-0.0069*doc*vs+0.0011*doc*vw+0.0026*doc*fa+0.009*vs*vw-0.0045*vs*fa-0.0172*vw*fa+0.0013*n*n+0.0196*doc*doc-0.0123*vs*vs-0.0159*vw*vw-0.0298*fa*fa;
end

function [roughcevalue]=roughce(n_rough,doc_rough,vs_rough,vw_rough,fa_rough)
  n=n_rough-2;%对变量编�?  
  doc=(doc_rough-3.5)/1.5;%对变量编�?  
  vs=(vs_rough-500)/100;%对变量编�?  
  vw=(vw_rough-40)/10;%对变量编�?  
  fa=(fa_rough-1350)/150;%对变量编�? 
  roughcevalue=0.003363-0.000056*n+0.006826*doc-0.001605*vs+0.001199*vw+0.0032*fa+0.0032*n*doc-0.0005*n*vs+0.000792*n*vw+0.001208*n*fa+0.000322*doc*vs-0.000127*doc*vw-0.00084*doc*fa-0.000449*vs*vw-0.000395*vs*fa-0.000396*vw*fa-0.000111*n*n-0.001333*doc*doc-0.000718*vs*vs-0.00061*vw*vw-0.001271*fa*fa;
end

function [roughrvalue]=roughr(n_rough,doc_rough,vs_rough,vw_rough,fa_rough)
  n=n_rough-2;%对变量编�?  
  doc=(doc_rough-3.5)/1.5;%对变量编�?  
  vs=(vs_rough-500)/100;%对变量编�?  
  vw=(vw_rough-40)/10;%对变量编�?  
  fa=(fa_rough-1350)/150;%对变量编�?  
  roughrvalue=0.0301-0.0004*n+0.1011*doc-0.0598*vs+0.0261*vw+0.0388*fa+0.0512*n*doc-0.0264*n*vs+0.016*n*vw+0.0181*n*fa-0.0069*doc*vs+0.0011*doc*vw+0.0026*doc*fa+0.009*vs*vw-0.0045*vs*fa-0.0172*vw*fa+0.0013*n*n+0.0196*doc*doc-0.0123*vs*vs-0.0159*vw*vw-0.0298*fa*fa;
end

function [simifinishcevalue]=simifinishce(n_simifinish,doc_simifinish,vs_simifinish,vw_simifinish,fa_simifinish)
  n=n_simifinish-2;%对变量编�?  
  doc=(doc_simifinish-3.5)/1.5;%对变量编�?  
  vs=(vs_simifinish-500)/100;%对变量编�?  
  vw=(vw_simifinish-40)/10;%对变量编�?  
  fa=(fa_simifinish-1350)/150;%对变量编�?  
  simifinishcevalue=0.003363-0.000056*n+0.006826*doc-0.001605*vs+0.001199*vw+0.0032*fa+0.0032*n*doc-0.0005*n*vs+0.000792*n*vw+0.001208*n*fa+0.000322*doc*vs-0.000127*doc*vw-0.00084*doc*fa-0.000449*vs*vw-0.000395*vs*fa-0.000396*vw*fa-0.000111*n*n-0.001333*doc*doc-0.000718*vs*vs-0.00061*vw*vw-0.001271*fa*fa;
end

function [simifinishrvalue]=simifinishr(n_simifinish,doc_simifinish,vs_simifinish,vw_simifinish,fa_simifinish)
  n=n_simifinish-2;%对变量编�?  
  doc=(doc_simifinish-3.5)/1.5;%对变量编�?  
  vs=(vs_simifinish-500)/100;%对变量编�?  
  vw=(vw_simifinish-40)/10;%对变量编�?  
  fa=(fa_simifinish-1350)/150;%对变量编�?  
  simifinishrvalue=0.0301-0.0004*n+0.1011*doc-0.0598*vs+0.0261*vw+0.0388*fa+0.0512*n*doc-0.0264*n*vs+0.016*n*vw+0.0181*n*fa-0.0069*doc*vs+0.0011*doc*vw+0.0026*doc*fa+0.009*vs*vw-0.0045*vs*fa-0.0172*vw*fa+0.0013*n*n+0.0196*doc*doc-0.0123*vs*vs-0.0159*vw*vw-0.0298*fa*fa;
end

function [sparkoutcevalue]=sparkoutce(n_sparkout,vs_sparkout,vw_sparkout,fa_sparkout)
  n=n_sparkout-2;
  vs=(vs_sparkout-500)/100;
  vw=(vw_sparkout-40)/10;
  fa=(fa_sparkout-1350)/150;
  sparkoutcevalue=0.002481-0.000556*n+0.002389*vs+0.001667*vw+0.004889*fa+0.000917*n*vs+0.000556*n*vw+0.001772*n*fa-0.0005*vs*vw-0.000167*vs*fa+0.000194*vw*fa-0.000111*n*n-0.001278*vs*vs-0.000444*vw*vw-0.003667*fa*fa;
end

function [sparkoutrvalue]=sparkoutr(n_sparkout,vs_sparkout,vw_sparkout,fa_sparkout)
n=n_sparkout-2;
vs=(vs_sparkout-500)/100;
vw=(vw_sparkout-40)/10;
fa=(fa_sparkout-1350)/150;
sparkoutrvalue=0.09037-0.0037*n-0.08267*vs+0.04569*vw+0.06359*fa-0.0375*n*vs+0.01936*n*vw+0.02783*n*fa-0.00942*vs*vw-0.01536*vs*fa+0.00083*vw*fa-0.0007*n*n-0.05881*vs*vs-0.03909*vw*vw-0.04393*fa*fa;
end