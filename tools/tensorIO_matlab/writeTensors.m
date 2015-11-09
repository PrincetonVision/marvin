function writeTensors(filename, tensors)

% use this function to write .tensor files (features or weights) into Matlab

fin = fopen(filename, 'wb');

for i=1:length(tensors)

    switch tensors(i).type
        case 'half'
            type_id = 0;
            precision = 'uint16';
        case 'float'
            type_id = 1;
            precision = 'single';
        case 'double'
            type_id = 2;
            precision = 'double';
        case 'uint8'
            type_id = 3;
            precision = 'uint8';
        case 'uint16'
            type_id = 4;
            precision = 'uint16';
        case 'uint32'
            type_id = 5;
            precision = 'uint32';
        case 'uint64'
            type_id = 6;
            precision = 'uint64';
        case 'int8'
            type_id = 7;
            precision = 'int8';
        case 'int16'
            type_id = 8;
            precision = 'int16';
        case 'int32'
            type_id = 9;
            precision = 'int32';
        case 'int64'
            type_id = 10;
            precision = 'int64';
        case 'char'
            type_id = 11;
            precision = 'char';
        case 'bool'
            type_id = 12;
            precision = 'uint8';
        otherwise
            throw(MException('writeTensor:UnsupportedFormat','Unsupported Format'))
    end
    
    if strcmp(tensors(i).type,'half')
        values = float2half(tensors(i).value);
        tensors(i).value = values;
    end
    
    fwrite(fin, uint8(type_id), 'uint8');
    fwrite(fin, uint32(tensors(i).sizeof), 'uint32');    
    
    str = tensors(i).name;
    fwrite(fin, int32(length(str)), 'int32');
    fwrite(fin, str, 'char*1');
    
    dim = size(tensors(i).value);
    

    
    % matlab is column first, marvin/c++ is row first
    if length(dim)>1
        pvec = 1:length(dim);
        pvec([1 2]) = pvec([2 1]);
        tensors(i).value = permute(tensors(i).value, pvec);    
        dim = dim(pvec);
    end

    
    dim = dim(end:-1:1);
    while tensors(i).dim > numel(dim)
        dim(end+1) = 1;
    end    
    
    
    fwrite(fin, int32(length(dim)), 'int32');
    for d=1:length(dim)
        fwrite(fin, int32(dim(d)), 'int32');
    end
    fwrite(fin, tensors(i).value, precision);
end

fclose(fin);
