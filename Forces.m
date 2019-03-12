function [F_g,F_a,F_r,F_N,F_b,F_t,M,theta] = Forces(N, L, R, F_g, theta)
    % Conversiones 
    bar2psi = 14.5038;
    m2in = 39.3701;
    Pa2psi = 0.000145038;
    kW2HP = 1.34102;
    kN2lb = 224.809;
    % Angular velocity
    w = N*0.10472;
    % Gas Force Fit
    F_g = fit(transpose(theta),transpose(F_g*1000),'smoothingspline');
    % Crank Angle
    theta = 0:.001:720;
    thetar = theta.*pi()./180;
    % Rod Angle
    phi = asin((R/L)*sin(thetar));
    % Piston kinematics
    A = w.^2.*(R.*cos(thetar)+R.^2.*((cos(thetar)).^2-(sin(thetar)).^2)./(L.^2-R.^2.*(sin(thetar)).^2).^0.5+R.^4.*(sin(thetar)).^2.*(cos(thetar)).^2./((L.^2-R.^2.*(sin(thetar)).^2).^0.5).^3);
    % Gas force vector
    F_g = transpose(F_g(theta));
    % Inertia force, mass = 0.402 kg
    F_a = -A.*0.402;
    % Resultant force
    F_r = F_g+F_a;
    % Lateral force
    F_N = F_r .* tan(phi);
    % Rod force
    F_b = F_r ./ cos(phi);
    % Tangent force
    F_t = F_b .* sin(phi+thetar);
    % Engine torque
    M = - F_r * R .* ( sin(thetar) + 0.5*(R/L)*sin(2*thetar) );
    figure(12)
    subplot(2,2,[1 3])
    plot(theta,F_g*kN2lb/10^6)
    hold
    plot(theta,F_a*kN2lb/10^6)
    plot(theta,F_r*kN2lb/10^6)
    plot(theta,F_N*kN2lb/10^6)
    plot(theta,F_b*kN2lb/10^6)
    plot(theta,F_t*kN2lb/10^6)
    legend('F_g','F_a','F_r','F_N','F_b','F_t')
    ylabel('Fuerza [klb]')
    xlabel('Desplazamiento [°]')
    title('Fuerzas del Motor')
    grid on
    lgd = legend;
    lgd.Title.String = 'Fuerzas (lb)';
    lgd.NumColumns = 2;
    subplot(2,2,4)
    plot(theta,M*kN2lb/10^3*m2in/12)
    title('Momento Motor')
    ylabel('Momento [lb-ft]')
    xlabel('Desplazamiento [°]')
    figure(12)
    subplot(2,2,2)
    polarplot(thetar,F_g*kN2lb/10^6)
    hold
    polarplot(thetar,F_a*kN2lb/10^6)
    polarplot(thetar,F_r*kN2lb/10^6)
    polarplot(thetar,F_N*kN2lb/10^6)
    polarplot(thetar,F_b*kN2lb/10^6)
    polarplot(thetar,F_t*kN2lb/10^6)
    legend('F_g','F_a','F_r','F_N','F_b','F_t')
    title('Polar de Fuerzas del Motor [klb]')
end