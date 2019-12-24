function [s_ds,q_ds] = delta_sigma_mod(s,u)
% function [xrd,s] = sigma_delta_mod(u)
% Implementation of a first-order sigmal delta modulator
% Input 
%   u      : upsampling rate
%   s      : input signal
% Output
%   s_ds   : reconstructed signal
%   q_ds   : qunatization error

% su = resample(s,u,1);
su = resample(s,u,1);
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
    sigma(n) = one_pole(delta(n),sigma(n-1),-1);
    % Quantize        
    if sigma(n)>=0 
        sigmaq(n)=d;
    else
        sigmaq(n)=-d;
    end    
end

% Decoder 
s_ds = resample(sigmaq,1,u);

% Quantization Error
q_ds = s(:) - s_ds(:);

% Simple moving average
% B = 1/u*ones(u,1);
% out = filter(B,1,sigmaq);
% s_sdm = out(1:u:length(out));

end