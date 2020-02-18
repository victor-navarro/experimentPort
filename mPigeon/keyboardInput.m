function result=keyboardInput

%disp('to stop enter command+p')

persistent keyboardIndex;
if isempty(keyboardIndex)
    theDevices=PsychHID('Devices');
    for i=1:max(size(theDevices))
        if strcmp('Keyboard', theDevices(i).usageName)
            break;
        end
    end
    keyboardIndex=i;
end

result='NONE';

[keyIsDown,secs,keyCode] = KbCheck(keyboardIndex);
% please check PsychHID('Devices')

if keyIsDown
    key=sum(find(keyCode));
    %if(key==282 | key==286)%command button(Left or Right)+'.(period)'
    if(key==458)%both command buttons (Left and Right)
        result='PAUSE';
    end
end


