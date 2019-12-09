function s = sinus_aliasing(f1,f2,fs)
    N_FFT = 512;    
    t = (0:1:(0.2*fs))/fs;
    s1 = sin(2*pi*f1*t);
    s2 = sin(2*pi*f2*t);
    s = s1+s2;
    % calculate at jittered interval
    S = 20*log10(abs(fft(s,N_FFT))*2/(N_FFT));    
    hold on
    plot((0:((length(S)-1)/2))/512*(fs),S(1:(length(S)/2)));
    grid on; 
end