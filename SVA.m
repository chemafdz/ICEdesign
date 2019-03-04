function [result] = SVA (N, L, R, theta)
    
    w = N*0.10472;
    thetar = theta*pi()/180;
    S = R*cos(thetar)+(L^2-R^2*(sin(thetar))^2)^0.5;
    V = w*(-R*sin(thetar)-R^2*sin(thetar)*cos(thetar)/(L^2-R^2*(sin(thetar))^2)^0.5);
    A = w^2*(-R*cos(thetar)-R^2*((cos(thetar))^2-(sin(thetar))^2)/(L^2-R^2*(sin(thetar))^2)^0.5-R^4*(sin(thetar))^2*(cos(thetar))^2/((L^2-R^2*(sin(thetar))^2)^0.5)^3);
    
    [result] = [S, V, A];
end