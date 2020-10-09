function showCursorCheck()
% SHOWCURSORCHECK Check keyboard inputs to show cursor
%
% USE:
% showCursorCheck();
%
% ARGS:
%	none
%
% VALS:
%	none
%
% See also: ABORTCHECK

	[pressed, ~, key] = KbCheck();
	if pressed
		keys = find(key);
		if numel(keys) == 1
            if keys == 32
                ShowCursor(0);
            end
		end
	end
end