function [imgResize, centers, radii] = detect_coins(origPic)
%This function takes an image, formats and filters it, and detects any circles (coins) in the image
% Return parameters: 
%     imgResize - the resized image
%     (not currently returned) circles - a graph of the circles
%     centers - a table of circle centers
%     radii - a table of circle radii

    % resize large pics (makes largest size 1000)
    [r, c, nColors] = size(origPic);
    dec = 1000 / max(r,c);
    
    imgResize = imresize(origPic, dec);
    
    %get bw filter
    imgFiltered = im2double(rgb2gray(imgResize));    
    
    %find circles
    % , metric (below var)
    [centers, radii] = imfindcircles(imgFiltered, [30 90], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');

%     circles = viscircles(centers, radii);

    

    %Show circles on original image
    imgTmp = imshow(imgResize);
    detected = viscircles(centers, radii);
    drawnow;
    
    saveas(imgTmp, 'detected_coins_tmp.jpg');
    close;
 
end