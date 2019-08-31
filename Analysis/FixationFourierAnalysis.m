function [] = FixationFourierAnalysis(data,fixPoint)
    sFreq = 1024;
    
    if fixPoint == 0
        totTime = length(data(1,:))/sFreq;
        rawX_ = data(1,:) - mean(data(1,:));
        rawY_ = data(2,:) - mean(data(2,:))
        
        rawX_ = rawX_(1:(totTime*sFreq));
        rawY_ = rawY_(1:(totTime*sFreq));
        
        aFrawX_ = abs(fft(rawX_)/length(rawX_));
        aFrawY_ = abs(fft(rawY_)/length(rawY_));

        FAXIS = (1/totTime)*(0:(length(aFrawX_)-1));
    else
        totTime = length(data(fixPoint,:,1))/sFreq;
        cutTime = 3; % if you want to choose a smaller set of samples
        % data = zeros(1,length(rawX),2);
    %     data(1,:,1) = rawX;
    %     data(1,:,2) = rawY;

        % rawX_ = rawX - mean(rawX);
        % rawY_ = rawY - mean(rawY);
        rawX_ = data(fixPoint,:,1) - mean(data(fixPoint,:,1));
        rawY_ = data(fixPoint,:,2) - mean(data(fixPoint,:,2));

        rawX_ = rawX_(1:(totTime*sFreq));
        rawY_ = rawY_(1:(totTime*sFreq));

        aFrawX_ = abs(fft(rawX_)/length(rawX_));
        aFrawY_ = abs(fft(rawY_)/length(rawY_));

        FAXIS = (1/totTime)*(0:(length(aFrawX_)-1));
    end
    figure;
    hold on; 
    plot(FAXIS,aFrawX_,'-r'); 
    axis square; 
    grid on
    axis([0 5 ylim]);
    title('X FFT Analysis');
    xlabel('Frequency Component (Hz)');
    ylabel('Amplitude');

    figure;
    hold on; 
    plot(FAXIS,aFrawY_,'-r'); 
    axis square; 
    grid on
    axis([0 5 ylim]);
    title('Y FFT Analysis')
    xlabel('Frequency Component (Hz)');
    ylabel('Amplitude');
end