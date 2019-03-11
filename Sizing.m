function [Q, q, d, L, r, l] = Sizing(BHP, r_af, R_prime, T_0, n_e, n_v, N, H_c, J, P_0, k, ld) % HP, -, lbft/lbR, °R, -, -, lbft/Btu, lbf/ft2, BTU/lb, rpm, -, -
    Q =(2*BHP*r_af*R_prime*T_0*33000)/(n_e*n_v*N*H_c*J*P_0)*12^3; %Engine displacement
    q = Q/k; %Unitary displacement
    d =(4*Q/(k*ld*pi))^(1/3); %Cilinder bore
    L = ld*d; %Cilinder stroke
    r = L*0.5; %Crank length
    Z = 4; %Value between 3.5-4.5
    l = r*Z; %Connecting rod length
end