function [result] = VofT(V,T) % Volume Vector, Theta (degrees)
    Vmid = 0.5*(max(V)+min(V));
    result =  Vmid - cos(T*pi/180).*(Vmid-min(V));
end