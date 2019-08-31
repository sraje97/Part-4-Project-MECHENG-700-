function [cal, data] = SegmentTrackingData(rawX, rawY, trig_0)
    fs = 2048/2;

%% Calibration Points Horizontal
  
    calSegStart = 1024/2;
    calSegEnd = 3328/2;
    calPointDuration = 4096/2;
    
    trigIndices = find(trig_0(1000/2:end) == 1) + 1000/2;
    calIndex = trigIndices(1) + fs;
    % Add 2048 to discard the 1st one second from White Square
    disp(calIndex);
    
    cal = zeros(4,calSegEnd-calSegStart+1,2);
    for i = 1:2
        cal(i,:,1) = rawX((calIndex+(i-1)*calPointDuration)+calSegStart : (calIndex+(i-1)*calPointDuration)+calSegEnd);
        cal(i,:,2) = rawY((calIndex+(i-1)*calPointDuration)+calSegStart : (calIndex+(i-1)*calPointDuration)+calSegEnd);        
    end
    
    calEndIndex = (calIndex+2*calPointDuration);
    
    %% Tracking Test Horizontal
    
    trackDuration = floor(2*fs*(1/.12)); % Two cycles
    trackSegStart = 0;
    trackSegEnd = trackDuration - 512;
    breakTime = fs*5;
    
    data = zeros(4,trackSegEnd-trackSegStart+1,2);
    
    for i = 1:2
        if i == 1
            find_StartPoint = calEndIndex;
            trackIndices = find(trig_0(find_StartPoint : end) == 1) + find_StartPoint;
        else
            find_StartPoint = trackStartIndex + trackDuration + breakTime;
            trackIndices = find(trig_0(find_StartPoint : find_StartPoint+trackDuration) == 1) + find_StartPoint;
        end
        trackStartIndex = trackIndices(1);
        
        data(i,:,1) = rawX(trackStartIndex+trackSegStart : trackStartIndex+trackSegEnd);
        data(i,:,2) = rawY(trackStartIndex+trackSegStart : trackStartIndex+trackSegEnd);
    end
    
    trackEndIndex = trackStartIndex + trackDuration + breakTime;
    
%% Calibration Points Vertical

%     calIndex = trackEndIndex; % KEEP FOR FINAL!
    calIndex = 110338/2; % USE FOR MICHAEL's TEST

    trigIndices = find(trig_0(calIndex:end) == 1) + calIndex;
    calIndex = trigIndices(1) + fs;
    % Add 2048 to discard the 1st one second from White Square
    disp(calIndex);
    
    for i = 1:2
        cal(i+2,:,1) = rawX((calIndex+(i-1)*calPointDuration)+calSegStart : (calIndex+(i-1)*calPointDuration)+calSegEnd);
        cal(i+2,:,2) = rawY((calIndex+(i-1)*calPointDuration)+calSegStart : (calIndex+(i-1)*calPointDuration)+calSegEnd);        
    end
    
    % DEBUG: Plot calibration points
    figure; hold on;
    for iDot = 1:4
        scatter(cal(iDot,:,1),cal(iDot,:,2),10,'black');
    end
    axis square;
    
    calEndIndex = (calIndex+2*calPointDuration);
    
%% Tracking Test Vertical
    
    for i = 1:2
        if i == 1
            find_StartPoint = calEndIndex;
            trackIndices = find(trig_0(find_StartPoint : end) == 1) + find_StartPoint;
        else
            find_StartPoint = trackStartIndex + trackDuration + breakTime;
            trackIndices = find(trig_0(find_StartPoint : find_StartPoint+trackDuration) == 1) + find_StartPoint;
        end
        trackStartIndex = trackIndices(1);
        
        if i == 1
            data(i+2,:,1) = rawX(trackStartIndex+trackSegStart : trackStartIndex+trackSegEnd);
            data(i+2,:,2) = rawY(trackStartIndex+trackSegStart : trackStartIndex+trackSegEnd);
        else
            data(i+2,:,1) = rawX(trackStartIndex+trackSegStart : trackStartIndex+trackSegEnd);
            data(i+2,:,2) = rawY(trackStartIndex+trackSegStart : trackStartIndex+trackSegEnd);
%             data(i+2,:,1) = rawX(trackStartIndex+trackSegStart : end);
%             data(i+2,:,2) = rawY(trackStartIndex+trackSegStart : end);
        end
    end
    
    % DEBUG: Plot Horizontal Tracking data
%     figure; hold on;
    for iDot = 1:4
        scatter(data(iDot,:,1),data(iDot,:,2),10);
    end
    axis square;
end

