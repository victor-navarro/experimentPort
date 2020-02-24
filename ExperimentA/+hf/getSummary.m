function summary = getSummary(data, dv, iv)
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
    
    
    