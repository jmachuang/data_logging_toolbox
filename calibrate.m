function data = calibrate(Temp, N_measurement, delay, data_prev, save_path)
% calibrate thermistors with num_measurement measurements
%           AMLDT, 05/23/2024, v2, Mac Huang
%
% input:    Temp                - current temperature
%           N_measurement       - number of measurements
%           delay               - delay between each measurement
%           data_prev           - data saved previously
%
% output:   data                - measured data with each column containing
%                                 the resistance and temperature
%

% list of channels
channel_list = '101-110';

% open device
device = visadev("USB0::0x2A8D::0x5101::MY58036907::0::INSTR");

% allocate data
data = zeros(11,1); data(11) = Temp; R = zeros(10,1);
% data(11) is temperature, data(1:8) are C1-C8,
% data(9) is Top, data(10) is bottom

% measure
for k = 1:N_measurement
    R_now = record_R(device, channel_list);
    R = R+R_now';
    disp([num2str(k) ' out of ' num2str(N_measurement) ...
                                              ' measurements are done.'])
    pause(delay);
end

% delete the object
clear device;

% save all the resistance
R = R/N_measurement;
data(1:10) = R;

% check whether previous data exists
if exist('data_prev','var')
    data = [data_prev, data];
end

% check whether to save data in text file
if exist('data_prev','var')
    mkdir(save_path);
    filename = [save_path, 'save_', num2str(Temp) '.txt'];
    fileID = fopen(filename,'w');
    fprintf(fileID,'%.4f ',R');
    fprintf(fileID,'\n');
    fclose(fileID);
end

% save data
save('calibration_data.mat', 'data');
end


