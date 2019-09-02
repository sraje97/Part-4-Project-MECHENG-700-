function [calMSD, dataMSD] = MeanSD(cal, data)
% Computes the MEAN and STANDARD DEVIATION for the fixation test data.
% First computes the Mean and SD for the 4 Calibration points
% Then computese the Mean and SD for the 9 Fixation points

    calMSD = zeros(4,2,2);
    dataMSD = zeros(9,2,2);

    for i = 1:4
        % Mean and SD of calibration points X position
        calMSD(i,1,1) = mean(cal(i,:,1));
        calMSD(i,2,1) = std(cal(i,:,1));
        
        % Mean and SD of calibration points Y position
        calMSD(i,1,2) = mean(cal(i,:,2));
        calMSD(i,2,2) = std(cal(i,:,2));
    end
    
    for i = 1:9
        % Mean and SD of fixation points X position
        dataMSD(i,1,1) = mean(data(i,:,1));
        dataMSD(i,2,1) = std(data(i,:,1));

        % Mean and SD of fixation points Y position
        dataMSD(i,1,2) = mean(data(i,:,2));
        dataMSD(i,2,2) = std(data(i,:,2));
    end
end

