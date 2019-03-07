function [P,V,Wnet,eta] = ICE_CEA (r_c)
    %State 1
    P_a = 1;
    T_a = 300;
    State_1 = TP_CEA(P_a, T_a);
    
    U_1 = State_1(4);
    S_1 = State_1(5);
    V_1 = State_1(3);
    P(1) = P_a;
    V(1) = V_1;
    T(1) = T_a;
    S(1) = S_1;
    
    %State 2
    V_2 = V_1/r_c;
    S_2 = S_1;
    list = linspace(V_1,V_2,50);
    i = 1;
    while i < length(list)
        i = i+1;
        
        State_2 = SV_CEA(S_2, list(i));
        
        P_2 = State_2(2);
        T_2 = State_2(1);
        U_2 = State_2(4);
        V(i) = list(i);
        P(i) = P_2;
        T(i) = T_2;
        S(i) = S_2;
        
    end
    
    U_form = Uform_CEA (P_a, V_2, U_2);
    
    %State 3
    V_3 = V_2;
    U_3 = U_form;
    
    State_3 = UV_CEA(U_3, V_3);
    
    P_3 = State_3(2);
    T_3 = State_3(1);
    S_3 = State_3(5);
    
    list = linspace(S_2,S_3,50);
    i = 1;
    while i < length(list)
        i = i+1;
        
        State_3 = SV_CEA(list(i), V_3);
        
        V(i+49) = State_3(3);
        P(i+49) = State_3(2);
        T(i+49) = State_3(1);
        S(i+49) = list(i);
        
    end
    
    %State 4
    V_4 = V_1;
    S_4 = S_3;
    list = linspace(V_3,V_4,50);
    i = 1;
    while i < length(list)
        i = i+1;
        
        State_4 = SV_CEA(S_4, list(i));
        
        P_4 = State_4(2);
        T_4 = State_4(1);
        U_4 = State_4(4);
        V(i+98) = list(i);
        P(i+98) = P_4;
        T(i+98) = T_4;
        S(i+98) = S_4;
        
    end
    
    %State 1
    list = linspace(S_4,S_1,50);
    i = 1;
    while i < length(list)
        i = i+1;
        
        State_3 = SV_CEA(list(i), V_1);
        
        V(i+147) = State_3(3);
        P(i+147) = State_3(2);
        T(i+147) = State_3(1);
        S(i+147) = list(i);
        
    end
    
    %State ex
    S_ex = S_4;
    
    State_ex = SP_CEA(S_4, P_a);
    
    T_ex = State_ex(1);
    U_ex = State_ex(4);
    V_ex = State_ex(3);
    
    W12 = U_2-U_1;
    W34 = U_3-U_4;
    Wnet = W34-W12;
    
    W = [W12, W34, Wnet];
    eta = W(3)/(U_3-U_1);
    figure
    subplot(1,2,1);
    plot(V,P)
    subplot(1,2,2);
    plot(S,T)
    [result] = {'State', 'T (K)', 'P (bar)', 'V (m^3/kg)', 'u (kJ/kg)', 's (kJ/kg/K)'; 1, T_a, P_a, V_1, U_1, S_1; 2, T_2, P_2, V_2, U_2, S_2; 3, T_3, P_3, V_3, U_3, S_3; 4, T_4, P_4, V_4, U_4, S_4; 'EX', T_ex, P_a, V_ex, U_ex, S_ex};
end