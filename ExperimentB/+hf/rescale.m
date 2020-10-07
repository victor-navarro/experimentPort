function data = rescale(data, d, s)
	%Simple rescaling function to rescale data. 
    %d and s are vectors containing the min and max of the data (d) and the desired scale (s)
    data = s(1) + ((data-d(1))*(s(2)-s(1))/(d(2) - d(1)));
end