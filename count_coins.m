function [dime_count,penny_count,nickel_count,quarter_count,value] = count_coins(radii)

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
%     display(dime_count)
%     display(penny_count)
%     display(nickel_count)
%     display(quarter_count)
    value = (dime_count*10)+(penny_count)+ (nickel_count*5)+ (quarter_count*25);
%     display("value = " + value+ " cents");
     
else %single coin

    
    
end
%pause;
%clc; close all; clear all;

end

% function values = getValue()
%     values = [dime_count, penny_count, nickel_count, quarter_count, value];
% end
