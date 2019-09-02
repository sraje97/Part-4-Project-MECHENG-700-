function [horDist, verDist] = CalibrationDistance(calMSD)
% Computes the mm per pixel distances in the fixation point test.
% Uses calibration points to get vertical and horizontal distances.
    
    % Vertical (Y pos) distance between calibration point 1 and 2 (px)
    verDist = calMSD(1,1,2) - calMSD(2,1,2);
    % Horizontal (X pos) distance between calibration point 1 and 4 (px)
    horDist = calMSD(1,1,1) - calMSD(4,1,1);
    
    % 237mm horizontal and 195mm vertical
    verDist = 195/verDist;
    horDist = 237/horDist;
end

