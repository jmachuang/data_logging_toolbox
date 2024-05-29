% collect the thermistor data over a long period of time
%           AMLDT, 05/30/2024, v1, Mac Huang
%

% total time in seconds
T = 12*3600;

% list of channels & number of thermistors
channel_list = '101:110'; N_thermistors = 10;

% open device
device = visadev("USB0::0x2A8D::0x5101::MY58036907::0::INSTR");

% initiate data
data = zeros(11,1);

% initialize counter and timer
k = 1; tt = 0;

% start the timer!
tic

% do measurements
while tt < T
    tt = toc;
    R = record_R(device, channel_list); T = R2T(R);
    data(:, k) = [T; tt];
    
    % display progress once in a while
    if mod(k, 100) == 0
        disp([num2str(tt/T*100, '%.1f') '% done, ' ...
              num2str((T - tt)/60, '%.1f') ' minutes  remaining.'])
    end
    
    % forward the counter
    k = k+1;
end

% delete the object
clear device;

% save everything
save(['data-' date '.mat'], 'data')
