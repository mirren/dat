function delta_demo(mode,u)
% function delta_demo(mode,u)
% DSM encodes simpel signals and plots the results
% Input 
%   mode : 's' for sinus, 'n' for noise signal
%   u    : upsampling factor

dur = 0.05; fs = 44100;

as = 1; % Maximum Amplitude 
if (mode == 's')
    % Sinus Tone    
    [s,t] = sinus(as,440,dur,fs);
    % Delta Step
    d = 2*pi*as*(440/fs);
%     d = 0.01;
elseif (mode == 'n')
    % Noise 
    t = 0:(1/fs):(dur-(1/fs));
    s = rand(dur*fs,1)-0.5;
    % Delta Step
    d = 1;
end

[s_d,q_d] = delta_mod(s,u,d);

figure;
subplot(3,1,1);
plot(t(1:200),s(1:200),t(1:200),s_d(1:200));
ylabel('Amplitude','Fontsize',14);xlabel('Time','Fontsize',14);
title('Original vs Reconstructed Signal');
subplot(3,1,2);
[px1,f1,~] = periodogram(q_d,'onesided',512,fs);
plot(f1,10*log10(px1));
ylabel('Power (dB)','Fontsize',14);xlabel('Frequency','Fontsize',14);
title('Quantization Noise Spectrum');
subplot(3,1,3);
[px1,~,~] = periodogram(s,'onesided',512,fs);
[px2,~,~] = periodogram(s_d,'onesided',512,fs);
plot(f1,10*log10(px1),f1,10*log10(px2));
legend({'Original','Decoded'},'Fontsize',14);
ylabel('Power (dB)','Fontsize',14);xlabel('Frequency','Fontsize',14);
title('Original and Decoded (Upsampled)');

end