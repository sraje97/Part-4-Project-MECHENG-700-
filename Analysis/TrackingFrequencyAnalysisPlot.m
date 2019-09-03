function [gain, phase] = TrackingFrequencyAnalysisPlot(cal,data)
    [amp_HV,phase_HV,h_cal_amp,v_cal_amp] = TrackingFrequencyAnalysis(cal,data);
    time = linspace(0,length(data)/1024,length(data));

    gain(1,1) = amp_HV(1,2) / h_cal_amp;
    phase(1,1) = phase_HV(1,2);

    gain(1,2) = amp_HV(2,2) / h_cal_amp;
    phase(1,2) = phase_HV(2,2);

    gain(2,1) = amp_HV(3,2) / v_cal_amp;
    phase(2,1) = phase_HV(3,2);

    gain(2,2) = amp_HV(4,2) / v_cal_amp;
    phase(2,2) = phase_HV(4,2);

    % Horizontal Blue
    figure; hold on; axis square
    plot(time,-h_cal_amp * cos(2*pi*0.12*time)) % <-- CHECK CALIBRATION DOTS FOR AMP HERE
    plot(time,data(1,:,1))
    plot(time,amp_HV(1,2) * cos(2*pi*0.12*time + phase_HV(1,2)))
    xlabel('Time (s)')
    ylabel('Position (au)')
    legend('Stimulus (Calibrated)','Raw Tracking','Tracking FFT''d')
    title('Horizontal Tracking Data - Blue Stimulus (Right Eye)')

    % Horizontal Red
    figure; hold on; axis square
    plot(time,-h_cal_amp * cos(2*pi*0.12*time)) % <-- CHECK CALIBRATION DOTS FOR AMP HERE
    plot(time,data(2,:,1))
    plot(time,amp_HV(2,2) * cos(2*pi*0.12*time + phase_HV(2,2)))
    xlabel('Time (s)')
    ylabel('Position (au)')
    legend('Stimulus (Calibrated)','Raw Tracking','Tracking FFT''d')
    title('Horizontal Tracking Data - Red Stimulus (Left Eye)')

    % Vertical Blue
    figure; hold on; axis square
    plot(time,v_cal_amp * cos(2*pi*0.12*time)) % <-- CHECK CALIBRATION DOTS FOR AMP HERE
    plot(time,data(3,:,2))
    plot(time,amp_HV(3,2) * cos(2*pi*0.12*time + phase_HV(3,2)))
    xlabel('Time (s)')
    ylabel('Position (au)')
    legend('Stimulus (Calibrated)','Raw Tracking','Tracking FFT''d')
    title('Vertical Tracking Data - Blue Stimulus (Right Eye)')

    % Vertical Blue
    figure; hold on; axis square
    plot(time,v_cal_amp * cos(2*pi*0.12*time)) % <-- CHECK CALIBRATION DOTS FOR AMP HERE
    plot(time,data(4,:,2))
    plot(time,amp_HV(4,2) * cos(2*pi*0.12*time + phase_HV(4,2)))
    xlabel('Time (s)')
    ylabel('Position (au)')
    legend('Stimulus (Calibrated)','Raw Tracking','Tracking FFT''d')
    title('Vertical Tracking Data - Red Stimulus (Left Eye)')

end