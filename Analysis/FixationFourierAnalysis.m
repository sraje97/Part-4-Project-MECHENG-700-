function [aFrawX_, pFrawX_] = FixationFourierAnalysis(dataFFT,fixPoint)
    sFreq = 1024;
    
    if fixPoint == 0
        totTime = length(dataFFT(1,:))/sFreq;
        rawX_ = dataFFT(1,:) - mean(dataFFT(1,:));
        rawY_ = dataFFT(2,:) - mean(dataFFT(2,:));

        FrawX_ = abs(fft(rawX_)/length(rawX_));
        FrawY_ = abs(fft(rawY_)/length(rawY_));
    else
        numSeg = size(dataFFT,1);
        rawX_ = zeros(numSeg,size(dataFFT,2));
        rawY_ = zeros(numSeg,size(dataFFT,2));
        FrawX_ = zeros(numSeg,size(dataFFT,2));
        FrawY_ = zeros(numSeg,size(dataFFT,2));
        for i = 1:numSeg
            totTime = size(dataFFT,2)/sFreq;
%             cutTime = 0; % if you want to choose a smaller set of samples

            rawX_(i,:) = dataFFT(i,:,1) - mean(dataFFT(i,:,1));
            rawY_(i,:) = dataFFT(i,:,2) - mean(dataFFT(i,:,2));

            rawX_(i,:) = rawX_(i,1:(totTime*sFreq));
            rawY_(i,:) = rawY_(i,1:(totTime*sFreq));

            FrawX_(i,:) = abs(fft(rawX_(i,:))/length(rawX_(i,:)));
            FrawY_(i,:) = abs(fft(rawY_(i,:))/length(rawY_(i,:)));
        end
    end
    
    FAXIS = (1/totTime)*(0:(length(FrawX_)-1));
    
    aFrawX_ = 2*abs(FrawX_(:,1:floor(length(FrawX_)/2)));
    aFrawY_ = 2*abs(FrawY_(:,1:floor(length(FrawY_)/2)));
    
    aFrawX_(1,1) = aFrawX_(1,1)/2;
    aFrawY_(1,1) = aFrawY_(1,1)/2;
    
    pFrawX_ = 20*log10(aFrawX_ / aFrawX_(1,1));
    pFrawY_ = 20*log10(aFrawY_ / aFrawY_(1,1));
    
    figure;
    hold on; 
    plot(FAXIS(1:length(aFrawX_)),aFrawX_); 
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
    plot(FAXIS(1:length(aFrawY_)),aFrawY_); 
    axis square; 
    grid on
    axis([0 5 ylim]);
    title('Y Position FFT Analysis')
    xlabel('Frequency Component (Hz)');
    ylabel('Amplitude (au)');
    legend('Point 1', 'Point 2', 'Point 3', 'Point 4', 'Point 5', 'Point 6',...
        'Point 7', 'Point 8', 'Point 9');
end