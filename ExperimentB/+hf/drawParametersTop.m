function drawParametersTop(fontColor, screenInfo, trialInfo, sessionInfo, expParameters)
    line1 = sprintf('Exp: %s    Task: %s    Subject: %s    Time elapsed: %s', expParameters.Experiment, expParameters.Task, expParameters.Subject, hf.toc2hm(sessionInfo.startTime));
    DrawFormattedText(screenInfo.windowPointer, line1, 5, 15, fontColor);
end