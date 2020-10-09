function data = rescale(data, d, s)
% RESCALE Rescale data
%
% USE:
%   data = rescale(data, d, s)
%
% ARGS:
%   data: double of data to be rescaled
%   d: vector of [dmin, dmax], containing the range of the data.
%   s: vector of [smin, smax], containing the range of the desired scale.
%
% VALS:
% 	data: rescaled double of data
%
% See also: RESCALERECT
    data = s(1) + ((data-d(1))*(s(2)-s(1))/(d(2) - d(1)));
end