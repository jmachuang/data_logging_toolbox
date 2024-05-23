function T = R2T(R)
% turn resistance to temperature with Steinhart-Hart polynomial
%           AMLDT, 05/23/2024, v1, Mac Huang
%
% input:     R  - resistance in kOhm
%            k  - thermistor index
%
% output:    T  - temperature in centigrade
%

load thermistor_parameters
N_thermistor = size(pp,1); 

T = 0*R; 
for k = 1:N_thermistor
    T(k) = 1./polyval(pp(k, :), log(R(k, :)*1000)) - 273.15;
end

end