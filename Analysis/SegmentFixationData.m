function [cal, data] = SegmentFixationData(rawX, rawY, trig_0)
    fs = 2048;
    calSegStart = 800;
    calSegEnd = 3328;
    calPointDuration = 4096;
    
    trigIndices = find(trig_0 == 1);
    calIndex = trigIndices(1);

    cal = zeros(4,calSegEnd-calSegStart+1,2);
    for i = 1:4
        cal(i,:,1) = rawX((calIndex+(i-1)*calPointDuration)+calSegStart:(calIndex+(i-1)*calPointDuration)+calSegEnd);
        cal(i,:,2) = rawY((calIndex+(i-1)*calPointDuration)+calSegStart:(calIndex+(i-1)*calPointDuration)+calSegEnd);        
    end
    
    % DEBUG: Plot calibration points
    figure; hold on;
    for iDot = 1:4
        scatter(cal(iDot,:,1),cal(iDot,:,2))
    end
    
    calEndIndex = (calIndex+3*calPointDuration)+calSegEnd + 8191;    
    fixDuration = fs*3;
    fixSegStart = 768;
    fixSegEnd = fixDuration - 512;

    data = zeros(9,fixSegEnd-fixSegStart+1,2);

    for i = 1:9
        if i == 1
            find_StartPoint = (i-1)*fixDuration + calEndIndex;
            fixIndices = find(trig_0(find_StartPoint : end) == 1) + find_StartPoint;
        else
            find_StartPoint = fixDuration + fixStartIndex;
            fixIndices = find(trig_0(find_StartPoint : find_StartPoint+5000) == 1) + find_StartPoint;
        end
        fixStartIndex = fixIndices(1);
        
        if i == 9
            data9(1,:,1) = rawX(fixStartIndex+fixSegStart : fixStartIndex+5000);
            data9(1,:,2) = rawY(fixStartIndex+fixSegStart : fixStartIndex+5000);
            padding = length(data(1,:,1)) - length(data9(1,:,1));
            data9 = padarray(data9,[0,padding],'post');
        else
            data(i,:,1) = rawX(fixStartIndex+fixSegStart : fixStartIndex+fixSegEnd);
            data(i,:,2) = rawY(fixStartIndex+fixSegStart : fixStartIndex+fixSegEnd);
        end
    end
    
    data = [data ; data9];
    
    % DEBUG: Plot Fixation points
    figure; hold on;
    for iDot = 1:9
        scatter(data(iDot,:,1),data(iDot,:,2))
    end
end