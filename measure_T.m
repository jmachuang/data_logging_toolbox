function T = measure_T(N_measurement)
% measure the temperatrue with num_measurement measurements
%           AMLDT, 05/23/2024, v2, Mac Huang
%
% input:    N_measurement     - number of measurements
%
% output:   T                 - temperature
%

% list of channels
channel_list = '101-110';

% see how many measurements are needed
if ~exist('num_measurement','var')
    N_measurement = 1;
end

% open device
device = visadev("USB0::0x2A8D::0x5101::MY58036907::0::INSTR");

% allocate r
R = zeros(10,1);

% do measurements
for k = 1:N_measurement
    R_now = record_R(device, channel_list);
    R = R + R_now';
    disp([num2str(k) ' out of ' num2str(N_measurement) ...
                                        ' measurements are done.'])
end

% delete the object
clear device;

% compute resistance and temperatrue
R = R/N_measurement;
T = R2T(R);

end


