% Refer to Save.json to configure what variable to save
% Save
%   VariableName: Name of the variable in the workspace
%   Path: Path to save to.  Can be full path or path start from this project folder
%   Type: Constant, Matrix, or Image.  Must specify or variable will not be saved
if ~exist('Outputs', 'dir')
        mkdir('Outputs')
end 
savevar = jsondecode(fileread('Project.json'));
for i = 1:size(savevar.Save,1)
    if savevar.Save(i).Type == "Constant"
        save(savevar.Save(i).Path,savevar.Save(i).VariableName,'-ascii')
    elseif savevar.Save(i).Type == "Matrix"
        try
            file = fopen(savevar.Save(i).Path,'wt');
            eval(['val = ',savevar.Save(i).VariableName,';']);
            for i = 1:size(val,1)
                fprintf(file,'%g,',val(i,:));
                fprintf(file,'\n');
            end
            fclose(file);
        catch exception
            throw(exception)
        end
    elseif savevar.Save(i).Type == "Image"
        eval(['val = ',savevar.Save(i).VariableName,';']);
        imwrite(val,savevar.Save(i).Path);
    else
        fprintf('%s not saved into file, please check Save.json if Type is specified.', savevar.Save(i).VariableName); 
    end
end