function [result] = RC_angles (N, S)
    
    %Ignition timing
    a_0 = 0.3756*N*S/(0.025*N+50);
    
    %Combustion ending
    a_F = a_0/0.75;
    
    %Inlet timing
    IVO = 10;
    IVC = -IVO+65;
    
    %Exhaust timing
    EVO = 45;
    EVC = -EVO+65;
    
    [result] = [a_0, a_F, IVO, IVC, EVO, EVC];
end