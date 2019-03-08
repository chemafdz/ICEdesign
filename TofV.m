function [result] = TofV(V,V_i)
    % Crank Angle
    Vmid = 0.5*(max(V)+min(V));
    result = acos((V_i - Vmid)/(-min(V)+Vmid))*180/pi;
end