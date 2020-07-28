coin_pic = imread("photos/coin11.jpg");

small_img = imresize(coin_pic,.25);
% I = imresize(rgb2gray(coin_pic), 0.25);
% coin_he = histeq(I, 5);

I = rgb2gray(small_img);

%calculate Hough Transform
BW = edge(I,'canny');
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);

%display Hough Transform & rgb image
% subplot(2,1,1);
% imshow(coin_pic);
% title('coin1.jpg');
% subplot(2,1,2);
% imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
%       'InitialMagnification','fit');
% title('Hough transform of coin1.jpg');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% colormap(gca,hot);

%find circles 
[centers, radii, metric] = imfindcircles(BW, [80,150]); %,'ObjectPolarity','bright'
numCoin = length(centers);
centersStrong5 = centers(1:numCoin); %centers is 11 elements after first run
radiiStrong5 = radii(1:numCoin);
metricStrong5 = metric(1:numCoin);

%display on image
figure();
%imshow(coin_pic);
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');

coin_he = histeq(coin_pic, 50);
imshow(coin_he)

