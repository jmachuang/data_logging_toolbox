close all
clear all
load calibration_data

poly_order = 4;                      % polynomial order
N_thermistor = size(data,1) - 1;     % last row of data is temperature
T = data(end, :) + 273.15;           % turn temperature into Kelvin
cc = jet(10);                        % generate the color map

R_new = linspace(5, 60, 100)*1000;   % for plotting

% Coefficients for the Steinhart-Hart polynomial
pp = zeros(N_thermistor, poly_order+1);          

% plot and fit
figure
for k = 1:N_thermistor
    % fit the coefficient
    R = data(k, :)*1000;             % resistance in Ohm
    pp(k,:) = polyfit(log(R), 1./T, poly_order);

    % plot the original data and fitted curve
    plot(T, R, 'o', 'Color', cc(k, :))
    hold on

    T_new = 1./polyval(pp(k,:) , log(R_new));
    plot(T_new, R_new, 'Color', cc(k, :) )
end

% label the axis
xlabel('temperature (K)')
ylabel('resistance (\Omega)')

% save everything
save('thermistor_parameters.mat', 'data', 'pp')
