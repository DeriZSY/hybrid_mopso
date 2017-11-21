function [simifinishcevalue]=simifinishce(n_simifinish,doc_simifinish,vs_simifinish,vw_simifinish,fa_simifinish)
  n=n_simifinish-2;%对变量编码
  doc=(doc_simifinish-3.5)/1.5;%对变量编码
  vs=(vs_simifinish-500)/100;%对变量编码
  vw=(vw_simifinish-40)/10;%对变量编码
  fa=(fa_simifinish-1350)/150;%对变量编码
  simifinishcevalue=0.003363-0.000056*n+0.006826*doc-0.001605*vs+0.001199*vw+0.0032*fa+0.0032*n*doc-0.0005*n*vs+0.000792*n*vw+0.001208*n*fa+0.000322*doc*vs-0.000127*doc*vw-0.00084*doc*fa-0.000449*vs*vw-0.000395*vs*fa-0.000396*vw*fa-0.000111*n*n-0.001333*doc*doc-0.000718*vs*vs-0.00061*vw*vw-0.001271*fa*fa;
end