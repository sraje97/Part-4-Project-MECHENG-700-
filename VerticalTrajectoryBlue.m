% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle'). Look
% at the help function of rand "help rand" for more information
% rng('default');
rng('shuffle');

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens');

% Draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen. When only one screen is attached to the monitor we will draw to
% this.
screenNumber = max(screens);

% Define black and white (white will be 1 and black 0).
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Choose the RGB intensity (for all RGB vectors)
colourLevel = 1;

% Size of Square
maxLimit = 500;

% Open an on screen window and color it purple
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, [colourLevel, 0, colourLevel]);
% Get the size of the on screen window in pixels
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
[xCenter, yCenter] = RectCenter(windowRect);

% Enable alpha blending for anti-aliasing
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Use the meshgrid command to create our base dot coordinates
dim = 1;
% [x, y] = meshgrid(dim, dim);
x = 1;
y = 1;

% Calculate the number of dots
numDots = numel(x);

% Make the matrix of positions for the dots into two vectors
% xPosVector = reshape(x, 1, numDots);
% yPosVector = reshape(y, 1, numDots);
xPosVector = maxLimit*-1;
yPosVector = maxLimit*-1;

% We can define a center for the dot coordinates to be relaitive to. Here
% we set the centre to be the centre of the screen
dotCenter = [screenXpixels / 2 screenYpixels / 2];

% Set the color of our dot to be random
% dotColors = rand(3, numDots);
dotColoursBlue = [0 0 colourLevel];
dotColoursRed = [colourLevel 0 0];

% Set the size of the dots randomly between 10 and 30 pixels
% dotSizes = round(rand(1, numDots) .* 20);
dotSizes = 20;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% Distance to increment
gridXPos = 0;
gridYPos = 0;

% Increment Speed
speed = 5;

% Direction to move in (1 = Right, 2 = Left, 3 = Down, 4 = Up)
direction = 3;

time = 0;

% Blue dots
for i = 1:3
    [minSmoothPointSize, maxSmoothPointSize, minAliasedPointSize, maxAliasedPointSize] = Screen('DrawDots', window, [xPosVector; yPosVector], dotSizes, dotColoursBlue, dotCenter, 2);
    % Flip to the screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    pause(1);
    pointReached = false;
    
    % Loop the animation until a key is pressed
    while ~pointReached
        
        % Move Right (until 500)
        if (direction == 1) && (xPosVector <= maxLimit)
            xPosVector = xPosVector + speed;
        end
        
        % Move Left (until -500)
        if (direction == 2) && (xPosVector >= (maxLimit*-1))
            xPosVector = xPosVector - speed;
        end

        % Move Down (until 500)
        if (direction == 3) && (yPosVector <= maxLimit)
            yPosVector = yPosVector + speed;
        end

        % Move Up (until -500)
        if (direction == 4) && (yPosVector >= (maxLimit*-1))
            yPosVector = yPosVector - speed;
        end

        % Draw all of our dots to the screen in a single line of code adding
        % the sine oscilation to the X coordinates of the dots
        [minSmoothPointSize, maxSmoothPointSize, minAliasedPointSize, maxAliasedPointSize] = Screen('DrawDots', window, [xPosVector + gridXPos; yPosVector + gridYPos], dotSizes, dotColoursBlue, dotCenter, 2);

        % Change direction if maxlimit reached
        if (direction == 3) && (yPosVector >= maxLimit) && (xPosVector == (maxLimit*-1))
            direction = 4;
            xPosVector = 0;
            pointReached = true;
            pause(0.5);
        end

        if (direction == 4) && (yPosVector <= (maxLimit*-1)) && (xPosVector == 0)
            direction = 3;
            xPosVector = maxLimit;
            pointReached = true;
            pause(0.5);
        end

        if (direction == 3) && (yPosVector >= maxLimit) && (xPosVector == maxLimit)
            pause(0.5);
            pointReached = true;
            speed = 0;
        end

        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

        % Increment the time
        time = time + ifi;

    end
end

% % Query the frame duration
% ifi = Screen('GetFlipInterval', window);
% 
% xPosVector = maxLimit*-1;
% yPosVector = maxLimit*-1;
% [minSmoothPointSize, maxSmoothPointSize, minAliasedPointSize, maxAliasedPointSize] = Screen('DrawDots', window, [xPosVector; yPosVector], dotSizes, dotColoursRed, dotCenter, 2);
% % Flip to the screen
% vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
% pause(1);
% 
% % Red dots
% for i = 1:3
%     [minSmoothPointSize, maxSmoothPointSize, minAliasedPointSize, maxAliasedPointSize] = Screen('DrawDots', window, [xPosVector; yPosVector], dotSizes, dotColoursRed, dotCenter, 2);
%     % Flip to the screen
%     vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
%     pause(1);
%     pointReached = false;
%     
%     % Loop the animation until a key is pressed
%     while ~pointReached
%         
%         % Move Right (until 500)
%         if (direction == 1) && (xPosVector <= maxLimit)
%     %         if (xPosVector <= (maxLimit*-1)) && (yPosVector == (maxLimit*-1)) 
%     %             pause(1);
%     %         end
%     %         if (xPosVector <= (maxLimit*-1)) && (yPosVector == maxLimit)
%     %             pause(1);
%     %         end
%             xPosVector = xPosVector + speed;
%         end
%         % Move Left (until -500)
%         if (direction == 2) && (xPosVector >= (maxLimit*-1))
%     %         if (xPosVector >= maxLimit) && (yPosVector == 0)
%     %             pause(1);
%     %         end
%             xPosVector = xPosVector - speed;
%         end
% 
%         % Move Down (until 500)
%         if (direction == 3) && (yPosVector <= maxLimit)
%             yPosVector = yPosVector + speed;
%         end
% 
%         % Move Up (until -500)
%         if (direction == 4) && (yPosVector >= (maxLimit*-1))
%             yPosVector = yPosVector - speed;
%         end
% 
%         % Draw all of our dots to the screen in a single line of code adding
%         % the sine oscilation to the X coordinates of the dots
%         [minSmoothPointSize, maxSmoothPointSize, minAliasedPointSize, maxAliasedPointSize] = Screen('DrawDots', window, [xPosVector + gridXPos; yPosVector + gridYPos], dotSizes, dotColoursRed, dotCenter, 2);
% 
%         % Change direction if maxlimit reached
%         if (direction == 3) && (yPosVector >= maxLimit) && (xPosVector == (maxLimit*-1))
%             direction = 4;
%             xPosVector = 0;
%             pointReached = true;
%             pause(0.5);
%         end
% 
%         if (direction == 4) && (yPosVector <= (maxLimit*-1)) && (xPosVector == 0)
%             direction = 3;
%             xPosVector = 500;
%             pointReached = true;
%             pause(0.5);
%         end
% 
%         if (direction == 3) && (yPosVector >= maxLimit) && (xPosVector == 500)
%             pause(0.5);
%             pointReached = true;
%             speed = 0;
%         end
% 
%         % Flip to the screen
%         vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
% 
%         % Increment the time
%         time = time + ifi;
% 
%     end
% end

% Clear the screen. "sca" is short hand for "Screen CloseAll". This clears
% all features related to PTB. Note: we leave the variables in the
% workspace so you can have a look at them if you want.
sca;