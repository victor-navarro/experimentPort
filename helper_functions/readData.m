function data = readData(fname, vars)
% READDATA Read data file as table
%
% USE:
% data = readData(fname, vars)
%
% ARGS:
%	fname: filename containing the data. Usually generated with makeFilenames.
% 	vars: cell containing strings. Strings denote column names in filename.
%
% VALS:
% 	data: a MATLAB table
%
% See also: MAKEFILENAMES

    data = readtable(fname);
    data.Properties.VariableNames = vars;