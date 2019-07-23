% clear;
clc;
% clf;
[filename,folder] = uigetfile('*.bdf');

% filename = 'Testdata_Sid2207.bdf';

%gets header structure of bdf file
[hdr] = read_biosemi_bdf([folder,filename]);

% Required format for reading data per channel
%[dat] = read_biosemi_bdf('filename.bdf'), hdr, startindex, finalindex, channelindex);

%272 for EyeX
[rawX] = read_biosemi_bdf([folder,filename], hdr, 1, hdr.nSamples, 272);

%273 for EyeY
[rawY] = read_biosemi_bdf([folder,filename], hdr, 1, hdr.nSamples, 273) .* 2.18;

stepSize = 100;
averagedValues = floor(length(rawX) / stepSize);

dataX = zeros(1,averagedValues);
dataY = zeros(1,averagedValues);

% Compute moving average filter across 100 samples
for i = 1:averagedValues
    sumValuesX = sum(rawX(i*stepSize-(stepSize-1):i*stepSize));
    averageX = sumValuesX / stepSize;
    
    sumValuesY = sum(rawY(i*stepSize-(stepSize-1):i*stepSize));
    averageY = sumValuesY / stepSize;
    
    dataX(i) = averageX;
    dataY(i) = averageY;
end

% scatter(rawX,rawY);
scatter(dataX,dataY);
axis square;
axis equal;

figure;
plot(dataX);
hold on
plot(dataY);