if differ==1
        if ismember(dbp,[3,5,6,9,10,12]) % if there is one bit overflow and the last pixel bitplanes number is 2 then the overflow bit will not affect and it will be ignored 
            differ = 0;
            break;
        end
    
    elseif  (differ<=2)
        if ismember(dbp,[7,11,13,14]) % if there is 2 bits overflow and the last pixel bitplanes number is 3 then the overflow bits will not affect and they will be ignored 
             differ = 0;
             break;
        end
elseif  (differ<=3)
        if dbp==15 % if there is 3 bits overflow and the last pixel bitplanes number is 4 then the overflow bits will not affect and they will be ignored 
             differ = 0;
             break;
        end
    end
