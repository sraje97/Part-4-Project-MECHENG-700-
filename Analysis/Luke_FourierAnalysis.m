sFreq = 2048;
totTime = length(rawX)/sFreq;
cutTime = 3; % if you want to choose a smaller set of samples

% rawX_ = rawX - mean(rawX);
% rawY_ = rawY - mean(rawY);
rawX_ = data(1,:,1) - mean(data(1,:,1));
rawY_ = data(1,:,2) - mean(data(1,:,2));

rawX_ = rawX_(1:(cutTime*sFreq));
rawY_ = rawY_(1:(cutTime*sFreq));

aFrawX_ = abs(fft(rawX_)/length(rawX_));
aFrawY_ = abs(fft(rawY_)/length(rawY_));

FAXIS = (1/cutTime)*(0:(length(aFrawX_)-1));

figure;
hold on; 
plot(FAXIS,aFrawX_,'-r'); 
axis square; 
grid on
axis([0 5 ylim]);
title('X');

figure;
hold on; 
plot(FAXIS,aFrawY_,'-r'); 
axis square; 
grid on
axis([0 5 ylim]);
title('Y')