function [sq,squ,e,eu] = upsampling_demo(k,u,fs)
N_FFT = 512;
as = 1; dur = 0.5;
t = 0:(1/fs):dur;
l = pcm_levels(1,k,'mid-raise');
s = sinus(as,440,dur,fs);
su = sinus(as,440,dur,u*fs);
sq = quantize(s,l);
squ = quantize(su,l);

e = sq-s;
eu = squ - su;

% S = 20*log10(abs(fft(s,N_FFT))*2/(N_FFT));
% SQ = 20*log10(abs(fft(sq,N_FFT))*2/(N_FFT));

% figure;
% subplot(3,1,1); 
% title('Quantized versus original signal');
% hold on, grid on;
% plot((0:((length(S)-1)/2))/512*(fs),S(1:(length(S)/2)));    
% ylabel('Amplitude (dB)','Fontsize',14);
% xlabel('Frequency (Hz)','Fontsize',14);        
% plot((0:((length(S)-1)/2))/512*(fs),SQ(1:(length(S)/2)));        
% legend({'Normal','Quantized'});
% legend({'Original','Quantized'});
% subplot(3,1,2);
% plot(sq-s);
% title('Quantization Error');
% xlabel('Time'); ylabel('Amplitude');
% subplot(3,1,3);
% periodogram(sq-s,'one-sided',512);
% end

