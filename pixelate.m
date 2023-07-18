function newVideoExport = pixelate(fileName, filetype, newPix)

if filetype == 'video'

inputVid = VideoReader(fileName);
numFrames = inputVid.numFrames; 
frameRate = inputVid.FrameRate;

newVideoExport = VideoWriter('pixelVideo.avi','Motion JPEG AVI');
open(newVideoExport);

for frame = 1:numFrames
    input = read(inputVid,frame);


%input = imread("img.jpg");
sizeArray = size(input);
r = sizeArray(1);
c = sizeArray(2);
clr = sizeArray(3);
gcdRC = gcd(r,c);
lcmRC = lcm(r,c);

divr = divisors(r);
divc= divisors(c);
cmndiv = intersect(divr,divc);

red = input(:,:,1);
green = input(:,:,2);
blue = input(:,:,3);

fullOut = [];
fullOut(:,:,1) = zeros(r,c);
fullOut(:,:,2) = zeros(r,c);
fullOut(:,:,3) = zeros(r,c);

%bigOutput = [];

%for z = [1 2 3 6 27 72 180]

%newPix = intersectAB(z);
%newPix = z;
%newPix = 12;
rSteps = r/newPix;
cSteps = c/newPix;

cmpOut = [];
cmpOut(:,:,1) = zeros(rSteps,cSteps);
cmpOut(:,:,2) = zeros(rSteps,cSteps);
cmpOut(:,:,3) = zeros(rSteps,cSteps);

for color=1:3

for x=1:rSteps
   for y=1:cSteps
       floatColor = 0;
       pixelCount = 0;
       
       for n=1:newPix
           for m=1:newPix
               floatColor = floatColor + double(input(n+(x-1)*newPix,m+(y-1)*newPix,color));
               pixelCount = pixelCount + 1;
           end
       end
       cmpOut(x,y,color) = uint8(floatColor/pixelCount);
        for a=1:newPix
            for b=1:newPix
                fullOut((x-1)*newPix+a,(y-1)*newPix+b,color) = uint8(floatColor/pixelCount);
            end
        end
   end
  
end
end

%bigOutput = cat(2,bigOutput,imresize(output,newPix));

%end

%[X_dither,map] = rgb2ind(uint8(output),10,'dither');
%imshow(X_dither,map)

newImage = (uint8(fullOut));
%imresize(export,newPix,"nearest",Dither=false);
[newImage,map] = rgb2ind(newImage,50,'nodither');


%imshow(X_dither,map)

newFrame = im2frame(newImage,map);
writeVideo(newVideoExport,newFrame);

end

close(newVideoExport);

elseif filetype == 'image'
input = imread(fileName);
sizeArray = size(input);
r = sizeArray(1);
c = sizeArray(2);
clr = sizeArray(3);
gcdRC = gcd(r,c);
lcmRC = lcm(r,c);

divr = divisors(r);
divc= divisors(c);
cmndiv = intersect(divr,divc);

red = input(:,:,1);
green = input(:,:,2);
blue = input(:,:,3);

fullOut = [];
fullOut(:,:,1) = zeros(r,c);
fullOut(:,:,2) = zeros(r,c);
fullOut(:,:,3) = zeros(r,c);

%bigOutput = [];

%for z = [1 2 3 6 27 72 180]

%newPix = intersectAB(z);
%newPix = z;
%newPix = 12;
rSteps = r/newPix;
cSteps = c/newPix;

cmpOut = [];
cmpOut(:,:,1) = zeros(rSteps,cSteps);
cmpOut(:,:,2) = zeros(rSteps,cSteps);
cmpOut(:,:,3) = zeros(rSteps,cSteps);

for color=1:3

for x=1:rSteps
   for y=1:cSteps
       floatColor = 0;
       pixelCount = 0;
       
       for n=1:newPix
           for m=1:newPix
               floatColor = floatColor + double(input(n+(x-1)*newPix,m+(y-1)*newPix,color));
               pixelCount = pixelCount + 1;
           end
       end
       cmpOut(x,y,color) = uint8(floatColor/pixelCount);
        for a=1:newPix
            for b=1:newPix
                fullOut((x-1)*newPix+a,(y-1)*newPix+b,color) = uint8(floatColor/pixelCount);
            end
        end
   end
  
end
end

%bigOutput = cat(2,bigOutput,imresize(output,newPix));

%end

%[X_dither,map] = rgb2ind(uint8(output),10,'dither');
%imshow(X_dither,map)

export = (uint8(fullOut));
%imresize(export,newPix,"nearest",Dither=false);
%[export,map] = rgb2ind(export,50,'nodither');
imshow(export);

end

end

%implay('pixelVideo.avi')
%imshow(uint8(bigOutput))
