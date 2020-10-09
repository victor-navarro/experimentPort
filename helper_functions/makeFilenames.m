function saveInfo = makeFilenames(saveInfo, expParams)
% MAKEFILENAMES Make filenames using experiment information
%
% USE:
% 	saveInfo = makeFilenames(saveInfo, expParams)
%
% ARGS:
% 	saveInfo = a struct containing information for saving data
%	expParams = a struct with experiment information containing:
% 		- Subject: the subject name (from the control panel).
%
% VALS:
% 	saveInfo: a struct with three new fields:
%		- trialfname, totalfname, peckfname: filenames for trial-level data, trial-level data with correction trials, and peck files. All filenames are annotated with the starting time of the experiment.

    time = datetime('now', 'Format', 'M-d-y_HH-mm');
    saveInfo.trialfname = sprintf('%s_%s_%s.txt', expParams.Subject, 'trial', time);
    saveInfo.totalfname = sprintf('%s_%s_%s.txt', expParams.Subject, 'total', time);
    saveInfo.peckfname = sprintf('%s_%s_%s.txt', expParams.Subject, 'peck', time);
end