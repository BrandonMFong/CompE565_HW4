% Defines the class that holds all constants

classdef Constants
    properties
        Y = 1
        Cb = 2;
        Cr = 3;
        SubCb = 1;
        SubCr = 2;
        RefNum;
        BlockSize;
        MacroBSize; % Macroblock
        SWSize; % Search Window
        GOPSize;
        SliceSize;

        % Matrix
        QuantizationMatrix;

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
    methods
        function obj = Constants() % Constructor
            var = jsondecode(fileread('Project.json'));
            obj.RefNum = var.ConstantDefinitions.ReferenceFrameNumber;
            obj.BlockSize = var.ConstantDefinitions.BlockSize;
            obj.MacroBSize = var.ConstantDefinitions.MacroBlockSize;
            obj.SWSize = var.ConstantDefinitions.SearchWindowSize;
            obj.GOPSize = var.ConstantDefinitions.GOPSize;
            obj.SliceSize = var.ConstantDefinitions.SliceSize;
            obj.QuantizationMatrix = csvread(var.ConstantDefinitions.MatrixFile);
        end
    end
end