function [texturePointers, texturesKey] = makeTextures(sinfo)
    texturePointers = [];
    texturesKey = cell(0);
    files = dir('./stimuli/');
    for f = 3:length(files)
        iname = files(f).name;
        try
            idata = imread(['./stimuli/' iname]);
            t = Screen('MakeTexture', sinfo.windowPointer, idata);
            texturePointers = [texturePointers, t];
            %make it easy on everybody, so remove the file extension from
            %the key
            texturesKey = [texturesKey, iname(1:max(strfind(iname, '.'))-1)];
        catch
            errordlg(sprintf('Could not make texture of %s. Broken file?', iname));
            return
        end
    end
    
end