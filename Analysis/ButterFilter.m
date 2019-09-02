close all;

fcX = 0.5;
fcY = 0.5;
fs = 1024;

[bX, aX] = butter(3, fcX/(fs/2),'high');
[bY, aY] = butter(3, fcY/(fs/2),'high');

dataOutX = filter(bX, aX, rawX_f);
dataOutY = filter(bY, aY, rawY_f);

figure;
Zraw = 0:1/fs:(length(rawX_f)-1)/fs;
scatter3(dataOutX,dataOutY, Zraw, 10, Zraw);
colormap(jet);
colorbar;
axis square;
axis equal;
xlabel('X');
ylabel('Y');
view(0,90);

figure;
hold on;
plot(rawX_f);
plot(dataOutX);
title('X');
legend('rawX', 'Filtered X', 'location', 'East');

figure;
hold on
plot(rawY_f)
plot(dataOutY)
title('Y');
legend('rawY', 'Filtered Y', 'location', 'East');