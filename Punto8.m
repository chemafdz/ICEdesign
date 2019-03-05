% Punto 8 - Calcular el balance térmico del motor basándose en los 
% rendimientos estimados y calcular el consumo de aire, consumo de 
% combustible y potencia específica
function [W_dot_R,m_dot_f,m_dot_a,S_W_dot_R] = Punto8(W_dot_i,U_s_F,OF,eta_e,eta_i)
    W_dot_R = W_dot_i*eta_e;
    m_dot_f = (W_dot_i/eta_i)/U_s_F;
    m_dot_a = OF*m_dot_f;
    S_W_dot_R = W_dot_R/(m_dot_f*9.81);
end