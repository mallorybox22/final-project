close all; clear; clc;

dirlist = dir('ISIC*.jpg');
vec = [];

for ii = 1:45
    
%Read folder and run script on all pictures
img = imread(dirlist(ii).name);

%Find how close the mole shape is to a circle
Ifinal = perimeterdetection(img);
stat = regionprops(Ifinal, 'circularity');
circularity = min(cell2mat(struct2cell(stat)));

%Find the color difference in the mole
mole = zeros(size(Ifinal));
mole(Ifinal == 1) = img(Ifinal == 1);
mole = mole(:);
high = max(mole);
low = min(mole(mole>0));
diff = high-low;

%Perform a count to determine the liklyhood of melanoma
count = 0;
    if true
         if circularity <= 0.5
         count = count + 1;
         end
         if diff > 100
         count = count + 1;
         end
    end
    
%Tabulate final data in a column
vec = [vec count];
vecfinal = vec';
end
excelfile = 'Melanoma Matrix.xlsx';
writematrix(vecfinal,excelfile,'Sheet',1,'Range','D2')