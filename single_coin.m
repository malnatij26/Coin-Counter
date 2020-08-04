%function single_coin(picture)

function single_coin()
edgeThreshold = 0.2;
amount = 0.9;
coins =  localcontrast(imsharpen(rgb2gray(imresize(imread("photos/p2.jpg"),1))),edgeThreshold,amount );
figure; subplot(1,2,1); imshow(coins); title('Original');
% bwCoins = im2double(rgb2gray(coins));
% subplot(1,2,2); imshow(bwCoins); title('Grayscale image');
% 
%Find each coin in image using imfindcircles
[centers, radii, metric] = imfindcircles(coins, [75 175], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');

subplot(1,2,2); imshow(coins);
%Show circles on original image
detected = viscircles(centers, radii);
drawnow;

pennies =  localcontrast(imsharpen(rgb2gray(imresize(imread("photos/p1.jpg"),1))), edgeThreshold,amount );

coinPoints = detectSURFFeatures(coins);
pennyPoints = detectSURFFeatures(pennies);

[coinFeatures, coinPoints] = extractFeatures(coins, coinPoints);
[pennyFeatures, pennyPoints] = extractFeatures(pennies, pennyPoints);

coinPairs = matchFeatures(pennyFeatures, coinFeatures );

matchedCoinPoints = coinPoints(coinPairs(:, 2), :);
matchedPennyPoints = pennyPoints(coinPairs(:, 1), :);

figure;
showMatchedFeatures(coins, pennies, matchedCoinPoints, matchedPennyPoints, 'montage');

title('Putatively Matched Points (Including Outliers)');


figure;
imshow(pennies);
title('300 Strongest Feature Points from penny Image');
hold on;
plot(selectStrongest(pennyPoints, 300));

end


function match_penny(coins)
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

pennies = imresize(imread("photos/all_p.jpg"),.5);
[centers, radii, metric] = imfindcircles(pennies, [150 250], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');
penny_color = [zeros(size(centers,1)), zeros(size(centers,1)), zeros(size(centers,1))];
for i = 1 : size(centers, 1)
    RGB =  pennies( int16(centers(i,1)), int16(centers(i,2)), : );
    disp(RGB)
    penny_color(i) = [RGB(1), RGB(2), RGB(3)];
end

end