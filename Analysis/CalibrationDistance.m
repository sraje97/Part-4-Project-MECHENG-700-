function [resX, resY] = CalibrationDistance(calMSD)
% Computes the mm per pixel distances in the fixation point test.
% Uses calibration points to get vertical and horizontal distances.
    
    % Vertical (Y pos) distance between calibration point 1 and 2 (px)
    verDistR = calMSD(1,1,2) - calMSD(2,1,2);
    verDistL = calMSD(4,1,2) - calMSD(3,1,2);
    verDist = abs(verDistR + verDistL) / 2;
    
    % Horizontal (X pos) distance between calibration point 1 and 4 (px)
    horDistT = calMSD(1,1,1) - calMSD(4,1,1);
    horDistB = calMSD(2,1,1) - calMSD(3,1,1);
    horDist = abs(horDistT + horDistB) / 2;
    
    % 237mm horizontal and 195mm vertical gives mm/px value
    resY = verDist/195;
    resX = horDist/195;
end

