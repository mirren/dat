function levels = pcm_levels(U,b,type)
    N_levels = 2^b;
    delta = 2*U / N_levels;
    if strcmp(type,'mid-raise')
        levels = -U + delta/2 + (0:N_levels) * delta; 
    end
    if strcmp(type,'mid-tread')
        levels = -U + (0:N_levels) * delta;
    end    
end