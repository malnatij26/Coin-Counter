coins = imresize(imread("photos/good_coin.jpg"),1);
figure; subplot(1,2,1); imshow(coins); title('Original');
bwCoins = im2double(rgb2gray(coins));
% subplot(1,2,2); imshow(bwCoins); title('Grayscale image');
% 
%Find each coin in image using imfindcircles
[centers, radii, metric] = imfindcircles(bwCoins, [100 250], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');

subplot(1,2,2); imshow(coins);

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

% display(radii)


dime = min(radii);
quarter = max(radii);

if dime ~= quarter
    %pennys diamiter now kenoing the min and max.
    %1.14 is the diference in mm penny-dime
    %3.3  is the diference in mm nickel-dime
    %6.53 is the diference in mm quarter-dime

    penny = ( 1.14/((6.35)/(quarter-dime)) ) + dime;
    nickel = ( 3.3/((6.35)/(quarter-dime)) ) + dime;

    dime_count = 0;
    penny_count = 0;
    nickel_count = 0;
    quarter_count = 0;

    for i = 1:length(radii)
        if radii(i)< penny && (radii(i) - dime < penny - radii(i))
            dime_count = dime_count + 1;
        elseif radii(i) < nickel  && (radii(i) - penny < nickel - radii(i))
            penny_count = penny_count + 1;
        elseif radii(i) < quarter && (radii(i) - nickel < quarter - radii(i))
            nickel_count = nickel_count + 1;
        else
            quarter_count = quarter_count + 1;
        end
    end
    display(dime_count)
    display(penny_count)
    display(nickel_count)
    display(quarter_count)
    value = (dime_count*10)+(penny_count)+ (nickel_count*5)+ (quarter_count*25);
    display("value = " + value+ " cents");
     
else %single coin

    
    
end
%pause;
%clc; close all; clear all;

function values = getValue()
    values = [dime_count, penny_count, nickel_count, quarter_count, value];
end


