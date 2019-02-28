% Punto 6 - Verificar la potencia del ciclo termodinámico ideal.
function [W_dot] = Punto6(W,Vmax,Vmin,N,d,l,K)
    PMEI = W/(Vmax-Vmin);
    W_dot = PMEI * l * .25*pi*d^2 * (N/2) * K;
end