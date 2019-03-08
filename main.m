%% C�digo para la clase de dise�o de elementos de motor alternativo. 
% Por: Jos� Mar�a Fern�ndez Rodr�guez &
%      Sebasti�n L�pez S�nchez
%
% El siguiente c�digo realizan los c�culos punto por punto
% en el orden determinado por la r�brica del profesor
% H�ctor D�az Garc�a, todos los puntos se mencionan,
% y se desarrolla el c�digo en los que es pertinente.
%
%% Punto 1:
%
% Establecer los principales par�metros de dise�o que intervienen
% en la selecci�n de un motor, compar�ndolo con dise�os similares.
%   a. Determinar la potencia requerida con base en los
%      requerimientos de un veh�culo.
%   b. Principales requerimientos.
%   c. Principales caracter�sticas
% 
% Los par�metros obtenidos del punto 1 son:

% Otto 4 tiempos
% Disposici�n de cilindros lineal
% W_dot = 96000; % Potencia en Watts; 129 HP 
% V_d = 2.42216e-3; % Volumen Desplazado m^3; 148 in^3
% D = 8.5319e-2; % Di�metro del Cilindro m;
% L = 8.2779e-2; % Carrera m;
% rc = 9.9; % relaci�n de compreci�n
% OF = 1/16.2; % Relaci�n Oxidante Combustible, cantidad de combustible que contiene 1 kg de mezcla (Giacosa, p.74)
% U_s_F = 46024000; % Joules/kg de combustible (Giacosa, p. 74)
% r_l = 1; % Definir! Relaci�n r/l
% K = 4; % N�mero de cilindros
% D_cil_max = D;

motor = Motors('motor1');
N = 5366.67; % rpm

% Conversiones 
bar2psi = 14.5038;
m2in = 39.3701;

%% Punto 2
%
% Hoja de datos t�cnicos del motor

%% Punto 3
%
% Despiece t�cnico del motor

%% Punto 4 
%
% Obtener el ciclo ideal para un motor te�rico que maneja
% una unidad de masa de aire combustible, calcular adem�s
% el rendimiento termodin�mico ideal y la presi�n media
% ideal.

% Ciclo ideal para una unidad de masa de aire combustible:

motor.W_i_u
% Presi�n de admisi�n de 1 bar a 300 kelvin

% Presi�n media ideal:

PMEI_bar = motor.PME(motor.W_i_u); % bar
PMEI_psi = bar2psi*PMEI_bar; % psi

%% Punto 5
%
% Calcular y dibujar el (sic) ciclo te�rico del ciclo, 
% considerando 10 puntos intermedios entre los puntos
% (sic) 1-2, 3-4, y 4-4' del diagrama PV

P_i_psi = motor.P_i * bar2psi; % psi
V_i_in = motor.V_i * m2in^3; %in

figure(2)
plot(V_i_in,P_i_psi);

%% Punto6 

PMEI = PMEI_bar * 100000; % Pascals
W_dot_i = PMEI * motor.V_d * (N/2); % Watts

%% Punto 7
%
% Calcular o estimar los rendimientos de combusti�n, de
% diagrama, mec�nico, volum�trico, y rendimiento.

% De acuerdo con lo visto en clase, las estimaciones son:

eta_c = .5*(.88+.96);
eta_d = 0.8;
eta_m = 0.85;
eta_v = .93;
eta_e = eta_c*eta_d*eta_m*eta_v; % Rendimiento total

%% Punto 8
% 
% Calcular el balance t�rmico del motor bas�ndose en los
% rendimientos estimados y calcular el consumo de aire,
% consumo de combustible, y potencia espec�fica.

W_dot_R = W_dot_i*eta_e;
m_dot_f = (W_dot_i/motor.eta_i)/motor.deltaH;
m_dot_a = motor.OF*m_dot_f;
S_W_dot_R = W_dot_R/(m_dot_f*9.81);

% ! Flujos m�sicos mal

%% Punto 9

% Dimensionar el motor, seleccionando la relaci�n l/d, r/l 
% de acuerdo a motores similares en potencia, r.p.m,
% disposici�n de cilindros, etc.


% calcular tambi�n cilindradas u y t

%% Punto 10

% Sobre el ciclo obtenido en el punto 4, trazar la escala de
% volumen en in del motor real dimensionado en el punto 
% (sic) 8 y la relaci�n r/l seleccionada.

% Hecho en el punto 5

%% Punto 11

% Obtener el ciclo pr�ctico

[P_prac,V_prac,W_prac] = motor.W_prac(N);

%% Punto 12

% Determinar el �rea del ciclo pr�ctico obtenido en el punto
% 11. Calcular la potencia indicada a la que corresponde y
% verificar contra la calculada en el punto 8. Verficar
% la potencia total o al freno seg�n sea el caso, usando el
% rendimiento mec�nico estimado en el punto 7

% contra P1 potencia diagrama

% W_dot_prac = W_prac * N/2; % ! 
% e_prac_R = (W_dot_prac - W_dot_R)/W_dot_prac; % !
% W_prac_R = W_prac * eta_m; % !

%% Punto 13

% El motor no tiene sobrealmientaci�n

%% Punto 14

% Determinar el encendido del motor y hacer el an�lisis de
% cargas impuestas al cigue�al y equilibrado del mismo.

%% Punto 15

% Obtener el diagrama desarrollado de fuerza de gases, de
% inercia alternativa, de fuerza neta, de fuerza lateral,
% de fuerza a lo largo de la biela, de fuerza rotativa,
% y la curva del par motor.

% ! Chema

%% Punto 16

% De la curva del par motor obtener el par medio indicado,
% y la potencia indicada, y comprobarla con la potencia
% indicada.

% !