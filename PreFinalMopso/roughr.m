function [roughrvalue]=roughr(n_rough,doc_rough,vs_rough,vw_rough,fa_rough)
  n=n_rough-2;%对变量编码
  doc=(doc_rough-3.5)/1.5;%对变量编码
  vs=(vs_rough-500)/100;%对变量编码
  vw=(vw_rough-40)/10;%对变量编码
  fa=(fa_rough-1350)/150;%对变量编码
  roughrvalue=0.0301-0.0004*n+0.1011*doc-0.0598*vs+0.0261*vw+0.0388*fa+0.0512*n*doc-0.0264*n*vs+0.016*n*vw+0.0181*n*fa-0.0069*doc*vs+0.0011*doc*vw+0.0026*doc*fa+0.009*vs*vw-0.0045*vs*fa-0.0172*vw*fa+0.0013*n*n+0.0196*doc*doc-0.0123*vs*vs-0.0159*vw*vw-0.0298*fa*fa;
end