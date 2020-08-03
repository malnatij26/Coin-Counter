%function single_coin(picture)

function single_coin()
pennies = imresize(imread("photos/all_p.jpg"),.5);
figure; subplot(1,2,1); imshow(pennies); title('Original');
% bwCoins = im2double(rgb2gray(coins));
% subplot(1,2,2); imshow(bwCoins); title('Grayscale image');
% 
%Find each coin in image using imfindcircles
[centers, radii, metric] = imfindcircles(pennies, [150 250], 'ObjectPolarity','bright', 'Sensitivity',0.96, 'Method', 'TwoStage');

subplot(1,2,2); imshow(pennies);
%Show circles on original image
detected = viscircles(centers, radii);
drawnow;

disp(get_penny_color);


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