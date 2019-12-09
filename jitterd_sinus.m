function s = jitterd_sinus(f,d,fs,as,aj,fj)
    % f: tone frequency
    % d: tone duration
    % fs: sampling frequency
    % as: amplitude of signal
    % aj: jitter amplitude
    % fj: jitter frequency
    
    N_FFT = 512;
    % Jitter Estimation    
    t = (0:1:(d*fs))/fs;
    ja = aj/(128*fs);
    tj = ja*sawtooth(2*pi*fj*t,1/2);
    ts = t + tj;
    % calculate at jittered interval
    s = as*sin(2*pi*f*t);
    sj = as*sin(2*pi*f*ts);
    S = 20*log10(abs(fft(s,N_FFT))*2/(N_FFT));
    SJ = 20*log10(abs(fft(sj,N_FFT))*2/(N_FFT));
    hold on
    plot((0:((length(S)-1)/2))/512*(fs),S(1:(length(S)/2)));    
    if (aj~=0)
        plot((0:((length(S)-1)/2))/512*(fs),SJ(1:(length(S)/2)));    
    end
end