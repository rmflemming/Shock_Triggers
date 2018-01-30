function [shockTimes] = shockProc(lj,ljChan,stimWindow,stimRect)
%Send TTL pulses to labjack at constrained-random times.
%   Uniform randomly distributed times between 3 sec and 30 sec. These
%   shocks are constrained to be at least 1 sec apart, and occurring only
%   at whole and half seconds.
%   Inputs:
%   lj = labjack handle
%   ljChan = channel on the labjack from which the stimulation device
%   receives input.
%   stimWindow = handle for the stimulus display screen
%   stimReect = handle for the stimulus rect (used to center display)

% Get the times
rng('shuffle');
numStim = randi(5);
shockTimes = 3 + randi(54,[numShocks,1])./2; % generate times according to constraints described above.
shockTimes = sort(shockTimes); % sort them in ascending order

% Generate and cycle through displays. Send TTL pulses at the appropriate
% times

dispIntro = "In the next 30 seconds you may be shocked multiple times. \n Please keep your eyes focused on the fixation in the center of the screen. \n Press any key to begin.";   

DrawFormattedText(stimWindow,dispIntro,'center','center','k');
Pause(10);

nomFrameRate = Screen('NominalFrameRate',stimWindow); % nominal frame rate of stime display

presSecs = [sort(repmat(1:.5:30,1,nominalFrameRate*2),'descend') 0]; % List of display numbers

shocked = 0; % variable to track number of times shocked so far

for i = 1:length(presSecs)
    % Convert display number to string
    numStr = num2str(presSecs(i));
    
    % Draw the number to screen (if whole number)
    if mod(presSecs(i),1) == 0 
        DrawFormattedText(stimWindow,numStr,'center','center','k');
    
        % Flip to the screen
        Screen('Flip', stimWindow);
    end
    % If the time matches with the shock times, send TTL pulse
    try
        if numStr == 30 - shockTimes(shocked + 1)
            lj.toggleFIO(lj,ljChan);
            shocked = shocked + 1;
        end   
    end        
end

WaitSecs(1); 
sca
end

