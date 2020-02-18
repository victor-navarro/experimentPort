function changecursor(shape)
    
    
    % check input arguments
    
    if nargin~=1 return, end
    
    possibleShape={'dot','arrow'};
    
    theBit=strmatch(shape, possibleShape);
    if ~theBit, return, end
    
    PC=computer;
    if strcmp(PC,'MACI')
        if strcmp(shape,'dot')
            pointcursorIntel('dot');
        else
            pointcursorIntel('arrow');
        end
    elseif strcmp(PC,'MAC')
        if strcmp(shape,'dot')
            pointcursorPPC('dot');
        else
            pointcursorPPC('arrow');
        end
    end
    
        