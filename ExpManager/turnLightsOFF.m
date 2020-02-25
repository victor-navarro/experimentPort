function turnLightsOFF()
    IOPort('CloseAll')
    port = serialportlist;
    port = port{end};
    try
        port = IOPort('OpenSerialPort',port); %initialize object for serial port COM4);\
    catch
        errordlg('Could not stablish communication with the silverbox', 'Error!');
    end
    IOPort('Write', port, uint8(254));
    IOPort('Write', port, uint8(0));
end