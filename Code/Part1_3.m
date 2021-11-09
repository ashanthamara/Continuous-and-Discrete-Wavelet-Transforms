clear all;
close all;
clc;

fs = 250;           % Sample frequency
N = 3000;           % Data length
time = (-N:N)/fs;      % Time scale
scale = 0.01:0.01:2;     % Values of scaling factor       

%% creating the waveform
n_1 = 1:1:3*N/2 -1;
n_2 = 3*N/2:1:3*N;

sig_1 = sin(0.5*pi*n_1/fs);
sig_2 = sin(1.5*pi*n_2/fs);

sig = [sig_1 sig_2];

n = 1:1:3*N;

figure('Name','CWT Signal - x[n]')
plot(n, sig, 'k');
%scatter(n, sig);
title('Signal x[n]'),xlabel('n'),ylabel('Amplitude');

%% Continuous Wavelet Decomposition

scale_2 = 0.01:0.01:2;
n = 1:1:3*N;

cwt_vals = zeros(length(scale_2), length(n));

for i = 1:length(scale_2)
    wavelt = (2/(sqrt(3*scale_2(i))*pi^(1/4)))*(1-(time/scale_2(i)).^2).*exp(-(time/scale_2(i)).^2 /2);
    conv_sig = conv(sig, wavelt, 'same');
    
    cwt_vals(i,:) = conv_sig;
end
%%
% Ploting the spectrogram
h = pcolor(n, scale_2, cwt_vals);
set(h, 'EdgeColor', 'none');
colormap jet
xlabel('Time (s)')
ylabel('Scale')
title('Spectrogram x(n)')