%opens the serial port to control the silverbox
%Usually COM3, but might have to change in other computers
%the returned value is the port, to be used with the blackbox function
IOPort('CloseAll')
p = IOPort('OpenSerialPort','COM3'); %initialize object for serial port COM4);
