% Calculates motion vector 

classdef MotionVector
    properties
        XCoordinate1; % Displacement start
        XCoordinate2; % Displacement end
        YCoordinate1; % Displacement start
        YCoordinate2; % Displacement end
    end
    methods
        % Uses the macroblock from the current frame and scans through the search window 
        % Declaring an object that holds motion vector data
        % Idea is to make an array of this object
        % Array size = (Frame.Column / MacroblockSize) * (Frame.Row / MacroblockSize)
        function obj = MotionVector(x1,x2,y1,y2) % init
            obj.XCoordinate1 = x1;
            obj.XCoordinate2 = x2;
            obj.YCoordinate1 = y1;
            obj.YCoordinate2 = y2;
        end
end