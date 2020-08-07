%function single_coin(picture)

function single_coin()
% %edgeThreshold = 0.2;
% %amount = 0.9;
% coins = imresize(imread("photos/all_p.jpg"),.5);
% figure; subplot(1,2,1); imshow(coins); title('Original');
% % bwCoins = im2double(rgb2gray(coins));
% % subplot(1,2,2); imshow(bwCoins); title('Grayscale image');
% % 
% %Find each coin in image using imfindcircles
% [centers, radii, metric] = imfindcircles(coins, [100 175], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');
% 
% subplot(1,2,2); imshow(coins);
% %Show circles on original image
% detected = viscircles(centers, radii);
% drawnow;

match_penny_color()

end


function match_penny(coins)
% 
% pennies =  localcontrast(imsharpen(rgb2gray(imresize(imread("photos/p1.jpg"),1))), edgeThreshold,amount );
% 
% coinPoints = detectSURFFeatures(coins);
% pennyPoints = detectSURFFeatures(pennies);
% 
% [coinFeatures, coinPoints] = extractFeatures(coins, coinPoints);
% [pennyFeatures, pennyPoints] = extractFeatures(pennies, pennyPoints);
% 
% coinPairs = matchFeatures(pennyFeatures, coinFeatures );
% 
% matchedCoinPoints = coinPoints(coinPairs(:, 2), :);
% matchedPennyPoints = pennyPoints(coinPairs(:, 1), :);
% 
% figure;
% showMatchedFeatures(coins, pennies, matchedCoinPoints, matchedPennyPoints, 'montage');
% 
% title('Putatively Matched Points (Including Outliers)');
% 
% 
% figure;
% imshow(pennies);
% title('300 Strongest Feature Points from penny Image');
% hold on;
% plot(selectStrongest(pennyPoints, 300));


pennies = imresize(imread("photos/all_p.jpg"),.5);
points1 = detectHarrisFeatures(coins);
points2 = detectHarrisFeatures(pennies);

%Extract the neighborhood features.
[features1,valid_points1] = extractFeatures(coins,points1);
[features2,valid_points2] = extractFeatures(pennies,points2);

%Match the features.
indexPairs = matchFeatures(features1,features2);

%Retrieve the locations of the corresponding points for each image.
matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

%Visualize the corresponding points. You can see the effect of translation between the two images despite several erroneous matches.
figure; showMatchedFeatures(coins,pennies,matchedPoints1,matchedPoints2);

end



function penny_color = get_penny_color()


pennies = imresize(imread("photos/all_p.jpg"),0.5);
[centers, radii, metric] = imfindcircles(pennies,  [100 175], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');
% disp(centers)
cmp = colormap(copper);
p = min(radii)*size(centers,1);
penny_color = zeros(p,3);
p = 1;
for x=1: min(radii)
for i = 1 : size(centers, 1)
   if int16(centers(i,2)) < 1500 && int16(centers(i,1)) < 1500
       
   RGB =  pennies( int16(centers(i,1)), int16(centers(i,2)), : );
   penny_color(p,1)= RGB(1);
   penny_color(p,2) = RGB(2);
   penny_color(p,3)  = RGB(3);
   p = p+1;
   
   RGB =  pennies( int16(centers(i,1))+x, int16(centers(i,2)), : );
  penny_color(p,1)= RGB(1);
  penny_color(p,2) = RGB(2);
  penny_color(p,3)  = RGB(3);
   p = p+1;
   RGB =  pennies( int16(centers(i,1)), int16(centers(i,2))+x, : );
     penny_color(p,1)= RGB(1);
     penny_color(p,2) = RGB(2);
     penny_color(p,3)  = RGB(3);
   p = p+1;
   RGB =  pennies( int16(centers(i,1))+x, int16(centers(i,2))+x, : );
     penny_color(p,1)= RGB(1) ;
     penny_color(p,2) = RGB(2) ;
     penny_color(p,3)  = RGB(3);
   p = p+1;
   RGB =  pennies( int16(centers(i,1))-x, int16(centers(i,2)), : );
     penny_color(p,1)= RGB(1);
     penny_color(p,2) = RGB(2);
     penny_color(p,3)  = RGB(3);
   p = p+1;
   RGB =  pennies( int16(centers(i,1)), int16(centers(i,2))-x, : );
     penny_color(p,1)= RGB(1);
     penny_color(p,2) = RGB(2);
     penny_color(p,3)  = RGB(3);
   p = p+1;
   RGB =  pennies( int16(centers(i,1))-x, int16(centers(i,2))-x, : );
     penny_color(p,1)= RGB(1);
     penny_color(p,2) = RGB(2) ;
     penny_color(p,3)  = RGB(3);
   p = p+1;
   RGB =  pennies( int16(centers(i,1))+x, int16(centers(i,2))-x, : );
   penny_color(p,1)= RGB(1);
   penny_color(p,2) = RGB(2) ;
   penny_color(p,3)  = RGB(3);
   p = p+1;
   RGB =  pennies( int16(centers(i,1))-x, int16(centers(i,2))+x, : );
%    penny_color = [penny_color, generateRGB(RGB)]
    penny_color(p,1)= RGB(1) ;
    penny_color(p,2) = RGB(2) ;
    penny_color(p,3)  = RGB(3);
   p = p+1;
   end
end
   
end


end

function  match_penny_color()


pennies = imresize(imread("photos/good_coin.jpg"),0.5);
[centers, radii, metric] = imfindcircles(pennies,  [70 175], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');

imshow(pennies);
%Show circles on original image
detected = viscircles(centers, radii);
drawnow;
%disp(centers)
cmp = get_penny_color();


for x=1: min(radii)
for i = 1 : size(centers, 1)
   if int16(centers(i,2)) < 1300 && int16(centers(i,1)) < 1300
   RGB =  pennies( int16(centers(i,1)), int16(centers(i,2)), : );
   for r = 1 : size(cmp)
        if cmp(r)*255 == RGB(1)          
%             disp(RGB(1)) 
%             disp(cmp(r)*255) 
%             disp(RGB(2)) 
%             disp(cmp(r,2)*255)
%             disp(cmp(r,3)*255)
            if RGB(2)== cmp(r,2)*255          
                disp("green")
                if RGB(3) == cmp(r,2)*255
                    disp(RGB)
                end
            end
            
        end
   end
   
   RGB =  pennies( int16(centers(i,1))+x, int16(centers(i,2)), : );
   for r = 1 : size(cmp)
        if cmp(r)*255 == RGB(1) && RGB(1)~=RGB(2)          
%             disp(RGB(1)) 
%             disp(cmp(r)*255) 
%             disp(RGB(2)) 
%             disp(cmp(r,2)*255) 
            if RGB(2)== cmp(r,2)*255          
                disp("green")
                if RGB(3) == cmp(r,2)*255
                    disp(RGB)
                end
            end
            
        end
   end
   
   RGB =  pennies( int16(centers(i,1)), int16(centers(i,2))+x, : );
   for r = 1 : size(cmp)
        if cmp(r)*255 == RGB(1)          
%             disp(RGB(1)) 
%             disp(cmp(r)*255) 
%             disp(RGB(2)) 
%             disp(cmp(r,2)*255) 
            if RGB(2)== cmp(r,2)*255          
                disp("green")
                if RGB(3) == cmp(r,2)*255
                    disp(RGB)
                end
            end
            
        end
   end
   
   RGB =  pennies( int16(centers(i,1))+x, int16(centers(i,2))+x, : );
   for r = 1 : size(cmp)
        if cmp(r)*255 == RGB(1)         
%             disp(RGB(1)) 
%             disp(cmp(r)*255) 
%             disp(RGB(2)) 
%             disp(cmp(r,2)*255) 
            if RGB(2)== cmp(r,2)*255     
                disp("green")
                if RGB(3) == cmp(r,2)*255
                    disp(RGB)
                end
            end
            
        end
   end
   
   RGB =  pennies( int16(centers(i,1))-x, int16(centers(i,2)), : );
   for r = 1 : size(cmp)
        if cmp(r)*255 == RGB(1)          
%             disp(RGB(1))
%             disp(cmp(r)*255) 
%             disp(RGB(2)) 
%             disp(cmp(r,2)*255) 
            if RGB(2)== cmp(r,2)*255          
                disp("green")
                if RGB(3) == cmp(r,2)*255
                    disp(RGB)
                end
            end
            
        end
   end
   
   RGB =  pennies( int16(centers(i,1)), int16(centers(i,2))-x, : );
   for r = 1 : size(cmp)
        if cmp(r)*255 == RGB(1)         
%             disp(RGB(1)) 
%             disp(cmp(r)*255) 
%             disp(RGB(2)) 
%             disp(cmp(r,2)*255) 
            if RGB(2)== cmp(r,2)*255          
                disp("green")
                if RGB(3) == cmp(r,2)*255
                    disp(RGB)
                end
            end
            
        end
   end
   
   RGB =  pennies( int16(centers(i,1))-x, int16(centers(i,2))-x, : );
   for r = 1 : size(cmp)
        if cmp(r)*255 == RGB(1)          
%             disp(RGB(1)) 
%             disp(cmp(r)*255) 
%             disp(RGB(2)) 
%             disp(cmp(r,2)*255) 
            if RGB(2)== cmp(r,2)*255          
                disp("green")
                if RGB(3) == cmp(r,2)*255
                    disp(RGB)
                end
            end
            
        end
   end
   
   RGB =  pennies( int16(centers(i,1))+x, int16(centers(i,2))-x, : );
   for r = 1 : size(cmp)
        if cmp(r)*255 == RGB(1)          
%             disp(RGB(1)) 
%             disp(cmp(r)*255) 
%             disp(RGB(2)) 
%             disp(cmp(r,2)*255) 
            if RGB(2)== cmp(r,2)*255          
                disp("green")
                if RGB(3) == cmp(r,2)*255
                    disp(RGB)
                end
            end
            
        end
   end
   
   RGB =  pennies( int16(centers(i,1))-x, int16(centers(i,2))+x, : );
   for r = 1 : size(cmp)
        if cmp(r)*255 == RGB(1)          
%             disp(RGB(1)) 
%             disp(cmp(r)*255) 
%             disp(RGB(2)) 
%             disp(cmp(r,2)*255) 
            if RGB(2)== cmp(r,2)*255          
                disp("green")
                if RGB(3) == cmp(r,3)*255
                    disp(RGB)
                end
            end
            
        end
   end
end
   
end
end

end