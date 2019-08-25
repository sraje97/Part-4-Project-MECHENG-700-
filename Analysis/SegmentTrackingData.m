function [cal, data_Hor] = SegmentTrackingData(rawX, rawY, trig_0)
    %% Calibration Points
    fs = 2048;
    
    calSegStart = 800;
    calSegEnd = 3328;
    calPointDuration = 4096;
    
    trigIndices = find(trig_0 == 1);
%     calIndex = trigIndices(1) + 2048; 
    calIndex = trigIndices(1);
    % Add 2048 to ignore the extra 1 sec of white dot before calibration actually starts
    
    cal = zeros(2,calSegEnd-calSegStart+1,2);
    for i = 1:2
        cal(i,:,1) = rawX((calIndex+(i-1)*calPointDuration)+calSegStart : (calIndex+(i-1)*calPointDuration)+calSegEnd);
        cal(i,:,2) = rawY((calIndex+(i-1)*calPointDuration)+calSegStart : (calIndex+(i-1)*calPointDuration)+calSegEnd);        
    end
    
    calEndIndex = (calIndex+2*calPointDuration);
    
    % DEBUG: Plot calibration points
    figure; hold on;
    for iDot = 1:2
        scatter(cal(iDot,:,1),cal(iDot,:,2))
    end
    
    %% Tracking Test   
    trackDuration = floor(2*fs*(1/.12)); % Two cycles
    trackSegStart = 0;
    trackSegEnd = trackDuration - 512;
    breakTime = fs*5;
    
    data_Hor = zeros(2,trackSegEnd-trackSegStart+1,2);
    
    for i = 1:2
        if i == 1
            find_StartPoint = calEndIndex;
            trackIndices = find(trig_0(find_StartPoint : end) == 1) + find_StartPoint;
        else
            find_StartPoint = trackStartIndex + trackDuration + breakTime;
            trackIndices = find(trig_0(find_StartPoint : find_StartPoint+trackDuration) == 1) + find_StartPoint;
        end
        trackStartIndex = trackIndices(1);
        
        data_Hor(i,:,1) = rawX(trackStartIndex+trackSegStart : trackStartIndex+trackSegEnd);
        data_Hor(i,:,2) = rawY(trackStartIndex+trackSegStart : trackStartIndex+trackSegEnd);
    end
    
    % DEBUG: Plot Horizontal Tracking data
    figure; hold on;
    for iDot = 1:2
        scatter(data_Hor(iDot,:,1),data_Hor(iDot,:,2))
    end
    
end

