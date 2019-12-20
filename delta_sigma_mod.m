function [s_sdm,q] = sigma_delta_mod(u,s)
% function [xrd,s] = sigma_delta_mod(u)
% Implementation of a first-order sigmal delta modulator
% Input 
%   u     : upsampling rate
%   s     : input signal
% Output
%   s_sdm : reconstructed signal
%   q     : qunatization error

su = upsample(s,u);
d = 1;
% delta signal
delta = zeros(length(su),1);
% signal signal
sigma = zeros(length(su),1);
% quantized sigma signal
sigmaq = zeros(length(su),1);
sigma(1)=su(1);
% Low pass filter coefficient 
a = 0.8;

% Encoder
for n = 2:1:length(su)        
    delta(n) = su(n) - sigmaq(n-1);
    % Integrate (low-pass) use a=-1 for simple addition
    sigma(n) = one_pole_low_pass(delta(n),sigma(n-1),-0.8);
    % Quantize        
    if sigma(n)>=0 
        sigmaq(n)=d;
    else
        sigmaq(n)=-d;
    end    
    % Store Quantization Error
    q(n) = sigma(n) - sigmaq(n);    
end

% Decoder 
% Decimate xr(n) using simple moving Average (not 3 stages!!)
B = 1/u*ones(u,1);
out = filter(B,1,sigmaq);
s_sdm = out(1:u:length(out));


% subplot(3,1,3);
% [px1,f1,pxxc1] = periodogram(xrf,'onesided',512,u*fs);
% [px2,f1,pxxc1] = periodogram(su,'onesided',512,u*fs);
% plot(f1,10*log10(px1),f1,10*log10(px2));
% legend({'Original','Decoded'},'Fontsize',14);
% ylabel('Power (dB)','Fontsize',14);xlabel('Frequency','Fontsize',14);
% title('Original and Decoded (Upsampled)');

end