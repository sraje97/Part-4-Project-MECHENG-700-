close all;

fcX = 0.001;
fcY = 0.001;
fs = 2048;

[bX, aX] = butter(3, fcX/(fs/2),'high');
[bY, aY] = butter(3, fcY/(fs/2),'high');

dataOutX = filter(bX, aX, rawX);
dataOutY = filter(bY, aY, rawY);

figure;
Zraw = 0:1/fs:(length(rawX)-1)/fs;
scatter3(dataOutX,dataOutY, Zraw, 10, Zraw);
colormap(jet);
colorbar;
axis square;
axis equal;
xlabel('X');
ylabel('Y');
view(0,90);

figure;
plot(rawX);
hold on;
plot(dataOutX);
title('X');
legend('rawX', 'Filtered X', 'location', 'East');

figure;
hold on
plot(rawY)
plot(dataOutY)
title('Y');
legend('rawY', 'Filtered Y', 'location', 'East');