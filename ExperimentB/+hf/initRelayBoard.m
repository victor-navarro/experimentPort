%opens the serial port to control the silverbox
%port: Usually 'COM4', the port to open
%p: the port, to be used with the silverbox function
function p = initRelayBoard(port)
    IOPort('CloseAll')
    try
        p = IOPort('OpenSerialPort',port); %initialize object for serial port COM4);\
    catch
        p = [];
    end
