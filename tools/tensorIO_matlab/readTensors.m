function tensors = readTensors(filename, toPermute)

if ~exist('toPermute','var')
    toPermute = true;
end

% use this function to load .tensor files (features or weights) into Matlab

count = 0;

fp = fopen(filename, 'rb');

while ~feof(fp)
	count = count + 1;
    
    type_uint8 = fread(fp,1,'uint8');
	if feof(fp)
		break;
    end
    
    switch type_uint8
        case 0
			type_str = 'half';
            precision = 'uint16=>uint16';
        case 1
			type_str = 'float';
            precision = 'single=>single';
        case 2
			type_str = 'double';
            precision = 'double=>double';
        case 3
			type_str = 'uint8';
            precision = 'uint8=>uint8';
        case 4
			type_str = 'uint16';
            precision = 'uint16=>uint16';
        case 5
			type_str = 'uint32';
            precision = 'uint32=>uint32';
        case 6
			type_str = 'uint64';
            precision = 'uint64=>uint64';
        case 7
			type_str = 'int8';
            precision = 'int8=>int8';
        case 8
			type_str = 'int16';
            precision = 'int16=>int16';
        case 9
			type_str = 'int32';
            precision = 'int32=>int32';
        case 10
			type_str = 'int64';
            precision = 'int64=>int64';
        case 11
			type_str = 'char';
            precision = 'char=>char';
        case 12
			type_str = 'bool';
            precision = 'uint8=>uint8';
        otherwise
            throw(MException('writeTensor:UnsupportedFormat','Unsupported Format'))
    end
    
    size_length = fread(fp,1,'uint32');
    
	lenName=fread(fp,1,'int32');
	if lenName>0
		str=char(fread(fp,lenName,'char*1')');
		disp(str);
	else
		str='';
	end
	nbDims=fread(fp,1,'int32');
	if nbDims==0 % maybe zero paddings at the end of a feature file
		break;
	end
	dim = fread(fp,nbDims,'int32');
	dim = dim(:)';
	
    values = fread(fp,prod(dim),precision);
    
    if strcmp(type_str,'half')
        deltaCount = 1024*8;
        N = numel(values);
        if N>=deltaCount
            values2 = single(zeros(1,N));
            for s=1:deltaCount:N
                e = min(s+deltaCount-1,N);
                values2(s:e) = half2float(values(s:e));
            end
            values = values2;
        else
            values2 = half2float(values);
            values = values2;
        end
    end
    
	if nbDims>1
		values = reshape(values,dim(end:-1:1));
    end
    
    if toPermute
        % matlab is column first, marvin/c++ is row first
        if nbDims>1
            pvec = 1:length(dim);
            pvec([1 2]) = pvec([2 1]);
            values = permute(values, pvec);
            %dim(1:2) = dim(2:1); % actually useless here since we didn't save it
        end
    end

    tensors(count).dim = nbDims;
	tensors(count).name = str;
	tensors(count).value = values;
    
    tensors(count).type = type_str;
    tensors(count).sizeof = size_length;
end

fclose(fp);

