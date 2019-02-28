% Punto 8 - Calcular el balance térmico del motor basándose en los 
% rendimientos estimados y calcular el consumo de aire, consumo de 
% combustible y potencia específica
function [m_dot_a,S_W_dot_R] = Punto8(W_dot_I,m_dot_f,OF,eta_c,eta_d,eta_mec,eta_v,eta_e)
    W_dot_R = W_dot_I*eta_c*eta_d*eta_mec*eta_v*eta_e;
    m_dot_a = OF*m_dot_f;
    S_W_dot_R = W_dot_R/(m_dot_f*9.81);
end