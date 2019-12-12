function [xrd,s] = delta_mod(u)

N_FFT = 512;fs = 44100;
as = 1; dur = 0.05;
t = 0:(1/fs):dur;
s = sinus(as,440,dur,fs);
su = sinus(as,440,dur,u*fs);
d = 2*pi*as*(400/(u*fs));
sd = zeros(length(su),1);
xr = zeros(length(su),1);
for n = 1:(length(su)-1)

   e(n) = su(n) - xr(n);
    if e(n)>0 
        sd(n)=1;
        % integrator Output
        xr(n+1) = xr(n) + d;
    else
        sd(n)=-1;
        % integrator Output
        xr(n+1) = xr(n) - d;
    end
end

% Low Pass (decimate) xr(n)
% Moving Average
B = 1/u*ones(u,1);
out = filter(B,1,xr);
xrd = xr(1:u:length(xr));

1;
end

