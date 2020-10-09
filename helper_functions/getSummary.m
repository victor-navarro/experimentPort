function summary = getSummary(data, dv, iv)
% GETSUMMARY Get a summary string on data set
% Mostly used to get email-ready summaries.
%
% USE:
% 	summary = getSummary(data, dv, iv)
%
% ARGS:
% 	data: a MATLAB table, usually the output of readData
% 	dv: a string denoting the column containing the dependent variable
% 	iv: a string denoting the column containing the independent variable
%
% VALS:
% 	summary: a string
%
% See also READDATA

    %only does one column. If you want nested levels, you need to pass a
    %subsetted data (e.g., data.([1, 4, 5], :))
    summary = [];
    [b, ~, n] = unique(data.(iv) , 'first');
    sums  = accumarray(n , data.(dv) , size(b) , @(x) sum(x));
    lengths  = accumarray(n , data.(dv) , size(b) , @(x) length(x));
    means = sums./lengths;
    
    %line breaks are forced
    for i = 1:size(b)
        summary = [summary sprintf('%s (%d/%d) = %1.2f', b{i}, sums(i), lengths(i), means(i)) 10];
    end
    summary = [summary, 10];
    
    
    