function dsm_demo(mode,u)
% function dsm_demo(mode,u)
% DSM encodes simpel signals and plots the results
% Input 
%   mode : 's' for sinus, 'n' fir noise signal
%   u    : upsampling factor

dur = 0.05; fs = 44100;

as = 1; % Maximum Amplitude 
if (mode == 's')
    % Sinus Tone    
    [s,t] = sinus(as,440,dur,fs);
elseif (mode == 'n')
    % Noise 
    s = rand(dur*fs,1)-0.5;
    t = 0:(1/fs):(dur-(1/fs));
end

[s_ds,q_ds] = delta_sigma_mod(s,u);

% Some plots
figure;
subplot(2,1,1);
plot(t,s,t,s_ds);
ylabel('Amplitude','Fontsize',14);xlabel('Time','Fontsize',14);
title('Original vs Reconstructed Signal');
subplot(2,1,2);
[px1,f1,~] = periodogram(q_ds,'onesided',512,u*fs);
plot(f1/1000,10*log10(px1)); grid on;
ylabel('Power (dB)','Fontsize',14);xlabel('Frequency (kHz)','Fontsize',14);
title('Quantization Noise Spectrum');

end