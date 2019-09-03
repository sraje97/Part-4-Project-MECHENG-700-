clear;
clc;
% close all;

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

rawX_f = rawX(1:2:end);
rawY_f = rawY(1:2:end);
trig_0_f = trig_0(1:2:end);

%% Average raw data in sample size
stepSize = 100;
averagedValues = floor(length(rawX_f) / stepSize);

dataX = zeros(1,averagedValues);
dataY = zeros(1,averagedValues);

% Compute moving average filter across 100 samples
for i = 1:averagedValues
    sumValuesX = sum(rawX_f(i*stepSize-(stepSize-1):i*stepSize));
    averageX = sumValuesX / stepSize;
    
    sumValuesY = sum(rawY_f(i*stepSize-(stepSize-1):i*stepSize));
    averageY = sumValuesY / stepSize;
    
    dataX(i) = averageX;
    dataY(i) = averageY;
end


%% Fixation or Tracking Test
if (filename(1:8) == "Fixation")
    [cal, data] = SegmentFixationData(rawX_f, rawY_f, trig_0_f);
    [calMSD, dataMSD] = MeanSD(cal, data);
    [horDist, verDist] = CalibrationDistance(calMSD);
    FixationFourierAnalysis(data,9);
    disp('Plots and Results function here');
    
elseif (filename(1:8) == "Tracking")
    [cal, data] = SegmentTrackingData(rawX_f, rawY_f, trig_0_f);
    [calMSD, dataMSD] = MeanSD(cal, data);
    TrackingFrequencyAnalysisPlot(cal,data);
    disp('Plots and Results function here');
    
else
    disp('Please choose Tracking or Fixation file.');
%     return;
end


%% Plot results
figure;
fs = 2048;
fs_1 = fs/stepSize;

fs_f = 1024;
fs_1_f = fs_f/stepSize;

Zraw_f = 0:1/fs_f:(length(rawX_f)-1)/fs_f;
scatter3(rawX_f,rawY_f, Zraw_f, 10, Zraw_f);
colormap(jet);
colorbar;
axis square;
xlabel('X Position (uV)');
ylabel('Y Position (uV)');
title('Raw X vs Y Displacement Data');
view(0,90);

figure;
Z = 0:1/fs_1_f:(length(dataX)-1)/fs_1_f;
scatter3(dataX,dataY,Z,10,Z);
colormap(jet);
colorbar;
axis square;
xlabel('X Position (uV)');
ylabel('Y Position (uV)');
title('X vs Y Displacement Data');
view(0,90);

figure;
plot(Z,dataX);
hold on
plot(Z,dataY);

figure;
plot(trig_0_f);
