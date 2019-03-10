function [F_g,F_a,F_r,F_N,F_b,F_t,M,theta] = Forces(N, L, R, F_g, theta)
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
    subplot(1,2,1)
    plot(theta,F_g)
    hold
    plot(theta,F_a)
    plot(theta,F_r)
    plot(theta,F_N)
    plot(theta,F_b)
    plot(theta,F_t)
    legend('F_g','F_a','F_r','F_N','F_b','F_t')
    lgd = legend;
    lgd.Title.String = 'Fuerzas (N)';
    lgd.NumColumns = 2;
    subplot(1,2,2)
    plot(theta,M)
    legend('Momento Motor (N-m)')
end