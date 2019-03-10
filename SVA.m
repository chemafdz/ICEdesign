function [S,V,A] = SVA(N, L, R, theta)
    w = N*0.10472;
    thetar = theta.*pi()./180;
    S = L+R - R.*cos(thetar)-(L.^2-R.^2.*(sin(thetar)).^2).^0.5;
    V = w.*(R.*sin(thetar)+R.^2.*sin(thetar).*cos(thetar)./(L.^2-R.^2.*(sin(thetar)).^2).^0.5);
    A = w.^2.*(R.*cos(thetar)+R.^2.*((cos(thetar)).^2-(sin(thetar)).^2)./(L.^2-R.^2.*(sin(thetar)).^2).^0.5+R.^4.*(sin(thetar)).^2.*(cos(thetar)).^2./((L.^2-R.^2.*(sin(thetar)).^2).^0.5).^3);
    figure(11)
    subplot(2,3,4)
    plot(theta,S)
    subplot(2,3,5)
    plot(theta,V)
    subplot(2,3,6)
    plot(theta,A)
    subplot(2,3,1:3)
    plot(theta,S*100)
    hold
    plot(theta,V)
    plot(theta,A/10^3)
end