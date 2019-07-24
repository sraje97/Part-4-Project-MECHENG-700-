fftX = 2.* abs( fft( rawX ));
fftY = 2.* abs( fft( rawY ));

freqX = 0:1/10:(length(fftX)-1)/10;
freqY = 0:1/10:(length(fftY)-1)/10;

figure;
plot(freqX(2:end), fftX(2:end));
figure;
plot(freqY(2:end), fftY(2:end));
