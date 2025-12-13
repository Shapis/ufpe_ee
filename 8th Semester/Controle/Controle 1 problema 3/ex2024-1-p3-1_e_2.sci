chdir("/home/hpsilva/Documents/listas_controle/lista3")
loadXcosLibs(); loadScicos();

importXcosDiagram("ex2024-1-p3-1_e_2.zcos")

typeof(scs_m)

set_point = 4000; // maxima distância é 18463 metros.
dist = 0;
e1=0;
e2=0;
pid=0;
K=0.0001;
kp=1;
ki=7;
kd=1;
cnt=0;
IAE = 0;

ds = zeros(1,89);

if set_point > 18463 then
    set_point = 18463;
end
e0=set_point-dist;

while abs(e0) > 50 //(abs(e0) > 10)
    
    delta_pid = K*(kp*(e0-e1) + ki*e0 + kd*(e0-2*e1+e2));
    pid = pid + delta_pid;
    
    scs_m.props.context(4)="ang=pid";
    scicos_simulate(scs_m);
    plot(xvfyv.values(:,1),xvfyv.values(:,2),'r-');
    dist=xvfyv.values($,1);
    e0 = set_point - dist;
    printf("angulo=%f distancia=%f\n erro=%f \n",pid,dist,e0);
    
    if pid<0.1 then
        pid = 0.1;
    elseif pid > 37 then
        pid = 37;
    end
    
    IAE = IAE + abs(e0);
    
    e2 = e1;
    e1 = e0;
    cnt=cnt+1;
    ds(cnt) = dist
end

printf("IAE=%f, iterações=%f, \nkp=%f,\nki=%f,\nkd=%f",IAE,cnt,kp,ki,kd);
