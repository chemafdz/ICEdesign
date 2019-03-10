%% Motor
% Defines all the properties of the motor.
classdef Motors <handle
    properties
        W_i_u % Trabajo ideal unitario, kJ
        W_i % Trabajo ideal, kJ
        P_i % Vector de presión del ciclo ideal, kPa
        V_i_u % Vector de volumen del ciclo ideal unitario, m^3
        V_i % Vector de volumen del ciclo ideal, m^3
        eta_i % Eficiencia del ciclo ideal
        V_d % Volumen Desplazado, m^3
        D % Diámetro del Cilindro, m
        L % Carrera, m
        rc % relación de compreción
        OF % Relación Oxidante Combustible, cantidad de combustible que contiene 1 kg de mezcla (Giacosa, p.74)
        deltaH % kJ/kg de combustible (Giacosa, p. 74)
        r_l % Definir
        K % Número de cilindros
        D_cc % Distancia máxima cámara de combustión, m
        A % Área del cilindro, m^2
    end
    methods
        % Constructor takes data from motor property file
        function obj = Motors(motor_file) % Motor file is the motor data
            if nargin > 0
                prop = readtable(motor_file,'Format','%s%f');
                prop = table2array(prop(1:end,2));
				obj.D = prop(1);
				obj.L = prop(2);
				obj.rc = prop(3);
				obj.OF = prop(4);
				obj.deltaH = prop(5);
				obj.r_l = prop(6);
				obj.K = prop(7);
				obj.D_cc = prop(8);
				obj.A = obj.D^2*.25*pi;
				obj.V_d = obj.A*obj.L*obj.K;
				% Modelado del ciclo ideal
				[obj.P_i,obj.V_i_u,work_per_mass,obj.eta_i] = ICE_CEA(obj.rc); % kPa, m^3, kJ/kg
                obj.W_i_u = work_per_mass/max(obj.V_i_u); % kJ/kg max(V_i_u) = vol específico de mezcla aire combustible
				obj.V_i = obj.V_i_u * obj.A * obj.L / max(obj.V_i_u);
                obj.W_i = obj.W_i_u * obj.A * obj.L; % kJ
            end
        end
        function [PR,VR,TR,FR,W] = W_prac(obj,N) % Rutina para la obtención del ciclo práctico
            % Ignition timing
            a_0 = 0.3756*N*obj.D_cc/(0.025*N+50)
            % Combustion ending
            a_F = a_0/0.75
            % Inlet timing
            IVO = 10
            IVC = -IVO+65;
            % Exhaust timing
            EVO = 45;
            EVC = -EVO+65
            % Ángulos absolutos
            IVC = 180 - IVC
            EVO = 180 - EVO
            
            % Puntos del Ciclo práctico
            P = obj.P_i; V = obj.V_i;
            V1 = VofT(V,IVC);
            V2 = VofT(V,a_0); % Ignition 
            V3 = min(V);
            P3 = 0.5*max(P);
            V4 = min(V)+(VofT(V,a_F)-min(V))*50; % nera
            P4 = 0.75*max(P);
            V5 = VofT(V,a_F);
            V6 = VofT(V,EVO);
            V7 = max(V);
            V8 = VofT(V,IVC);
            V9 = VofT(V,IVO);
            P9 = min(P) + 0.01*max(P); % + 2 psi
            V10 = min(V);
            P10 = min(P);
            V11 = VofT(V,EVC);
            P11 = min(P) - 0.01*max(P); % - 2 psi
            V12 = max(V);
            P12 = min(P);
            
            T = TofV(V,V); % Crank Angle
            
            PR = []; VR = []; TR = []; FR = [];

            for i = 1:length(V)
                if V(i) <= V1 && V(i) >= V2
                    PR(end+1) = P(i);
                    VR(end+1) = V(i);
                    TR(end+1) = T(i);
                    FR(end+1) = P(i)*obj.A;
                end
                if V(i) <= V2
                    P2 = PR(end);
                    i_P2 = length(PR);
                    VR = [VR,V3,V4]; %#ok<*AGROW>
                    PR = [PR,P3,P4];
                    TR = [TR,TofV(V,V3),360-TofV(V,V4)];
                    FR = [FR,P3*obj.A,P4*obj.A];
                    for j = i:length(V)
                        if V(j) >= V5 && V(j) <= V6
                            PR(end+1) = 0.85*P(j); % Expansión
                            VR(end+1) = V(j);
                            TR(end+1) = 360-T(j);
                            FR(end+1) = 0.85*P(j)*obj.A;
                        end
                        if V(j) >= V6
                            P6 = PR(end);
                            P7 = 0.5*P6; % nera
                            W2 = trapz([VR(i_P2+1:end),V7],[PR(i_P2+1:end),P7]);
                            W1 = trapz([V7,VR(1),VR(1:i_P2+1)],[P7,P(1),PR(1:i_P2+1)]);
                            W_pump = trapz([V10,V11,V12],[P10,P11,P12]) - trapz([V12,V8,V9,V10],[P12,PR(2),P9,P10]);
                            VR = [VR,V7,V8,V9,V10,V11,V12,V1];
                            PR = [PR,P7,PR(2),P9,P10,P11,P12,PR(2)]; % P7 muy ñero
                            TR = [TofV(V,V12),TR,360-TofV(V,V7),360+TofV(V,V8),360+TofV(V,V9)];
                            TR = [TR,720-TofV(V,V10),720-TofV(V,V11),720-TofV(V,V12)];
                            FR = [P12*obj.A,FR,P7*obj.A,PR(2)*obj.A,P9*obj.A];
                            FR = [FR,P10*obj.A,P11*obj.A,P12*obj.A];
                            break;
                        end
                    end
                    break;
                end
            end

            W = W2+W1-W_pump;
            
            FR = FR*100; % [bar-m^2] to kN

            figure(4)
            plot(VR,PR)
            hold
            plot(V,P,'-.')
            hold off
            figure(5)
            plot(TR,FR)
            figure(6)
            polarplot(TR,FR)

        end
    end
end