function rect = rescaleRect(rect, rectRange, newRange)
% RESCALERECT Rescale Psychtoolbox rect
%
% USE:
%   data = rescaleRect(rect, rectRange, newRange)
%
% ARGS:
%   rect: double to be rescaled
%   rectRange: vector of [dmin, dmax], containing the range of the rect.
%   newRange: vector of [smin, smax], containing the range of the new rect.
%
% VALS:
% 	rect: rescaled rect.
%
% Notes:
% rectRange is the range for rect (e.g., [0, 0, 1, 1], if your rect is in unit space) 
% newRange is the new range (e.g., [0, 0, 1024, 768]; usually your display area or a portion of it.
%
% See also: RESCALE

    rect([1, 3]) = hf.rescale(rect([1, 3]), rectRange([1, 3]), newRange([1, 3]));
    rect([2, 4]) = hf.rescale(rect([2, 4]), rectRange([2, 4]), newRange([2, 4]));