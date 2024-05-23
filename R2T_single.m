function T = R2T_single(R, k)
% turn resistance to temperature with Steinhart-Hart polynomial, 
%                                        for the k-th thermistor
%           AMLDT, 05/23/2024, v1, Mac Huang
%
% input:     R  - resistance in kOhm
%            k  - thermistor index
%
% output:    T  - temperature in centigrade
%

load thermistor_parameters
T = 1./polyval(pp(k, :), log(R*1000)) - 273.15;
end