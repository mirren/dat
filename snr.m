function SNR = snr(x,xq)
    qn = x - xq; % Calculate quantization noise    
    P_signal = sum(abs(x.^2));        
    P_noise = sum(abs(qn.^2));
    SNR = 10*log10(P_signal/P_noise); % Calculate SNR in dB
end