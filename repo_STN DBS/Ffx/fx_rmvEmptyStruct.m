function [data] = fx_rmvEmptyStruct(data)

for i = size(data,2):-1:1
    if isempty(data(i).no);
        data(i) = [];
    else
        
    end
end
end
 %D= rmfield(data(3).no, fields(structfun(@isempty, data(3).no)))