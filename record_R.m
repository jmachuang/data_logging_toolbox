function R = record_R(device, channel_list)
% record the resistance R (kOhm) from the "device"
%           AMLDT, 05/23/2024, v2, Mac Huang
%
% input:    device              - VISA object of the data logger
%                                 initiated with visadev
%           channel_list        - list of channels, in the format of 
%                                 '101,102' or '101-102' (must be string)
%
% output:   R                   - resistance at all channels (kOhm)
%


% send the inquiry
fprintf(device, ['ROUTe:SCAN (@' channel_list ')']);

% obtain the resistance (in kOhm)
R_string = query(device, 'READ?');
eval(['R = [' R_string ']/1000;']);

end
