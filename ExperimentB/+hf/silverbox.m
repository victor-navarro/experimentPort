function silverbox(port, type)
%controls the silverbox
%port is the port, as initialized with IOPort (psychtoolbox) or other method
%type is the specific case
switch(type)
    case 'feeder'
                IOPort('Write', port, uint8(254));
                IOPort('Write', port, uint8(3));
                WaitSecs(.25);
                IOPort('Write', port, uint8(254));
                IOPort('Write', port, uint8(2));
    case 'light-on'
                IOPort('Write', port, uint8(254));
                IOPort('Write', port, uint8(1));
    case 'light-off'
                IOPort('Write', port, uint8(254));
                IOPort('Write', port, uint8(0)); 
end

%Both on
%254 
%6
%3

