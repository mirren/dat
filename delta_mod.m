function [s_d,q_d] = delta_mod(s,u,d)
% function [s_d,q_d] = delta_mod(u)
% implementation of a delta modulator
% Input 
%   s    : input signal 
%   u    : upsampling rate
%   d    : encoder step
% Output
%   s_d: reconstructed signal
%   q_d: qunatization noise

su = resample(s,u,1);

delta_q = zeros(length(su),1);
s_du = zeros(length(su),1);
s_d = zeros(length(su),1);
s_du(1)=su(1);

% Encoder
for n = 2:(length(su))
    % Calculate Error Signal
    delta(n) = su(n) - s_du(n-1);
    % Quantize 
    if delta(n)>0 
        delta_q(n)=d;
    else
        delta_q(n)=-d;
    end
    % Delta Quantization Error
    % q(n) = delta(n) - delta_q(n);
    % Integrate (low-pass) to feed back
    s_du(n) = one_pole(delta_q(n),s_du(n-1),-1);    
end

% Decoder
% Filter Integrator output with H(f)
xrf = filter(1,[1,-1],delta_q);
% Decimate Sampling Rate
s_d = resample(xrf,1,u);
q_d = s(:)-s_d(:);
% Moving Average
% B = 1/u*ones(u,1);
% out = filter(B,1,s_du);
% s_d = s_du(1:u:length(s_du));


end