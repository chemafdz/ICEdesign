function [Fg,T] = Forces(P,V,A)
           
    Vmid = 0.5*(max(V)+min(V));
    T = acos((V - Vmid)/(min(V)-Vmid))*180/pi;
    Fg = P.*A;
    
    FT = trasnpose([Fg;T]);
    FT_mod = [];
            
    BDC = 0; % bottom dead center counter
    for i = 1:length(T(2,:))
        if T(i) == 180 || T(i) == 0; BDC = BDC+1; end
        T(i) = T(i) + (BDC)*180;
    end
    
    
    
    plot(T,Fg);

end