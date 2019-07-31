% Calibration and Oscillation Analysis for 59 second test
% Assume correctly done for the first 5 seconds

calValX = rawX(1:10240);
calValY = rawY(1:10240);

rawX2 = rawX(2049:end);
rawY2 = rawY(2049:end);

% Average and spread of the calibration test
avgcalX = mean(calValX);
avgcalY = mean(calValY);
sdcalX = std(calValX);
sdcalY = std(calValY);

samplerate = 2048;
numofoscls = 6;
samplesize = numofoscls * samplerate;

clustersmatrix = zeros(samplesize,2,9);
avgmatrix = zeros(9,4);

% Average and spread of the 9 point fixation test
for i = 1:9
    clustersmatrix(:,1,i) = rawX2(1:samplesize);
    clustersmatrix(:,2,i) = rawY2(1:samplesize);
    
    rawX2 = rawX2(samplesize+1:end);
    rawY2 = rawY2(samplesize+1:end);
end

for i = 1:9
    avgmatrix(i,1) = mean(clustersmatrix(:,1,i)); %avg X
    avgmatrix(i,2) = mean(clustersmatrix(:,2,i)); %avg Y
    avgmatrix(i,3) = std(clustersmatrix(:,1,i)); %s.d X
    avgmatrix(i,4) = std(clustersmatrix(:,2,i)); %s.d Y
end

figure;
scatter(avgmatrix(:,1),avgmatrix(:,2));
% hold on
% scatter(avgcalX, avgcalY);