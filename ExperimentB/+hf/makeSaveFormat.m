function format = makeSaveFormat(data, requestedVars, separator, varargin)
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