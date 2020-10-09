function state = abortCheck(state)
% ABORTCHECK Check keyboard inputs for abort code
%
% USE:
% newstate = abortCheck(state);
%
% ARGS:
%	state: a string denoting the state in the experiment.
%
% VALS:
%	newstate: state or 'ABORT' if the both control keys are being pressed.

	[pressed, ~, key] = KbCheck();
	if pressed
		keys = find(key);
		if numel(keys) > 1
			if sum(keys(length(keys)-1:end)) == 325 %Both control keys
				state = 'ABORT';
			end
		end
	end
end