function saveData(fname, requestedVars, format, data)
    f = fopen(['./data/' fname], 'a');
    for e = 1:length(requestedVars)
        try
            fprintf(f, format{e}, data.(requestedVars{e}));
        catch
            errordlg('Something went wrong when saving data. Field not found', 'Error!');
        end
    end
    fclose(f);
    
end