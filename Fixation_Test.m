% Clear the workspace
sca;
clearvars;
close all;


%--------------------------------------------------------------------------
%                      Set up the screen
%--------------------------------------------------------------------------

% Set the stereomode 6 for red-green anaglyph presentation. You will need
% to view the image with the red filter over the left eye and the green
% filter over the right eye.
stereoMode = 6;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Skip sync tests for this demo in case people are using a defective
% system. This is for demo purposes only.
Screen('Preference', 'SkipSyncTests', 2);

% Setup Psychtoolbox for OpenGL 3D rendering support and initialize the
% mogl OpenGL for Matlab wrapper
InitializeMatlabOpenGL;

% Get the screen number
screenid = max(Screen('Screens'));

% Choose RGB intensity (for all RGB vectors)
ColourLevel = 0.5;

% Open the main window
[window, windowRect] = PsychImaging('OpenWindow', screenid, [ColourLevel 0 ColourLevel 0]); %,...
%     [], 32, 2, stereoMode);

% Show cleared start screen:
Screen('Flip', window);

% Screen size pixels
[screenXpix, screenYpix] = Screen('WindowSize', window);

% Set up alpha-blending for smooth (anti-aliased) edges to our dots
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%--------------------------------------------------------------------------
%                      Set up the screen
%--------------------------------------------------------------------------

% Set the size of the square to be a fraction of the screen size. This will
% give us similar results on any demo system hopefully
squareDimPix = screenXpix / 2;

% For ease will will position dots +/- half of this size i.e. centered
% around zero. When we draw to the screen we center the dots automatically.
squareHalfDimPix = squareDimPix / 2;

% Number of dots
numDots = 1;

% Dot base position in pixels for the left and right eye. As you will see
% the vertical do positions will be the same in both cases.
dotPosXleft = [-1 0 1 1 0 -1 -1 0 1] .* squareHalfDimPix;
dotPosYleft = [-1 -1 -1 0 0 0 1 1 1] .* squareHalfDimPix;

% Dot diameter in pixels
dotDiaPix = 20;

%------------------------
% Drawing to the screen
%------------------------

% When drawing in stereo we have to select which eyes buffer we are going
% to draw in. These are labelled 0 for left and 1 for right. Note also, if
% you wear your anaglyph glasses the opposite way around the depth will
% reverse.

% Select left-eye image buffer for drawing (buffer = 0)
Screen('SelectStereoDrawBuffer', window, 0);

for i = 1:9
    for j = 1:2
        if mod(j,2) == 0
            % Now draw our left eyes dots
            Screen('DrawDots', window, [dotPosXleft(i); dotPosYleft(i)], dotDiaPix,...
            [ColourLevel 0 0], [screenXpix / 2 screenYpix / 2], 2);
        else
            % Now draw our left eyes dots
            Screen('DrawDots', window, [dotPosXleft(i); dotPosYleft(i)], dotDiaPix,...
            [0 0 ColourLevel], [screenXpix / 2 screenYpix / 2], 2);
        end
        % Flip to the screen
        Screen('Flip', window);
        
        % Wait for a button press to exit the demo
        pause(1);
        
        % Now draw our left eyes dots
        Screen('DrawDots', window, [dotPosXleft(i); dotPosYleft(i)], dotDiaPix,...
        [ColourLevel 0 ColourLevel], [screenXpix / 2 screenYpix / 2], 2);
        
        % Flip to the screen
        Screen('Flip', window);
        
        % Wait for a button press to exit the demo
        pause(0.5);
        
%         KbCheck;
    end
%     KbWait;
end

KbWait;
sca;
  