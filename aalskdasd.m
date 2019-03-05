plot(VP(1,:),VP(2,:))
ax1 = gca
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
'XAxisLocation','top',...
'YAxisLocation','right',...
'Color','none');
line(180-T,P_i,'Parent',ax2,'Color','k')

load PV
VP = [V_i;P_i];
Vmid = 0.5*(max(V_i)+min(V_i));
T = 180-acos((V_i - Vmid)./(Vmid-min(V_i)))*180/pi;
plot(T,P_i)
