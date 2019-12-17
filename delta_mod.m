function [xrd,s] = delta_mod(u)
% function [xrd,s] = delta_mod(u)
% implementation of a delta modulator
% u: upsampling rate
% xrd: reconstructed signal
% s: original signal 

% Generate Input Signals
fs = 44100;as = 1; dur = 0.05;
t = 0:(1/fs):dur;
s = sinus(as,440,dur,fs);
% Upsample
su = sinus(as,440,dur,u*fs);

% Using a higher than Ideal Step
d = (1.5)*2*pi*as*(400/(u*fs));
sd = zeros(length(su),1);
xr = zeros(length(su),1);
a = 0.8; xr(1)=su(1);

% Encoder
for n = 1:(length(su)-1)
    % Calculate Error Signal
    delta(n) = su(n) - xr(n);
    if delta(n)>0 
        sd(n)=d;
    else
        sd(n)=-d;
    end
    % Store Quantization Error
    q(n) = delta(n) - sd(n);
    % Integrate (low-pass) to feed back
    xr(n+1) = one_pole_low_pass(sd(n),xr(n),-0.8);    
end

% Decoder
% Filter Integrator output with H(f)
xrf = filter(1,[1,-0.8],xr);
% Decimate xr(n)
% Moving Average
B = 1/u*ones(u,1);
out = filter(B,1,xr);
xrd = xr(1:u:length(xr));

figure;
subplot(3,1,1);
plot(t,s,t,xrd);
ylabel('Amplitude','Fontsize',14);xlabel('Time','Fontsize',14);
title('Original vs Reconstructed Signal');
subplot(3,1,2);
[px1,f1,pxxc1] = periodogram(q,'onesided',512,u*fs);
plot(f1,10*log10(px1));
ylabel('Power (dB)','Fontsize',14);xlabel('Frequency','Fontsize',14);
title('Quantization Noise Spectrum');
subplot(3,1,3);
[px1,f1,pxxc1] = periodogram(xrf,'onesided',512,u*fs);
[px2,f1,pxxc1] = periodogram(su,'onesided',512,u*fs);
plot(f1,10*log10(px1),f1,10*log10(px2));
legend({'Original','Decoded'},'Fontsize',14);
ylabel('Power (dB)','Fontsize',14);xlabel('Frequency','Fontsize',14);
title('Original and Decoded (Upsampled)');

end