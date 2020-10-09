function experimentScript
    %We make extensive use of an all-purpose set of functions
    %They are located in the helper_functions folder.
    
    %Global variables
    global serialPort; %necessary for silverbox, from mpigeon
    global expParameters; %necessary for experiment, from control panel
    global expRunning; %will use to manipulate the control panel
    global message; %will use the message in the control panel
    
    %Check that the silverbox was correctly initialized; otherwise abort it
    if isempty(serialPort)
        errordlg('Failed to stablish communication with the silverbox', 'Error');
        return
    end

    %Open control panel and wait for it to close
    waitfor(controlPanel);
    if isempty(expRunning) || expRunning == 0; return; end %if control panel was quit, expRunning is empty;
        
    
    %Read csv, and make it into the trials
    trialsData = makeTrials(expParameters.Task);
    
    screenInfo = struct();
    screenInfo.debug = 0; %only really useful for one-screen setups
    screenInfo.screenBG = [0, 0, 0, 1]; %screen background
    %initialize screen
    [screenInfo.windowPointer, screenInfo.displayRect] = initScreen(screenInfo);
    
    %make textures from stimuli folder
    [screenInfo.textures, screenInfo.texturesKey] = makeTextures(screenInfo);
    
    %Define some rects
    %Start by defining a display area for stimuli
    sqScreenRect = [128, 0, 896, 768]; 
    %define rect for the sample stimulus
    sampleRect = [.25, .25, .75, .75]; %An image for ants? No, just defined in unit space.
    %Rescale rect in unit space to display area, and save to screenInfo.
    screenInfo.sampleRect = rescaleRect(sampleRect, [0, 0, 1, 1], sqScreenRect);
    %Define option rects
    optRects = {[0, .40, .20, .60]...
                [.80, .40, 1, .60]};
    screenInfo.optRects = cellfun(@(x) rescaleRect(x, [0, 0, 1, 1], sqScreenRect), optRects, 'uniformOutput', false);
    %Define start stimulus rect
    startRect = [.45, .45, .55, .55];
    screenInfo.startRect = rescaleRect(startRect, [0, 0, 1, 1], sqScreenRect);
    
    trialInfo = struct();
    trialInfo.task = expParameters.Task;
    trialInfo.subject = expParameters.Subject;
    
    %Specify what you want to save
    %Make sure you are actually saving these data on the trialInfo struct
    %Make sure the field names in trialInfo are the ones you typed here.
    saveInfo = struct();
    saveInfo.onTrialSave = {'subject', 'task', 'trial', ...
                            'sample', 'loption', 'roption', ...
                            'correct', 'ITI', 'FR', ...
                            'pellets', 'sampleRT', 'choiceRT', ...
                            'accuracy'};
    saveInfo.onPeckSave = {'subject', 'task', 'trial', ...
                            'sample', 'loption', 'roption', ...
                            'correct', 'ITI', 'FR', ...
                            'pellets', 'responseTime', 'responseX', ...
                            'responseY', 'correctionTrials'};
    
    %initialize filenames (three filenames [trialfname, totalfname, peckfname])
    saveInfo = makeFilenames(saveInfo, expParameters);
    sessionInfo.maxTrials = height(trialsData);
    sessionInfo.currentTrial = 1;
    sessionInfo.state = 'INIT_EXP';
    
    %% EXPERIMENTAL LOOP %%
    while expRunning
        GetMouse; %Useless call to avoid white death. (Don't ask how much time it took me to find this).
        if KbCheck
            sessionInfo.state = abortCheck(sessionInfo.state); %Check if we want to abort the session (both ctrl keys)
            showCursorCheck; %Check if we want to show the cursor (spacebar)
        end
        switch(sessionInfo.state)
            case 'INIT_EXP'
                %Initialize all the variables you need before the
                %first screen flip; It doesn't matter what their values are
                sessionInfo.startTime = tic;
                sessionInfo.state = 'INIT_TRIAL';
                sessionInfo.overallAccuracy = [];
                
            case 'INIT_TRIAL'
                cTrial = sessionInfo.currentTrial; %for ease of use
                %when accessing strings, use curly brackets; for doubles,
                %use parentheses
                trialInfo.trial = cTrial;
                trialInfo.sample = trialsData.sample{cTrial};
                trialInfo.loption = trialsData.loption{cTrial};
                trialInfo.roption = trialsData.roption{cTrial};
                trialInfo.correct = trialsData.correct{cTrial};
                trialInfo.ITI = Sample(expParameters.ITI); 
                trialInfo.FR = Sample(expParameters.FR);
                trialInfo.pellets = Sample(expParameters.Pellets);
                trialInfo.timeout = Sample(expParameters.Timeout);
                trialInfo.firstAttempt = 1;
                trialInfo.correctionTrials = 0;
                sessionInfo.state = 'ITI';
                
            
            case 'ITI'
                ShowCursor(1);
                silverbox(serialPort, 'light-on');
                trialInfo.ITIStart = tic;
                sessionInfo.state = 'ITI_CHECK';
                
            case 'ITI_CHECK'
                updateScreen('ITI', screenInfo, trialInfo, sessionInfo, expParameters);
                if toc(trialInfo.ITIStart) >= trialInfo.ITI
                    sessionInfo.state = 'START';
                end
                
            case 'START'
                updateScreen('start', screenInfo, trialInfo, sessionInfo, expParameters);
                sessionInfo.state = 'START_PECKING';
                
            case 'START_PECKING'
                [x, y, buttons] = GetMouse(screenInfo.windowPointer);
                if any(buttons)
                    if IsInRect(x, y, screenInfo.startRect)
                        sessionInfo.state = 'SAMPLE';
                    end
                    while any(buttons); [~, ~, buttons] = GetMouse; end
                end
                
                
            case 'SAMPLE'
                trialInfo.samplePecks = 0;
                updateScreen('sample', screenInfo, trialInfo, sessionInfo, expParameters);
                sessionInfo.state = 'SAMPLE_PECKING';
                sampleStart = tic;
            
            case 'SAMPLE_PECKING'
                [x, y, buttons] = GetMouse(screenInfo.windowPointer);
                if any(buttons)
                    if IsInRect(x, y, screenInfo.sampleRect)
                        trialInfo.responseTime = toc(sampleStart);
                        trialInfo.responseX = x;
                        trialInfo.responseY = y;
                        if ~trialInfo.samplePecks
                            trialInfo.sampleRT = trialInfo.responseTime;
                        end
                        %If this is the first peck, we need a format to save data
                        if ~isfield(saveInfo, 'onPeckSaveFormat')
                            %make format if there is none. Can specify
                            %precision of floats as a fourth argument (e.g.,
                            %"%3.6"; default is %2.3f).
                            saveInfo.onPeckSaveFormat = makeSaveFormat(trialInfo, saveInfo.onPeckSave, '\t', '%2.4\f');
                        end
                        saveData(saveInfo.peckfname, saveInfo.onPeckSave, saveInfo.onPeckSaveFormat, trialInfo);
                        trialInfo.samplePecks = trialInfo.samplePecks+1;
                    end
                    while any(buttons); [~, ~, buttons] = GetMouse; end
                end
                if trialInfo.samplePecks == trialInfo.FR
                    sessionInfo.state = 'CHOICE';
                end
            
            case 'CHOICE'
                updateScreen('choice', screenInfo, trialInfo, sessionInfo, expParameters);
                sessionInfo.state = 'CHOICE_PECKING';
                choiceStart = tic;
            
            case 'CHOICE_PECKING'
                [x, y, buttons] = GetMouse(screenInfo.windowPointer);
                if any(buttons)
                    leftCheck = IsInRect(x, y, screenInfo.optRects{1});
                    rightCheck = IsInRect(x, y, screenInfo.optRects{2});
                    if leftCheck || rightCheck
                        trialInfo.choiceRT = toc(choiceStart);
                        trialInfo.choiceX = x;
                        trialInfo.choiceY = y;
                        if leftCheck, choice = 'L'; else, choice = 'R'; end
                        trialInfo.choice = choice;
                        if trialInfo.choice == trialInfo.correct
                            trialInfo.accuracy = 1;
                            sessionInfo.state = 'FEEDING';
                        else
                            trialInfo.accuracy = 0;
                            sessionInfo.state = 'TIMEOUT';
                            silverbox(serialPort, 'light-off');
                            timeoutStart = tic;
                        end
                    end
                    while any(buttons); [~, ~, buttons] = GetMouse; end
                end

            case 'FEEDING'
                for p = 1:trialInfo.pellets
                    silverbox(serialPort, 'feeder');
                end
                sessionInfo.state = 'END_TRIAL';

            case 'TIMEOUT'
                updateScreen('timeout', screenInfo, trialInfo, sessionInfo, expParameters);
                if toc(timeoutStart) >= trialInfo.timeout
                    sessionInfo.state = 'END_TRIAL';
                end
                
            case 'END_TRIAL'
                %If this is the first trial, we need a format to save data
                if ~isfield(saveInfo, 'onTrialSaveFormat')
                    %make format if there is none. Can specify
                    %precision of floats as a fourth argument (e.g.,
                    %"%3.6".
                    saveInfo.onTrialSaveFormat = makeSaveFormat(trialInfo, saveInfo.onTrialSave, '\t');
                end
                if trialInfo.firstAttempt
                    sessionInfo.overallAccuracy = [sessionInfo.overallAccuracy, trialInfo.accuracy];
                    %save first attempt data
                    saveData(saveInfo.trialfname, saveInfo.onTrialSave, saveInfo.onTrialSaveFormat, trialInfo);
                end
                %save all attempts data
                saveData(saveInfo.totalfname, saveInfo.onTrialSave, saveInfo.onTrialSaveFormat, trialInfo);
                if trialInfo.accuracy
                    sessionInfo.currentTrial = sessionInfo.currentTrial+1;
                    sessionInfo.state = 'INIT_TRIAL';
                    if sessionInfo.currentTrial > sessionInfo.maxTrials
                        updateScreen('ITI', screenInfo, trialInfo, sessionInfo, expParameters);
                        sessionInfo.state = 'EXPERIMENT_END';
                    end
                else
                    trialInfo.firstAttempt = 0;
                    trialInfo.correctionTrials = trialInfo.correctionTrials+1;
                    sessionInfo.state = 'ITI';
                end
            case {'EXPERIMENT_END', 'ABORT'}
                %set email information
                setpref('Internet','SMTP_Server','ns-mx.uiowa.edu');
                setpref('Internet','E_mail','victor-navarro@uiowa.edu');
                recipients = {'victor-navarro@uiowa.edu'};
                subject = sprintf('%s bird: %s %s', expParameters.Experiment, expParameters.Subject, datestr(now, 'mmm-DD'));
                if strcmp(sessionInfo.state, 'EXPERIMENT_END')
                    message = ['Session finished!', 10, sprintf('Session duration: %s', toc2hm(sessionInfo.startTime)), 10, 10];
                    %read data file
                    sessData = readData(strcat('./data/', saveInfo.trialfname), saveInfo.onTrialSave);
                    %use function to aggregate data and get summaries
                    message = [message, getSummary(sessData, 'accuracy', 'sample')];
                else
                    message = sprintf('Session ABORTED (%d/%d)', sessionInfo.currentTrial, sessionInfo.maxTrials);
                end
                %send email
                %sendmail(recipients, subject, message);
                expRunning = 0;
        end
    end
    %% CLEAN UP %%
    Screen('closeall')
    %open control panel with summary
    waitfor(controlPanel);
    %Be nice to the pigeons, keep them with the light on until we close the
    %control panel.
    silverbox(serialPort, 'light-off');
end

function updateScreen(type, screenInfo, trialInfo, sessionInfo, expParameters)
    switch(type)
        case {'ITI', 'timeout'}
            Screen('FillRect', screenInfo.windowPointer, screenInfo.screenBG, screenInfo.displayRect);

        case 'start'
            startPointer = find(ismember(screenInfo.texturesKey, 'start'));
            Screen('DrawTexture', screenInfo.windowPointer, screenInfo.textures(startPointer), [], screenInfo.startRect);

        case 'sample'
            samplePointer = find(ismember(screenInfo.texturesKey, trialInfo.sample));
            Screen('DrawTexture', screenInfo.windowPointer, screenInfo.textures(samplePointer), [], screenInfo.sampleRect);
        
        case 'choice'
            samplePointer = find(ismember(screenInfo.texturesKey, trialInfo.sample));
            loptionPointer = find(ismember(screenInfo.texturesKey, trialInfo.loption));
            roptionPointer = find(ismember(screenInfo.texturesKey, trialInfo.roption));
            Screen('DrawTexture', screenInfo.windowPointer, screenInfo.textures(samplePointer), [], screenInfo.sampleRect);
            Screen('DrawTexture', screenInfo.windowPointer, screenInfo.textures(loptionPointer), [], screenInfo.optRects{1});
            Screen('DrawTexture', screenInfo.windowPointer, screenInfo.textures(roptionPointer), [], screenInfo.optRects{2});
    end

    %These are two functions that will draw additional stuff
    %We rarely modify these, so I will put them as helper functions
    drawParametersTop([1, 1, 1, 1], screenInfo, trialInfo, sessionInfo, expParameters);
    drawParametersBottom([1, 1, 1, 1], screenInfo, trialInfo, sessionInfo, expParameters);
    
    Screen('Flip', screenInfo.windowPointer);
end

