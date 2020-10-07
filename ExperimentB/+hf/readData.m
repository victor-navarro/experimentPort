function data = readData(fname, vars)
    data = readtable(fname);
    data.Properties.VariableNames = vars;