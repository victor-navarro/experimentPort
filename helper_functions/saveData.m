function saveData(fname, requestedVars, format, data)
% SAVEDATA Save data to file
%
% USE:
% 	saveData(fname, requestedVars, format, data)
%
% ARGS:
% 	fname: string denoting the filename to save data to.
%	requestedVars: a cell of strings. Strings denote the columns in data to be saved.
%	format: a string specifying the format for saving. Usually obtained with makeSaveFormat
%
% VALS:
%	none
%
% See also MAKESAVEFORMAT

    f = fopen(['./data/' fname], 'a');
    for e = 1:length(requestedVars)
        try
            fprintf(f, format{e}, data.(requestedVars{e}));
        catch
            errordlg('Something went wrong when saving data. Column not found', 'Error!');
        end
    end
    fclose(f);
    
end