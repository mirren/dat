function sampling_reconstruction(x,fs)
    tmin = 0;
    tmax = length(x)/fs;    
    t = tmin:1e-5:tmax;    
    Ts = 1/fs;
    ts = tmin:Ts:(tmax-Ts);
    xr = zeros(1,length(t)); 
    samples = length(x);
    
    for i = 1:1:length(t)
        for n = 1:samples
            xr(i) = xr(i) + x(n)*sinc((t(i)-n*Ts)/Ts);            
        end       
    end
    
    for n = 1:samples
        [m,i] = min(abs(ts(n) - t));
        to(n) = t(i);
        xo(n) = xr(i);
    end
    figure(1)
    subplot(3,1,1)
    plot(ts,x);
    hold on
%     stem(ts,x1resampled)
    subplot(3,1,2), title('Reconstructed (Analog)')
    plot(t,xr);
    subplot(3,1,3), title('Reconstruction Error (Analog)')
    plot(xo-x);
end

%     F1 = 300;
%     Fs = 1000;
%     tmin = 0;
%     tmax = 5/F1;
%     t = tmin:1e-6:tmax;
%     x1 = sin(2*pi*F1*t);
%     Ts = 1/Fs;
%     ts = tmin:Ts:tmax;
%     x1resampled = sin(2*pi*F1*ts);