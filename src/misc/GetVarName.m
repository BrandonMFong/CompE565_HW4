function out = GetVarName(var)
    varstring = inputname(1);
    out = replace(varstring, '_', '\_');
end