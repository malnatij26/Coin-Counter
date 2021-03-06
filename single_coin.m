%function single_coin(picture)

function single_coin(coins)
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

match_penny_color(coins)

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
[centers, radii, metric] = imfindcircles(pennies,  [130 175], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');
cmp = colormap(copper);
p = min(radii)*size(centers,1);
penny_color = zeros(p,3);
p = 1;

% Modified 8 neighbors @ a radious of x to create a list of penny color
for x=1: min(radii)
    for i = 1 : size(centers, 1)
        if int16(centers(i,2)) < (1512-min(radii)) && int16(centers(i,1)) < (1512-min(radii))
            
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
            penny_color(p,1) = RGB(1);
            penny_color(p,2) = RGB(2) ;
            penny_color(p,3)  = RGB(3);
            p = p+1;
            RGB =  pennies( int16(centers(i,1))+x, int16(centers(i,2))-x, : );
            penny_color(p,1)= RGB(1);
            penny_color(p,2) = RGB(2) ;
            penny_color(p,3)  = RGB(3);
            p = p+1;
            RGB =  pennies( int16(centers(i,1))-x, int16(centers(i,2))+x, : );
            penny_color(p,1)= RGB(1) ;
            penny_color(p,2) = RGB(2) ;
            penny_color(p,3)  = RGB(3);
            p = p+1;
        end
    end
    
end


end


function isPenny = isPennyColor(image, center, radius, threshold)
cmp = get_penny_color();
pennies = image;
isCoin = 0;
    for x=1: radius
        if int16(center(2)) < (1512-min(radii))  && int16(center(1)) < (1512-min(radii))
            RGB =  pennies( int16(center(1)), int16(center(2)), : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
%             RGB =  pennies( int16center(1))+x, int16(center(2)), : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  pennies( int16(center(1)), int16(center(2))+x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  pennies( int16(center(1))+x, int16(center(2))+x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  pennies( int16(center(1))-x, int16(center(2)), : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  pennies( int16(center(1)), int16(center(2))-x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(3) == cmp(r,3)
                        isCoin = isCoin +1;
                    end
                end
                
            end
            
            
            RGB =  pennies( int16(center(1))-x, int16(center(2))-x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  pennies( int16(center(1))+x, int16(center(2))-x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  pennies( int16(center(1))-x, int16(center(2))+x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
        end
        
    end
    if isCoin >= threshold
        isPenny = 1
    else
        isPenny = 0
    end
end

function  match_penny_color(coins)


% pennies = imresize(imread("photos/good_coin.jpg"),0.5);
[centers, radii, metric] = imfindcircles(coins,  [30 90], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');

% imshow(coins);
%Show circles on original image
detected = viscircles(centers, radii);
% drawnow;
%disp(centers)
cmp = get_penny_color();

num_found = 0;
[rows, columns, numberOfColorChannels] = size(coins);

for i = 1 : size(centers, 1)
    isCoin = 0;
    for x=1: min(radii)
        if int16(centers(i,2)) < (rows-min(radii))  && int16(centers(i,1)) < (columns-min(radii))
            RGB =  coins( int16(centers(i,1)), int16(centers(i,2)), : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  coins( int16(centers(i,1))+x, int16(centers(i,2)), : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  coins( int16(centers(i,1)), int16(centers(i,2))+x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  coins( int16(centers(i,1))+x, int16(centers(i,2))+x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  coins( int16(centers(i,1))-x, int16(centers(i,2)), : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  coins( int16(centers(i,1)), int16(centers(i,2))-x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(3) == cmp(r,3)
                        isCoin = isCoin +1;
                    end
                end
                
            end
            
            
            RGB =  coins( int16(centers(i,1))-x, int16(centers(i,2))-x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  coins( int16(centers(i,1))+x, int16(centers(i,2))-x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
            RGB =  coins( int16(centers(i,1))-x, int16(centers(i,2))+x, : );
            for r = 1 : size(cmp)
                if cmp(r) == RGB(1)
                    if RGB(2)== cmp(r,2)
                        if RGB(3) == cmp(r,3)
                            isCoin = isCoin +1;
                        end
                    end
                    
                end
            end
            
        end
        
    end
    if isCoin >= 150
        disp("penny found: ")
        disp(centers(i,:))
        disp(isCoin)
        num_found = num_found +1;
    end 
end
disp("pennies found :");
disp(num_found);
end



