function dsm_demo(mode,u)
% function sdm_demo(mode)
% DSM encodes simpel signals and plots the results
% Input 
%   mode : 's' for sinus, 'm' fir noise signal
%   u    : upsampling factor

dur = 0.05; fs = 44100;
t = 0:(1/fs):(dur-(1/fs));
as = 1; % Maximum Amplitude 
if (mode == 's')
    % Sinus Tone    
    s = sinus(as,440,dur,fs);
elseif (mode == 'n')
    % Noise 
    s = rand(dur*fs,1)-0.5;
end

[s_sdm,q_sdm] = delta_sigma_mod(s,u);

% Some plots
figure;
subplot(2,1,1);
plot(t,s,t,s_sdm);
ylabel('Amplitude','Fontsize',14);xlabel('Time','Fontsize',14);
title('Original vs Reconstructed Signal');
subplot(2,1,2);
[px1,f1,pxxc1] = periodogram(q_sdm,'onesided',512,u*fs);
plot(f1/1000,10*log10(px1)); grid on;
ylabel('Power (dB)','Fontsize',14);xlabel('Frequency (kHz)','Fontsize',14);
title('Quantization Noise Spectrum');

end