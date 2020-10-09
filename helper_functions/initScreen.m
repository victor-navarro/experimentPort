function [pointer, displayRect] = initScreen(screenInfo)
% INITSCREEN Initialize computer screen for Psychtoolbox
%
% USE:
% [pointer, displayRect] = initScreen(screenInfo)
%
% ARGS:
% 	screenInfo: struct that contains:
%		- screenBG: Psychtoolbox-friendly color vector
%		- debug: logical to enable disable screen in debug mode. Not implemented!
%
% VALS:
% 	pointer: a double. The screen pointer.
%	displayRect: a vector. The screen coordinates in Psychtoolbox format.

%initialize screen (Psychtoolbox)
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'DefaultFontSize', 10);
Screen('Preference','TextRenderer',0); %setting this to 1 crashes due to gStreamer
% Get the screen pointers
screens = Screen('Screens');
% Draw to the external screen if avaliable
screenNumber = max(screens);
%Calculate the area of the screen to use, based on debugmode
if screenInfo.debug
	screen_rect = [0, 0, 640, 640]; %Set the screen rect
else
% 		%If running fullscreen, need to truncate the width to be same as the maximum height (1:1 aspect ratio)
% 		w = Screen('Resolution', screenNumber).width;
% 		h = Screen('Resolution', screenNumber).height;
% 		hd = (w-h)/2;
% 		screen_rect = [0, 0, w, h];
% 		display_rect = [hd, 0, h+hd, h];
	screen_rect = [];
end
%Open the screen, get a pointer (window) and the screen's dimensions (windowRect)
[pointer, displayRect] = PsychImaging('OpenWindow', screenNumber, screenInfo.screenBG, screen_rect, [], [], [], 16);
Screen('BlendFunction', pointer, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

end