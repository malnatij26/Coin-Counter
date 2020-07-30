coins = imresize(imread("photos/good_coin.jpg"), .2);
figure; subplot(1,3,1); imshow(coins); title('Original');
bwCoins = im2double(rgb2gray(coins));
subplot(1,3,2); imshow(bwCoins); title('Grayscale image');

%Find each coin in image using imfindcircles
[centers, radii, metric] = imfindcircles(bwCoins, [30 90], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');

subplot(1,3,3); imshow(coins);

%Show circles on original image
detected = viscircles(centers, radii);
drawnow;

title(sprintf('Number of Coins Detected: %d', size(centers,1)));

%End early if no coins are detected
if size(centers, 1) == 0
    disp('No coins detected. Press any key to exit');
    pause;
    clc; close all; clear all;
    return;
end

display(radii)


dime = min(radii);
penny = 33;
nickle = 35;
quarter = max(radii);

dime_count = 0;
penny_count = 0;
nickle_count = 0;
quarter_count = 0;

for i = 1:length(radii)
    if radii(i) > penny
        dime_count = dime_count + 1;
    elseif radii(i) >= penny && radii(i) < nickle
        penny_count = penny_count + 1;
    elseif radii(i) >= nickle && radii(i) < quarter
        nickle_count = nickle_count + 1;
    else
        quarter_count = quarter_count + 1;
    end
end
display(dime_count)
display(penny_count)
display(nickle_count)
display(quarter_count)
value = (dime_count*10)+(penny_count)+ (nickle_count*5)+ (quarter_count*25)
display("value = " + value+ " cents");
    

pause;
clc; close all; clear all;