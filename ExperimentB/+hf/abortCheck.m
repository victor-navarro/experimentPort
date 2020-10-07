function state = abortCheck(state)
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