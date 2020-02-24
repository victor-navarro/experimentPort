function saveInfo = makeFilenames(saveInfo, expParams)
    time = datetime('now', 'Format', 'M-d-y_HH-mm');
    saveInfo.trialfname = sprintf('%s_%s_%s.txt', expParams.Subject, 'trial', time);
    saveInfo.totalfname = sprintf('%s_%s_%s.txt', expParams.Subject, 'total', time);
    saveInfo.peckfname = sprintf('%s_%s_%s.txt', expParams.Subject, 'peck', time);
end