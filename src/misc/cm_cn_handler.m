% Defines the class to calculate the Cp variable

classdef cm_cn_handler
    properties
        cm; cn; m; n;
    end
    methods
    function obj = cm_cn_handler(m,n) % Constructor
        obj.m = m; obj.n = n;
        if ((m == 0) && (n == 0))
            obj.cm = 1 / sqrt(2);
            obj.cn = 1 / sqrt(2);
        elseif((m ~= 0) && (n == 0))
            obj.cm = 1;
            obj.cn = 1 / sqrt(2);
        elseif((m == 0) && (n ~= 0))
            obj.cm = 1 / sqrt(2);
            obj.cn = 1;
        else
            obj.cm = 1; 
            obj.cn = 1;
        end
    end
    end
end