%% TRACKING TESTS
% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Colour intensity
colourLevel = 1;

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, [0 0 0]);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% We can define a center for the dot coordinates to be relaitive to. Here
% we set the centre to be the centre of the screen
dotCenter = [screenXpixels / 2 screenYpixels / 2];

% Our square will oscilate with a sine wave function to the left and right
% of the screen. These are the parameters for the sine wave
% See: http://en.wikipedia.org/wiki/Sine_wave
amplitude = screenXpixels * 0.25;
frequency = 0.12;
angFreq = 2 * pi * frequency;
startPhase = -0.5*pi;
time = 0;

% Calibration Points' position
calDotPosX = [-1 1] .*amplitude;
calDotPosY = [0 0] .*amplitude;

dotYpos = 0;
dotXpos = amplitude * sin(angFreq * time + startPhase);
dotSizes = 6;
dotColoursBlue = [0 0 colourLevel*0.40];
dotColoursRed = [colourLevel*0.40 0 0];

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

baseRect = [0 0 200 200];
centeredRect = CenterRectOnPointd(baseRect, 0, 0);

%% START HORIZONTAL

for i = 1:6
    if (mod(i,2) == 0)
        Screen('DrawDots', window, [calDotPosX(1); calDotPosY(1)], dotSizes,...
        [0 0 0], [screenXpixels / 2 screenYpixels / 2], 2);

        % Flip to the screen
        Screen('Flip', window);
        pause(0.5);
    else
        Screen('DrawDots', window, [calDotPosX(1); calDotPosY(1)], dotSizes,...
        [1 1 1], [screenXpixels / 2 screenYpixels / 2], 2);

        % Flip to the screen
        Screen('Flip', window);
        pause(0.5);
    end
    
end


% Draw White Dot to screen
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, [1 1 1], dotCenter, 2);
Screen('FillRect', window, [1 1 1], centeredRect);
Screen('Flip', window);
pause(1);

% Calibration Test
for i = 1:2
    Screen('DrawDots', window, [calDotPosX(i); calDotPosY(i)], dotSizes,...
    [1 1 1], [screenXpixels / 2 screenYpixels / 2], 2);

    Screen('FillRect', window, [0 0 0], centeredRect);
    
    % Flip to the screen
    Screen('Flip', window);
    pause(2);
end

% Draw Blue Dot to screen
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, dotColoursBlue, dotCenter, 2);
Screen('Flip', window);
pause(2);

% BLUE STIMULUS
while ~KbCheck && (time < (1/frequency)*2)

    % Position of the square on this frame
    dotXpos = amplitude * sin(angFreq * time + startPhase);

    % Draw the dot to the screen
    Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, dotColoursBlue, dotCenter, 2);
    
    % Present trigger
    if (abs(dotXpos) >= 286)
        Screen('FillRect', window, [1 1 1], centeredRect);
    end
    
    % Flip to the screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Increment the time
    time = time + ifi;

end

% Blank screen (REST)
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, [0 0 0], dotCenter, 2);
Screen('Flip', window);
pause(5);

% Draw Red Dot on screen
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, dotColoursRed, dotCenter, 2);
Screen('Flip', window);
pause(2);

% RED STIMULUS
while ~KbCheck && (time < (1/frequency)*4)

    % Position of the square on this frame
    dotXpos = amplitude * sin(angFreq * time + startPhase);

    % Draw the dot to the screen
    Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, dotColoursRed, dotCenter, 2);
    
    % Present trigger
    if (abs(dotXpos) >= 286)
        Screen('FillRect', window, [1 1 1], centeredRect);
    end
    % Flip to the screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Increment the time
    time = time + ifi;

end

% Blank screen
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, [0 0 0], dotCenter, 2);
Screen('Flip', window);
pause(5);

%% START VERTICAL
% Our square will oscilate with a sine wave function to the left and right
% of the screen. These are the parameters for the sine wave
% See: http://en.wikipedia.org/wiki/Sine_wave
amplitude = screenYpixels * 0.40;
frequency = 0.12;
angFreq = 2 * pi * frequency;
startPhase = -0.5*pi;
time = 0;

% Calibration Point's position
calDotPosX = [0 0] .*amplitude;
calDotPosY = [-1 1] .*amplitude;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

baseRect = [0 0 200 200];
centeredRect = CenterRectOnPointd(baseRect, 0, 0);

% Start vertical
dotXpos = 0;
dotYpos = amplitude * sin(angFreq * time + startPhase);
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, [1 1 1], dotCenter, 2);
Screen('FillRect', window, [1 1 1], centeredRect);
Screen('Flip', window);
pause(1);

% Calibration Test
for i = 1:2
    Screen('DrawDots', window, [calDotPosX(i); calDotPosY(i)], dotSizes,...
    [1 1 1], [screenXpixels / 2 screenYpixels / 2], 2);

    Screen('FillRect', window, [0 0 0], centeredRect);
    
    % Flip to the screen
    Screen('Flip', window);
    pause(2);
end

% Draw Blue Dot to screen
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, dotColoursBlue, dotCenter, 2);
Screen('Flip', window);
pause(2);

% BLUE STIMULUS
while ~KbCheck && (time < (1/frequency)*2)

    % Position of the square on this frame
    dotYpos = amplitude * sin(angFreq * time + startPhase);

    % Draw the dot to the screen
    Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, dotColoursBlue, dotCenter, 2);
    
    % Present trigger
    if (abs(dotYpos) >= 343)
        Screen('FillRect', window, [1 1 1], centeredRect);
    end
    
    % Flip to the screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Increment the time
    time = time + ifi;

end

% Blank screen (REST)
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, [0 0 0], dotCenter, 2);
Screen('Flip', window);
pause(5);

% Draw Red Dot to screen
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, dotColoursRed, dotCenter, 2);
Screen('Flip', window);
pause(2);

% RED STIMULUS
while ~KbCheck && (time < (1/frequency)*4)

    % Position of the square on this frame
    dotYpos = amplitude * sin(angFreq * time + startPhase);

    % Draw the dot to the screen
    Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, dotColoursRed, dotCenter, 2);
    
    % Present trigger
    if (abs(dotYpos) >= 343)
        Screen('FillRect', window, [1 1 1], centeredRect);
    end
    % Flip to the screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Increment the time
    time = time + ifi;

end

% Clear the screen
sca;
