% lunch = imresize( imread("lunch1.jpg")   ,.2);
% 
% l2 = imresize( imread("lunch2.jpg"), .2);
% cup = imresize( imread("cup.jpg"  ),.1);
% 
% imwrite(lunch,'lunch_1.pgm')
% imwrite(l2,'lunch_2.pgm')
% imwrite(cup, 'cup.pgm')

[image, descrips, locs] = sift('lunch_1.pgm');
showkeys(image, locs);

[image, descrips, locs] = sift('lunch_2.pgm');
showkeys(image, locs);

match("lunch_1.pgm", "lunch_2.pgm");
