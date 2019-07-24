% clear;
% clc;

% Calibration and Oscillation Analysis for 59 second test
% Assume correctly done for the first 5 seconds

% Use for calibration data
% % caldataX = rawX;
% % caldataY = rawY;

% Use for oscillation data
% % ocldataX = rawX;
% % ocldataY = rawY;

% Average and spread of the calibration test
avgcalX = mean(caldataX);
avgcalY = mean(caldataY);
sdcalX = std(caldataX);
sdcalY = std(caldataY);

% Average and spread of the oscillation test
avgoclX = mean(ocldataX);
avgoclY = mean(ocldataY);
sdoclX = std(ocldataX);
sdoclY = std(ocldataY);

figure;
scatter(avgcalX,avgcalY,'x');
hold on
scatter(avgoclX,avgoclY,'x');
