function p = initRelayBoard(port)
% INITRELAYBOARD Initializes relay board
%Opens the serial port to control the silverbox.
% 
% USE:
% 	p = initRelayboard(port)
%
% ARGS:
% 	port: A string, usually 'COM4', with the port to open.
% VALS:
% 	p: The port, to be used with the silverbox function.
%
% See also SILVERBOX
    IOPort('CloseAll')
    try
        p = IOPort('OpenSerialPort',port); %initialize object for serial port COM4);\
    catch
        p = [];
    end
