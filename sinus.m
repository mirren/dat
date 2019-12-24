function [s,t] = sinus(as,f,d,fs)
    % as: tone amplitude
    % f: tone frequency
    % d: tone duration
    % fs: sampling frequency    
    t = 0:(1/fs):(d-(1/fs));
    s = as*sin(2*pi*f*t);
    
end