function isPenny = isPennyColor(image, center, radius, threshold)
cmp = get_penny_color();
pennies = image;
isCoin = 0;
    for x=1: radius
        if int16(center(2)) < (1512-radius)  && int16(center(1)) < (1512-radius)
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
            
            RGB =  pennies( int16(center(1))+x, int16(center(2)), : );
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
        isPenny = 1;
    else
        isPenny = 0;
    end
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

