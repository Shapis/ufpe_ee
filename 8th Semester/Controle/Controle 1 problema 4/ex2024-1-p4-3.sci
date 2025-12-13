
P=struct('x2',0,'x1',0,'x0',0,'a2',0,'a1',0,'a0',0,...
         'y2',0,'y1',0,'y0',0,'b2',0,'b1',0,'b0',0,...
         'ymax',1000,'ymin',-1000)
A=struct('x2',0,'x1',0,'x0',0,'a2',0,'a1',2,'a0',2,...
         'y2',0,'y1',0,'y0',0,'b2',0,'b1',-19,'b0',21,...
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

P.a2=2; P.a1=4; P.a0=2;
P.b2=39921; P.b1=-79998; P.b0=40081;
A.a2=0; A.a1=2; A.a0=2;
A.b2=0; A.b1=-19; A.b0=21;
A.ymax=2;
A.ymin=0;

a=0
N=3000
y=zeros(1,N)
t=zeros(1,N)
dt=0.01
y0=0
Kp=1
Ki=0*dt
Kd=0/dt
m=0
SP=1
e1=0
e2=0
e0=0
IAE=0
for i=1:N
    t(i)=dt*i
    e2=e1
    e1=e0
    e0=SP-y0
    m=m+Kp*(e0-e1)+Ki*e0+Kd*(e0-2*e1+e2)
    [a,A]=processo(A,m)
    [y0,P]=processo(P,a)
    y(i)=y0
    IAE=IAE+abs(e0)
end

printf("IAE=%d", IAE)
plot(t,y,"*r-")
