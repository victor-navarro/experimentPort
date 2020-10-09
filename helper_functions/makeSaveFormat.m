function format = makeSaveFormat(data, requestedVars, separator, varargin)
% MAKESAVEFORMAT Identify and make save format for fprintf
% 
% USE:
% format = makeSaveFormat(data, requestedVars, separator)
% format = makeSaveFormat(data, requestedVars, separator, float)
%
% ARGS:
%	data: a MATLAB tables
%	requestedVars: a cell of strings. Each string denotes the columns in data to be saved.
% 	separator: A string denoting the separator (e.g., \t)
%	float: Optional. A string specifying float format with its precision (e.g., %2.4f). Default is %2.3f.
%
% See also: SAVEDATA

    if nargin < 4
        float = '%2.3f';
    else
        float = varargin{1}; %if the user specifies a float precision, use that one.
    end
    typesKey = {'%s', '%d', float};
    format = cell(0);
    for v = 1:length(requestedVars)
        val = data.(requestedVars{v});
        pretype = find([isa(val, 'char'), isa(val, 'double')]);
        if isempty(pretype)
            errordlg('Wrong data type when saving.', 'Error!')
        end
        if pretype == 2
            if round(val) == val
                type = 2;
            else
                type = 3;
            end
        else
            type = 1;
        end
        format = [format, strcat(typesKey{type}, separator)];
    end
    format{end}(end) = 'n'; %newline