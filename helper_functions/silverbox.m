function silverbox(port, type)
% SILVERBOX Activate relay board
% Used to control events inside the operant chamber
%
% USE:
% 	silverbox(port, type)
%
% ARGS:
%	port: double. Pointer to the open serial port. Usually obtained with initRelayBoard.
%	type: string. Either 'feeder', 'light-on', or 'light-off'. The desired event.
%
% VALS:
%	none
%
% See also: INITRELAYBOARD

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
