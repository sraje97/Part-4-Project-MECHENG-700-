clear;
clc;
close all;

%% Load File and Extract Data
[filename,folder] = uigetfile('*.bdf');

% filename = 'Testdata_Sid2207.bdf';

%gets header structure of bdf file
[hdr] = read_biosemi_bdf([folder,filename]);

% Required format for reading data per channel
%[dat] = read_biosemi_bdf('filename.bdf'), hdr, startindex, finalindex, channelindex);

% 272 or 40 for EyeX
[rawX] = read_biosemi_bdf([folder,filename], hdr, 1, hdr.nSamples, hdr.nChans-9);

% 273 or 41 for EyeY
[rawY] = read_biosemi_bdf([folder,filename], hdr, 1, hdr.nSamples, hdr.nChans-8);

% Status channel for trigger
[trig] = read_biosemi_bdf([folder,filename], hdr, 1, hdr.nSamples, hdr.nChans);

trig_0 = mod(trig,2);

%% Average raw data in sample size
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


%% Fixation or Tracking Test
if (filename(1:8) == "Fixation")
    disp('Fixation Calibration function here');
%     [cal, data] = SegmentFixationData(rawX, rawY, trig_0);
    disp('Mean and SD function here');
    disp('Oscillation and FFT function here');
    disp('Plots and Results function here');
    
elseif (filename(1:8) == "Tracking")
    disp('Tracking Calibration function here');
%     [cal, data] = SegmentTrackingData(rawX, rawY, trig_0);
    disp('Gain and Phase function here');
    disp('Plots and Results function here');
    
else
    disp('Please choose Tracking or Fixation file.');
    return;
end


%% Plot results
figure;
fs = 2048;
fs_1 = 2048/stepSize;

Zraw = 0:1/fs:(length(rawX)-1)/fs;
scatter3(rawX,rawY, Zraw, 10, Zraw);
colormap(jet);
colorbar;
axis square;
xlabel('X');
ylabel('Y');
view(0,90);

% scatter(dataX,dataY);
figure;
Z = 0:1/fs_1:(length(dataX)-1)/fs_1;
scatter3(dataX,dataY,Z,10,Z);
colormap(jet);
colorbar;
axis square;
xlabel('X');
ylabel('Y');
view(0,90);

figure;
plot(Z,dataX);
hold on
plot(Z,dataY);

figure;
plot(trig_0);
