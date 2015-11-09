function plotNet(JsonFileName)
% this function plot a graph for a network
% written by Shuran Song

cd(fileparts(which(mfilename)));
addpath ../../tools/tensorIO_matlab/

if ~exist('JsonFileName','var')
    JsonFileName = '../../examples/mnist/siamese.json';
end

net = loadjson(JsonFileName);

nameofResponse = {};
nameofLayer = {};
for i =1:length(net.layers)
    nameofLayer{end+1} = [net.layers{i}.type ' : ' net.layers{i}.name];
    if isfield(net.layers{i},'out')
        out = net.layers{i}.out;
        for j =1:length(out)
            nameofResponse(end+1) = out(j);
        end
    end
end
nameofResponse = unique(nameofResponse,'stable');
if length(nameofLayer)>length(unique(nameofLayer,'stable'))
   printf('error : layer name not unique\n');
end
numofNode = length(nameofLayer)+length(nameofResponse);
names = [nameofLayer,nameofResponse];

cm = zeros(numofNode,numofNode);
for i =1:length(net.layers)
    [~,indi] = ismember([net.layers{i}.type ' : ' net.layers{i}.name],names);
    if isfield(net.layers{i},'out')
       out = net.layers{i}.out;
       for j =1:length(out)
           [~,indj] = ismember(out{j},names);
           cm(indi,indj) =1;
       end
    end
    
    if isfield(net.layers{i},'in')
       in = net.layers{i}.in;
       for j =1:length(in)
           [~,indj] = ismember(in{j},names);
           cm(indj,indi) =1;
       end
    end
end
LayerType = {'Pooling','Convolution','InnerProduct','Loss','Dropout'   ,'Activation','Softmax', 'ElementWise',  'LRN'};
NodeColor = {[.6 .8 1],[1 .7 0.3]   ,[0.5 1 0.],[1 .7 0.7],[.7 0.4 0.9],[.5 0.5 1],[1 0.2 1], [.0 0.8 1], [.9 0 0]}; 
bg = biograph(cm,names,'LayoutType','hierarchical','ShowTextInNodes','id');
for i =1:length(bg.nodes)
    bg.nodes(i).FontSize =20;
    if i <= length(nameofLayer)
        [~,lid]=ismember(net.layers{i}.type,LayerType);
        if lid > 0
           bg.nodes(i).color = NodeColor{lid}; 
        end
        % bg.nodes(i).Description = savejson('',net.layers{i});
    else
        bg.nodes(i).Shape = 'ellipse'; 
        bg.nodes(i).color = [0.8 0.8 0.8];
    end
end
gObj = view(bg);
