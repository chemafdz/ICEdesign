function [result] = PlotAngleAxis(P,V)
    plot(V,P*100)
    Angles = [180 150 130 120 110 100 90 80 70 60 50 30 0];
    n = length(Angles);
    V_1 = linspace(max(V),min(V),n);
    Vmid = V_1(ceil(n/2));
    V_1 = Vmid + cos(Angles.*pi/180).*(Vmid-min(V));
    xticks(V_1)
    xticklabels(Angles)
end