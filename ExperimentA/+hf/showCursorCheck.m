function showCursorCheck()
	[pressed, ~, key] = KbCheck();
	if pressed
		keys = find(key);
		if numel(keys) == 1
			if keys == 32
                ShowCursor(1);
            end
		end
	end
end