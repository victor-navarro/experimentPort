function drawParametersTop(fontColor, screenInfo, trialInfo, sessionInfo, expParameters)
% DRAWPARAMETERSTOP Draws parameters at the bottom of the screen
%
% USE:
% drawParametersTop(fontColor, screenInfo, trialInfo, sessionInfo, expParameters)
%
% ARGS:
%	fontcolor: Psychtoolbox-friendly color vector
%	screenInfo, trialInfo, sessionInfo, expParameters: structs containing information to be displayed
%
% VALS:
% 	none
%
% See also DRAWPARAMETERSBOTTOM

    line1 = sprintf('Exp: %s    Task: %s    Subject: %s    Time elapsed: %s', expParameters.Experiment, expParameters.Task, expParameters.Subject, hf.toc2hm(sessionInfo.startTime));
    DrawFormattedText(screenInfo.windowPointer, line1, 5, 15, fontColor);
end