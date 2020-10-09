function string = toc2hm(ticPointer)
% TOC2HM Get formatted string from tic pointer
%
% USE:
% 	string = toc2hm(ticPointer)
%
% ARGS:
%	ticPointer: a tic pointer obtained with the tic() function.
%	
% VALS:
%	string: a formatted string in the HH:MM format.
%
% See also: TIC, TOC

    theTime = toc(ticPointer);
    string = sprintf('%d:%d', floor(theTime/(60*60)), floor(rem(theTime,(60*60))/60));