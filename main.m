%% Código para la clase de diseño de elementos de motor alternativo. 
% Por: José María Fernández Rodríguez &
%      Sebastián López Sánchez
%
% El siguiente código realizan los cáculos punto por punto
% en el orden determinado por la rúbrica del profesor
% Héctor Díaz García, todos los puntos se mencionan,
% y se desarrolla el código en los que es pertinente.
%
%% Punto 1:
%
% Establecer los principales parámetros de diseño que intervienen
% en la selección de un motor, comparándolo con diseños similares.
%   a. Determinar la potencia requerida con base en los
%      requerimientos de un vehículo.
%   b. Principales requerimientos.
%   c. Principales características
% 
% Los parámetros obtenidos del punto 1 son:

% Otto 4 tiempos
% Disposición de cilindros lineal
% W_dot = 96000; % Potencia en Watts; 129 HP 
% V_d = 2.42216e-3; % Volumen Desplazado m^3; 148 in^3
% D = 8.5319e-2; % Diámetro del Cilindro m;
% L = 8.2779e-2; % Carrera m;
% rc = 9.9; % relación de compreción
% OF = 1/16.2; % Relación Oxidante Combustible, cantidad de combustible que contiene 1 kg de mezcla (Giacosa, p.74)
% U_s_F = 46024000; % Joules/kg de combustible (Giacosa, p. 74)
% r_l = 1; % Definir! Relación r/l
% K = 4; % Número de cilindros
% D_cil_max = D;

motor = Motors('motor1');
N = 5366.67; % rpm

% Conversiones 
bar2psi = 14.5038;
m2in = 39.3701;
Pa2psi = 0.000145038;
kW2HP = 1.34102;
kN2lb = 224.809;

%% Punto 2
%
% Hoja de datos técnicos del motor

%% Punto 3
%
% Despiece técnico del motor

%% Punto 4 
%
% Obtener el ciclo ideal para un motor teórico que maneja
% una unidad de masa de aire combustible, calcular además
% el rendimiento termodinámico ideal y la presión media
% ideal.

% Ciclo ideal para una unidad de masa de aire combustible:

motor.W_i_u
% Presión de admisión de 1 bar a 300 kelvin

% Presión media ideal:

PMEI = motor.W_i/(max(motor.V_i)-min(motor.V_i)); % kPa
PMEI_psi = 1000*Pa2psi*PMEI; % psi

%% Punto 5
%
% Calcular y dibujar el (sic) ciclo teórico del ciclo, 
% considerando 10 puntos intermedios entre los puntos
% (sic) 1-2, 3-4, y 4-4' del diagrama PV

P_i_psi = motor.P_i * bar2psi; % psi
V_i_in = motor.V_i * m2in^3; %in

figure(2)
plot(V_i_in,P_i_psi);

%% Punto6 

% W_dot_i = PMEI * motor.V_d * (N/120); % kW
W_dot_i = motor.W_i*motor.K*(N/120); % kW
W_dot_i_HP = W_dot_i*kW2HP;

%% Punto 7
%
% Calcular o estimar los rendimientos de combustión, de
% diagrama, mecánico, volumétrico, y rendimiento.

% De acuerdo con lo visto en clase, las estimaciones son:

eta_c = .5*(.88+.96);
eta_d = 0.8;
eta_m = 0.85;
eta_v = .93;
eta_e = eta_c*eta_d*eta_m*eta_v; % Rendimiento total

%% Punto 8
% 
% Calcular el balance térmico del motor basándose en los
% rendimientos estimados y calcular el consumo de aire,
% consumo de combustible, y potencia específica.

W_dot_R = W_dot_i*eta_e;
W_dot_R_HP = W_dot_R*kW2HP;
m_dot_f = (W_dot_i/motor.eta_i)/motor.deltaH;
m_dot_a = m_dot_f/motor.OF;
S_W_dot_R = W_dot_R/(m_dot_f*9.81);

%% Punto 9

% Dimensionar el motor, seleccionando la relación l/d, r/l 
% de acuerdo a motores similares en potencia, r.p.m,
% disposición de cilindros, etc.


% calcular también cilindradas u y t

%% Punto 10

% Sobre el ciclo obtenido en el punto 4, trazar la escala de
% volumen en in del motor real dimensionado en el punto 
% (sic) 8 y la relación r/l seleccionada.

% Hecho en el punto 5

%% Punto 11

% Obtener el ciclo práctico

[P_prac,V_prac,F_g,T_prac,W_prac] = motor.W_prac(N);

% figure(10)
% polarplot(T_prac,Fg*kN2lb)

%% Punto 12

% Determinar el área del ciclo práctico obtenido en el punto
% 11. Calcular la potencia indicada a la que corresponde y
% verificar contra la calculada en el punto 8. Verficar
% la potencia total o al freno según sea el caso, usando el
% rendimiento mecánico estimado en el punto 7

% contra P1 potencia diagrama

W_dot_prac = W_prac*100*motor.K*(N/120); % W_prac [bar-m3]
W_dot_prac_HP = W_dot_prac*kW2HP;
BHP = W_dot_prac_HP*eta_m;
e_prac_R = abs((BHP - W_dot_R_HP)/BHP); 

%% Punto 13

% El motor no tiene sobrealmientación

%% Punto 14

% Determinar el encendido del motor y hacer el análisis de
% cargas impuestas al cigueñal y equilibrado del mismo.

%% Punto 15

% Obtener el diagrama desarrollado de fuerza de gases, de
% inercia alternativa, de fuerza neta, de fuerza lateral,
% de fuerza a lo largo de la biela, de fuerza rotativa,
% y la curva del par motor.

[F_g,F_a,F_r,F_N,F_b,F_t,theta] = Forces(N,motor.L,motor.L/2,F_g,T_prac);


%% Punto 16

% De la curva del par motor obtener el par medio indicado,
% y la potencia indicada, y comprobarla con la potencia
% indicada.

% !