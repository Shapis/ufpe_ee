s = %s;
z = %z;

T = 0.01;

Hs = 2/(0.1*s+1);

Hz = horner(Hs, (2/T)*(z-1)/(z+1));
coefnum = coeff(Hz.num);
coefden = coeff(Hz.den);

A=struct('x2',0,'x1',0,'x0',0,'a2',0,'a1',coefnum(1),'a0',coefnum(2),...
         'y2',0,'y1',0,'y0',0,'b2',0,'b1',coefden(1),'b0',coefden(2),...
         'ymax',2,'ymin',0)

function [y, param]=processo(param,x)
    param.x2=param.x1;
    param.x1=param.x0;
    param.x0=x;
    
    param.y2=param.y1;
    param.y1=param.y0;
    
    
    y=param.a2*param.x2+param.a1*param.x1+param.a0*param.x0;
    y=(1/param.b0)*(y-(param.b2*param.y2+param.b1*param.y1));
    
    //Saturação
    if y>param.ymax then
        y=param.ymax
    elseif y<param.ymin then
        y=param.ymin
    end
    
    param.y0=y;
    
endfunction

N=3000
y=zeros(1,N)
t=zeros(1,N)
y0=0

for i=1:N
    t(i)=dt*i
    [y0,A]=processo(A,1)
    y(i)=y0
end
plot(t,y, "*r-")


