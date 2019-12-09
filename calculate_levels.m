function levels = calculate_levels(U,b,type)
    N_levels = 2^b;
    delta = 2*U / N_levels;
    if type == 'mid-rise'
        levels = -U + delta/2 + (0:N_levels) * delta; 
    elseif type == 'mid-tread'
        levels = -U + (0:N_levels) * delta;
    else
         frpintf(0,"Unknown quantization type!");
    end
    
end