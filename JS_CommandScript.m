clear;
clc;

% Opening bdf file and reading data

% RUN FIRST to get header structure of bdf file
[hdr] = read_biosemi_bdf('FixationTestDataFilter_Sid1207.bdf')

% Enter number of samples (eg. 69632) provided by header structure
% Use channel 272 for EyeX
[rawX] = read_biosemi_bdf('FixationTestDataFilter_Sid1207.bdf', hdr, 1, 69632, 272);

% use channel 273 for EyeY
[rawY] = read_biosemi_bdf('FixationTestDataFilter_Sid1207.bdf', hdr, 1, 69632, 273) .* 2.18;

% Moving Average Filter
stepSize = 100;
averagedValues = floor(length(rawX) / stepSize);

dataX = zeros(1,averagedValues);
dataY = zeros(1,averagedValues);

for i = 1:averagedValues
    sumValuesX = sum(rawX(i*stepSize-(stepSize-1):i*stepSize));
    averageX = sumValuesX / stepSize;
    
    sumValuesY = sum(rawY(i*stepSize-(stepSize-1):i*stepSize));
    averageY = sumValuesY / stepSize;
    
    dataX(i) = averageX;
    dataY(i) = averageY;
end

% Discard initial/final sensor noise/outliers
dataX = dataX(1:675);
dataY = dataY(1:675);

% Eye tracking data plot 
figure;
scatter(dataX,dataY);
axis equal;
axis square;
title('Tracking Data from Fixation Test with Filters');
ylabel('Vertical Displacement (Gain Adjusted) [uV]');
xlabel('Horizontal Displacement [uV]');

