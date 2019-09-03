function [amplitude,phase,h_cal_amp,v_cal_amp] = TrackingFrequencyAnalysis(cal,data)
    
    h_cal_amp = abs(mean(cal(1,:,1)) - mean(cal(2,:,1))) / 2;
    v_cal_amp = abs(mean(cal(3,:,2)) - mean(cal(4,:,2))) / 2;
    
    amplitude = zeros(4,length(data)-1);
    phase = zeros(4,length(data)-1);
    
    for i = 1:4
        if i < 3
            trajectory = data(i,:,1);
            trajectory = trajectory - mean(trajectory);
            n_FFT = length(trajectory);
            trajectory_FFT = fft(trajectory)/n_FFT;

            mag_traj = abs(trajectory_FFT);
            phase_traj = unwrap(angle(trajectory_FFT));
            amplitude(i,:) = 2*mag_traj(2:end);
            phase(i,:) = phase_traj(2:end);
        else
            trajectory = data(i,:,2);
            trajectory = trajectory - mean(trajectory);
            n_FFT = length(trajectory);
            trajectory_FFT = fft(trajectory)/n_FFT;

            mag_traj = abs(trajectory_FFT);
            phase_traj = unwrap(angle(trajectory_FFT));
            amplitude(i,:) = 2*mag_traj(2:end);
            phase(i,:) = phase_traj(2:end);
        end
    end

    %{
    figure;
    ax(1) = subplot(2,1,1);
    plot(f_axis(2:end),amplitude);
%     axis([0 1 ylim]);
    ax(2) = subplot(2,1,2);
    plot(f_axis(2:end),phase);
%     axis([0 1 ylim]);
    linkaxes(ax,'x');
    %}
end