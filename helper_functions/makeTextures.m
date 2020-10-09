function [texturePointers, texturesKey] = makeTextures(sinfo)
% MAKETEXTURES Make image textures for Psychtoolbox
%
% USE: [texturePointers, texturesKey] = makeTextures(sinfo)
%
% ARGS:
% 	sinfo: a struct containing screen information (obtained from initScreen).
%
% VALS:
%	texturePointers: a vector containing pointers to the textures.
%	texturesKey: a cell containing the names of the images used to create textures.
% 
% See also INITSCREEN

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