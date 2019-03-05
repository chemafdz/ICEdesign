function [PR,VR] = IndicatedCycle(P,V,a_0, a_F, IVO, IVC, EVO, EVC)

    % �ngulos absolutos
    IVC = 180 - IVC;
    EVO = 180 - EVO;

    % Puntos del Ciclo pr�ctico
    V1 = VofT(V,IVC);
    V2 = VofT(V,a_0); % Ignition 
    V3 = min(V);
    P3 = 0.5*max(P);
    V4 = (min(V)+VofT(V,a_F))*.5;
    P4 = 0.75*max(P);
    V5 = VofT(V,a_F);
    V6 = VofT(V,EVO);
    V7 = max(V);
    V8 = VofT(V,IVC);
    V9 = VofT(V,IVO);
    P9 = min(P) + 0.01*max(P); % + 2 psi
    V10 = min(V);
    P10 = min(P);
    V11 = VofT(V,EVC);
    P11 = min(P) - 0.01*max(P); % - 2 psi
    V12 = max(V);
    P12 = min(P);
    
    VR(1) = V1;
    PR(1) = min(P);
    
    for i = 1:length(V)
        if V(i) <= V1 && V(i) >= V2
            PR(end+1) = P(i);
            VR(end+1) = V(i);
        end
        if V(i) <= V2
            W1 = trapz([VR V3],[PR P3])
            VR = [VR,V3,V4];
            PR = [PR,P3,P4];
            for j = i:length(V)
                if V(j) >= V5 && V(j) <= V6
                    PR(end+1) = 0.8*P(j); % Expansi�n
                    VR(end+1) = V(j);
                end
                if V(j) >= V6
                    VR = [VR,V7,V8,V9,V10,V11,V12,V1];
                    PR = [PR,0.5*P(j-1),PR(2),P9,P10,P11,P12,PR(2)]; % P7 muy �ero
                    break;
                end
            end
            break;
        end
    end
    
    figure(1)
    plot(VR,PR)
    hold
    plot(V,P,'-.')
    
end