function [s,sq,e] = quantization_demo(k)
% function [s,sq,e] = quantization_demo(k)
% k: number of bits
% s:  original signal
% sq: quantized signal 
% e:  error signal

N_FFT = 512;
fs = 44100; as = 1; dur = 0.5; m = as;
t = 0:(1/fs):dur;
l = pcm_levels(1,k,'mid-raise');
s = sinus(as,440,dur,fs);
sq = quantize(s,l);
e = sq-s;
SNR = snr(s,sq);
fprintf('SNR = %.2f, Theoretical= %.2f\n',SNR, 20*log10(m) + 6.02*k + 1.76);
S = 20*log10(abs(fft(s,N_FFT))*2/(N_FFT));
SQ = 20*log10(abs(fft(sq,N_FFT))*2/(N_FFT));
figure;
subplot(3,1,1); 
title('Quantized versus original signal');
hold on, grid on;
plot((0:((length(S)-1)/2))/512*(fs),S(1:(length(S)/2)));    
ylabel('Amplitude (dB)','Fontsize',14);
xlabel('Frequency (Hz)','Fontsize',14);        
plot((0:((length(S)-1)/2))/512*(fs),SQ(1:(length(S)/2)));        
legend({'Normal','Quantized'});
legend({'Original','Quantized'});
subplot(3,1,2);
plot(sq-s);
title('Quantization Error');
xlabel('Time'); ylabel('Amplitude');
subplot(3,1,3);
periodogram(sq-s,'one-sided',512);


end

