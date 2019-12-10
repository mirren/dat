function [s,sq,sqast,sqd] = dithering_demo()

as = 2*2/(2^16); fc = 200;
k = 16; dur = 0.3; fs = 44100;

% Condition for granural noise 
qc = (as/(2/2^k)*fc>(20*10^3)/pi);
if qc
   fprintf(1,'Condition Satisfied\n');
else
   ast = round(log(13000/fc)/log(2));
   fprintf(1,'Condition Not Satisfied, Granural Noise\n');
   fprintf(1,'Bits Required: %d\n', ast);
end

s = sinus(2/(2^16),fc,dur,fs);
n = uniform_dither(length(s),k);
sast = sinus(ast*2/(2^16),fc,dur,fs);
sd = s + n';
sq = quantize(s,pcm_levels(1,16,'mid-tread'));
sqast = quantize(sast,pcm_levels(1,16,'mid-tread'));
sqd = quantize(sd,pcm_levels(1,16,'mid-tread'));
% Plots

figure;
title('Input Signal (Time)');
subplot(3,1,1); grid on;
title('Discrete Time Signals');
tp = 0:(1/fs):0.01;
plot(tp,sd(1:length(tp)),tp,s(1:length(tp)));
legend({'Dithered','Normal'},'Fontsize',14);
xlabel('Time','Fontsize',14);ylabel('Amplitude','Fontsize',14);
subplot(3,1,2);
title('Quantization Error (Time)');
plot(tp,sqd(1:length(tp))-sd(1:length(tp)),tp,sq(1:length(tp))-s(1:length(tp)));
legend({'Dithered','Normal'},'Fontsize',14);
xlabel('Time','Fontsize',14);ylabel('Amplitude','Fontsize',14);
grid on;
subplot(3,1,3); hold on; grid on;
title('Quantization Error (Frequency)');
[px1,f1,pxxc1] = periodogram(sqd,'onesided',512);
[px2,f2,pxxc1] = periodogram(sq,'onesided',512,'r');
plot(f1,10*log10(px2),f1,10*log10(px1));
legend({'Normal','Dithered'},'Fontsize',14);
1;
end

function n = uniform_dither(N,k)
    n = 1/(2^(k))*(rand(N,1)-0.5);
end

function n = triangular_dither(N,k)
    n = 2/(2^(k))*(rand(N,1) + rand(N,1));
end

function n = gaussian_dither(N,k)
    n = 0.25/(2^(k))*randn(N,1);
end

function n = triangular_dither_mat(N,k)
    pd = makedist('Triangular','a',-1,'b',0,'c',1);
    n = 2/(2^(k))*random(pd,N,1);
end