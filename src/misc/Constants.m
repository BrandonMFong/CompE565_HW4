% Defines the class that holds all constants

classdef Constants
    properties
        Y = 1;
        Cb = 2;
        Cr = 3;
        MacroBSize = 16; % Macroblock
        SWSize = 32; % Search Window

        % Searchwindow check variables
        TopLeft = 1; 
        BottomLeft = 2; 
        TopRight = 3; 
        BottomRight = 4; 
        Left = 5; 
        Right = 6; 
        Top = 7; 
        Bottom = 8; 

        DimNoMatch = 'Dimensions do not match!\n';
    end
end