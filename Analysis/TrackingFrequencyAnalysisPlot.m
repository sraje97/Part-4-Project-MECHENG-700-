[amp,phases] = TrackingFrequencyAnalysis(data(1,:,1));
time = linspace(0,length(data)/2048,length(data));

figure; hold on; axis square
plot(time,-amp(2) * cos(2*pi*0.12*time)) % <-- CHECK CALIBRATION DOTS FOR AMP HERE
plot(time,data(1,:,1))
plot(time,amp(2) * cos(2*pi*0.12*time + phases(2)))
xlabel('Time (s)')
ylabel('Position (au)')
legend('Stimulus','Tracking','Tracking FFT''d')