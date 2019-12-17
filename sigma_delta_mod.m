function [xrd,s] = sigma_delta_mod(u)
% function [xrd,s] = sigma_delta_mod(u)
% Implementation of a first-order sigmal delta modulator
% u: upsampling rate
% xrd: reconstructed signal
% s: input signal

% Generate Input Signals
fs = 44100;as = 1; dur = 0.05;
t = 0:(1/fs):dur;
N = 100;
s = sinus(as,440,dur,fs);
su = sinus(as,440,dur,u*fs);
% Upsample
s = rand(dur*fs,1)-0.5;
su = rand(dur*u*fs,1)-0.5;
% Ideal Step
% d = 2*pi*as*(400/(u*fs));
d = 1;
delta = zeros(length(su),1);
sigma = zeros(length(su),1);
sigmaq = zeros(length(su),1);
a = 0.8; sigma(1)=su(1);

% Encoder
for n = 2:1:length(su)        
    delta(n) = su(n) - sigmaq(n-1);
    % Integrate (low-pass) 
    sigma(n) = one_pole_low_pass(delta(n),sigma(n-1),-0.8);
    % Integrate
    % sigma(n) = sigma(n-1) + delta(n);            
    % Quantize        
    if sigma(n)>=0 
        sigmaq(n)=d;
    else
        sigmaq(n)=-d;
    end    
    % Store Quantization Error
    q(n) = sigma(n) - sigmaq(n);
    
end

% Decimate xr(n)
% Moving Average
B = 1/u*ones(u,1);
out = filter(B,1,sigmaq);
xrd = out(1:u:length(out));

figure;
subplot(2,1,1);
plot(t,s,t,xrd);
ylabel('Amplitude','Fontsize',14);xlabel('Time','Fontsize',14);
title('Original vs Reconstructed Signal');
subplot(2,1,2);
[px1,f1,pxxc1] = periodogram(q,'onesided',512,u*fs);
plot(f1,10*log10(px1));ylim([-100 0]);
ylabel('Power (dB)','Fontsize',14);xlabel('Frequency','Fontsize',14);
title('Quantization Noise Spectrum');
% subplot(3,1,3);
% [px1,f1,pxxc1] = periodogram(xrf,'onesided',512,u*fs);
% [px2,f1,pxxc1] = periodogram(su,'onesided',512,u*fs);
% plot(f1,10*log10(px1),f1,10*log10(px2));
% legend({'Original','Decoded'},'Fontsize',14);
% ylabel('Power (dB)','Fontsize',14);xlabel('Frequency','Fontsize',14);
% title('Original and Decoded (Upsampled)');

end


function s2 ()
% sigma delta modulation
xn = sin(2*pi*1/64*[0:63]);
xhatn = 0;
rn = 0;
x1n = 0;
for ii = 1:length(xn)

% sigma operation
x1n = xn(ii) + x1n;
% difference computation
dn = x1n - xhatn;
dqn = dn; % no quantizing done, when quantizing is done: dqn = 2*(dn>0) - 1;
dqn = 2*(dn>0) - 1;
xqn = dqn + xhatn; 

% dump of variables
x1nDump(ii) = x1n;
dnDump(ii) = dn;
dqnDump(ii) = dqn;
xqnDump(ii) = xqn;
xhatnDump(ii) = xhatn;

xhatn = xqn;

end 

diff = (xn - dqnDump)
end
