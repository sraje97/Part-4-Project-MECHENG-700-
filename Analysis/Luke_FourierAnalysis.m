sFreq = 1024;
totTime = length(rawX_f)/sFreq;
cutTime = 20; % if you want to choose a smaller set of samples

rawX_ = rawX - mean(rawX);
rawY_ = rawY - mean(rawY);
% rawX_ = data(1,:,1) - mean(data(1,:,1));
% rawY_ = data(1,:,2) - mean(data(1,:,2));

rawX_ = rawX_(1:(totTime*sFreq));
rawY_ = rawY_(1:(totTime*sFreq));

aFrawX_ = abs(fft(rawX_)/length(rawX_));
aFrawY_ = abs(fft(rawY_)/length(rawY_));

FAXIS = (1/totTime)*(0:(length(aFrawX_)-1));

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