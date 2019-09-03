function [] = FixationFourierAnalysis(dataFFT,fixPoint)
    sFreq = 1024;
    
    if fixPoint == 0
        totTime = length(dataFFT(1,:))/sFreq;
        rawX_ = dataFFT(1,:) - mean(dataFFT(1,:));
        rawY_ = dataFFT(2,:) - mean(dataFFT(2,:));

        aFrawX_ = abs(fft(rawX_)/length(rawX_));
        aFrawY_ = abs(fft(rawY_)/length(rawY_));

        FAXIS = (1/totTime)*(0:(length(aFrawX_)-1));
    else
        rawX_ = zeros(9,length(dataFFT(fixPoint,:,1)));
        rawY_ = zeros(9,length(dataFFT(fixPoint,:,1)));
        aFrawX_ = zeros(9,length(dataFFT(fixPoint,:,1)));
        aFrawY_ = zeros(9,length(dataFFT(fixPoint,:,1)));
        for i = 1:9
            totTime = length(dataFFT(i,:,1))/sFreq;
%             cutTime = 0; % if you want to choose a smaller set of samples

            rawX_(i,:) = dataFFT(i,:,1) - mean(dataFFT(i,:,1));
            rawY_(i,:) = dataFFT(i,:,2) - mean(dataFFT(i,:,2));

            rawX_(i,:) = rawX_(i,1:(totTime*sFreq));
            rawY_(i,:) = rawY_(i,1:(totTime*sFreq));

            aFrawX_(i,:) = abs(fft(rawX_(i,:))/length(rawX_(i,:)));
            aFrawY_(i,:) = abs(fft(rawY_(i,:))/length(rawY_(i,:)));

            FAXIS = (1/totTime)*(0:(length(aFrawX_(i,:))-1));
        end
    end
    figure;
    hold on; 
    plot(FAXIS,aFrawX_); 
    axis square; 
    grid on
    axis([0 5 ylim]);
    title('X Position FFT Analysis');
    xlabel('Frequency Component (Hz)');
    ylabel('Amplitude (au)');
    legend('Point 1', 'Point 2', 'Point 3', 'Point 4', 'Point 5', 'Point 6',...
        'Point 7', 'Point 8', 'Point 9');

    figure;
    hold on; 
    plot(FAXIS,aFrawY_); 
    axis square; 
    grid on
    axis([0 5 ylim]);
    title('Y Position FFT Analysis')
    xlabel('Frequency Component (Hz)');
    ylabel('Amplitude (au)');
    legend('Point 1', 'Point 2', 'Point 3', 'Point 4', 'Point 5', 'Point 6',...
        'Point 7', 'Point 8', 'Point 9');
end