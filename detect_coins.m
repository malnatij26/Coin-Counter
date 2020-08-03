function [circlePic, circles, centers, radii] = detect_coins(origPic)
    % resize large pics (makes largest size 1000)
    [r, c, nColors] = size(origPic);
    dec = 1000 / max(r,c);
    
    imgResize = imresize(origPic, dec);
    
    %get bw filter
    imgFiltered = im2double(rgb2gray(imgResize));    
    
    %find circles
    % , metric (below var)
    [centers, radii] = imfindcircles(imgFiltered, [30 90], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');
   
%     circlePic = imgResize;
    circles = viscircles(centers, radii);
    
    circlePic = imgResize;
%     set(circlePic,'AlphaData',double(circles));
    
end