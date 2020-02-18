IOPort('CloseAll')

p = IOPort('OpenSerialPort', '/dev/cu.usbserial', 'DTR=1 RTS=1');

global gmpigeonPort;
gmpigeonPort=p;

%[nwritten, when, errmsg, prewritetime, postwritetime, lastchecktime] = IOPort('Write', p, uint8(1));
