% data = dataRB;
data = dataBR;

amp = zeros(9, length(data)-1);
phaseX = zeros(9, length(data)-1);
phaseY = zeros(9, length(data)-1);

time = linspace(0,length(data)/1024,length(data));
totTime = size(data,2)/1024;
%FAXIS = (1/totTime)*(0:(length(phaseX)-1));

for i = 1:9
   fix6X = data(i,:,1);
   fix6Y = data(i,:,2);
   fix6X = fix6X - mean(fix6X);
   fix6Y = fix6Y - mean(fix6Y);
   n_fft = length(fix6X);
   
   fix6X_fft = fft(fix6X)/n_fft;
   fix6Y_fft = fft(fix6Y)/n_fft;
   
   phase1 = unwrap(angle(fix6X_fft));
   phase2 = unwrap(angle(fix6Y_fft));
   
   phaseX(i,:) = phase1(2:end);
   phaseY(i,:) = phase2(2:end);
end