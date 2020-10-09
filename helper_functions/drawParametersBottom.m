function drawParametersBottom(fontColor, screenInfo, trialInfo, sessionInfo, expParameters)
% DRAWPARAMETERSBOTTOM Draws parameters at the bottom of the screen
%
% USE:
% drawParametersBottom(fontColor, screenInfo, trialInfo, sessionInfo, expParameters)
%
% ARGS:
%	fontcolor: Psychtoolbox-friendly color vector
%	screenInfo, trialInfo, sessionInfo, expParameters: structs containing information to be displayed
%
% VALS:
% 	none
%
% See also DRAWPARAMETERSTOP

    bottomY = screenInfo.displayRect(4)-10;
    theTime = toc(sessionInfo.startTime);
    ITIcountdown = ceil(trialInfo.ITI-toc(trialInfo.ITIStart));
    if ITIcountdown < 0; ITIcountdown = 0; end
    line1 = sprintf('Trial: %d/%d    Accuracy: %3.2f    Sample: %s    Correct: %s    ITI: %d (%d-%d)', ...
        sessionInfo.currentTrial, sessionInfo.maxTrials, ...
        mean(sessionInfo.overallAccuracy), ...
        trialInfo.sample, ...
        trialInfo.correct, ...
        ITIcountdown, ...
        min(expParameters.ITI), ...
        max(expParameters.ITI));
    DrawFormattedText(screenInfo.windowPointer, line1, 5, bottomY, fontColor);
end