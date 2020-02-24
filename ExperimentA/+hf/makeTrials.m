function trialData = makeTrials(filename)
    %Makes trialData (a struct). The field names of the struct are determined by the
    %header in the file.
    %Then, it will look for warmuptable and trainingtable to generate the
    %trials.
    %We will not use testtable. It is the experimenter's responsibility to
    %control the contingencies (and the intermixing) of testing trials.
  
    %Read file with the trial information
    try
        tableInfo = readtable(['./tasks/' filename]);
    catch
        errordlg('Cannot read the task file', 'Error!');
        return
    end
    %Get variable names
    varnames = tableInfo.Properties.VariableNames;   
    %Check that no name in the header is makeType
    if any(strcmp('makeType', varnames))
        errordlg('The "makeType" variable name is reserved. Use a different name in your task file, please.');
        return
    end
    %Find and make warmup trials
    wmupI = find(ismember(tableInfo{:, 1},'warmuptable'));
    trainI = find(ismember(tableInfo{:, 1},'trainingtable'));
    if isempty(trainI)
        errordlg('No trainingtable found in your file.', 'Error!');
        return
    end
    wIs = []; %holder to save the indexes of warmup trials
    if ~isempty(wmupI)
        wmupBlocks = tableInfo{wmupI, 2}; %we expect the table size to be in the second column
        if iscell(wmupBlocks)
            wmupBlocks = wmupBlocks{:};
            if ischar(wmupBlocks)
                wmupBlocks = str2double(wmupBlocks);
            end
        end
        %identify the rows that contain warmup information
        wmupIs = wmupI+1:(trainI-1);
        %For readability, use a for loop
        for b = 1:wmupBlocks
            wIs = [wIs, wmupIs(randperm(length(wmupIs)))];
        end
    end
    
    %Find and make training trials
    tIs = [];
    trainBlocks = tableInfo{trainI, 2};
    if iscell(trainBlocks)
        trainBlocks = trainBlocks{:};
        if ischar(trainBlocks)
            trainBlocks = str2double(trainBlocks);
        end
    end
    trainIs = trainI+1:size(tableInfo, 1);
    for b = 1:trainBlocks
        tIs = [tIs, trainIs(randperm(length(trainIs)))];
    end
    
    %create trialData
    trialData = table();
    trialData.makeType = zeros(0); %reserved for this function (Warmup of Training);
    %Pre-populate table with fields contained in the csv file
    for v = 1:length(varnames)
        trialData.(varnames{v}) = zeros(0);
    end
    %Append the trials
    makeType = repmat({'Warmup'}, [length(wIs), 1]);
    trialData = [trialData; [table(makeType), tableInfo(wIs, :)]];
    makeType = repmat({'Training'}, [length(tIs), 1]);
    trialData = [trialData; [table(makeType), tableInfo(tIs, :)]];
    
    %Try to convert number strings to doubles
    for v = 1:length(varnames)
        if iscell(trialData{1, 1+v})
            if ismember(trialData{1, 1+v}{1}, '0123456789+-.')
                trialData.(varnames{v}) = str2double(trialData{:, 1+v});
            end
        end
    end    
end