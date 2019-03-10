function [F_g,F_a,F_r,F_N,F_b,F_t,theta] = Forces(N, L, R, F_g, theta)
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
    S = L+R - R.*cos(thetar)-(L.^2-R.^2.*(sin(thetar)).^2).^0.5;
    V = w.*(R.*sin(thetar)+R.^2.*sin(thetar).*cos(thetar)./(L.^2-R.^2.*(sin(thetar)).^2).^0.5);
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
    F_t = F_b .* sin(phi+theta);
    figure(12)
    plot(theta,F_g*0.224809)
    hold
    plot(theta,F_a*0.224809)
    plot(theta,F_r*0.224809)
    plot(theta,F_N*0.224809)
    plot(theta,F_b*0.224809)
    plot(theta,F_t*0.224809)
    legend('F_g','F_a','F_r','F_N','F_b','F_t')
    lgd = legend;
    lgd.Title.String = 'Fuerzas (lb)';
    lgd.NumColumns = 2;
end