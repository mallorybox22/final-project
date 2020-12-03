function Ifinal = perimeterdetection(img)
[R,C] = size(img);
I = img(:,:,2);
mask = logical(zeros(size(I)));
mask(I<115) = 1;
se = strel('diamond',9);
mask = imclose(mask,se);
mask = imopen(mask,se);
margin = 50; 
croppedImage = imcrop(mask, [margin, margin, C - 2 * margin, R - 2 * margin]);
mask = imclearborder(croppedImage);
Ifinal = logical(padarray(mask, margin));
Ifinal = imclose(Ifinal,se);
Ifinal = imfill(Ifinal,'holes');
end
