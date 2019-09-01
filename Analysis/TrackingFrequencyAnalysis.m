function [amplitude,phase] = TrackingFrequencyAnalysis(data)
    Fs = 2048;

    trajectory = data(1,:,1);
    trajectory = trajectory - mean(trajectory);
    n_FFT = length(trajectory);
    
    trajectory_FFT = fft(trajectory)/n_FFT;
    f_axis = ((0:1/n_FFT:1-1/n_FFT)*Fs).';
    
    mag_traj = abs(trajectory_FFT);
    phase_traj = unwrap(angle(trajectory_FFT));
    amplitude = 2*mag_traj(2:end);
    phase = phase_traj(2:end);
    
    figure;
    ax(1) = subplot(2,1,1);
    plot(f_axis(2:end),amplitude);
%     axis([0 1 ylim]);
    ax(2) = subplot(2,1,2);
    plot(f_axis(2:end),phase);
%     axis([0 1 ylim]);
    linkaxes(ax,'x');
end