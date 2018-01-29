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
numStim = randi(5);
shockTimes = 3 + randi(54,[numShocks,1])./2; % generate times according to constraints described above.

% Generate and cycle through displays. Send TTL pulses at the appropriate
% times

dispIntro = ... "
    ... In the next 30 seconds you may be shocked multiple times.
    ... Please keep your eyes focused on the fixation in the center of the screen.
    ... Press any key to begin.
    ... "
    

for t = 0:30
    
end
end

