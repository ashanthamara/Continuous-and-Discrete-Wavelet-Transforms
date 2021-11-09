close all; 
clc;

fs = 250;               % Sample frequency
N = 3000;               % Data length
time = (-N:N)/fs;       % Time scale
scale = 0.01:0.1:2;     % Values of scaling factor

%%
% for daughter wavelets
wavelt = zeros(length(time), length(scale));

wavelt_mean = zeros(1,length(scale));
wavelt_energy = zeros(1,length(scale));

syms x;
syms y;

% Maxican hat wavelet
figure('Name','Daughter Wavelet');
for k = 1:length(scale)
    wavelt(:, k) = (2/(sqrt(3*scale(k))*pi^(1/4)))*(1-(time/scale(k)).^2).*exp(-(time/scale(k)).^2 /2);
    
    ax = subplot(5,4,k);
    plot(time, wavelt(:, k));
    axis([-5 5 -1.5 3]);
    title(['Scale = ', num2str(scale(k))]);
    xlabel('Time(s)'), ylabel('Amplitude');

    wavelt_mean(k) = int((2/((sqrt(3*scale(k)))*(pi^(1/4))))*(1-((x/scale(k)).^2)).*exp((-1/2)*(x/scale(k)).^2), 'x', -inf, inf);
    wavelt_energy(k) =  int(((2/((sqrt(3*scale(k)))*(pi^(1/4))))*(1-((y/scale(k)).^2)).*exp((-1/2)*(y/scale(k)).^2))^2, 'y', -inf, inf);
end
%scaling the coef 1
ax = subplot(5,4,1);
axis([-1 1 -3.5 5]);


%% ploting mean and energy
figure('Name','Mean and Energy');
scatter(scale, wavelt_mean);
hold on;
scatter(scale, wavelt_energy);
hold off;
axis([0 2 -0.5 1.5]);
title('Mean and Energy');
legend('Mean', 'Energy'), xlabel('Scale Factor'), ylabel('Amplitude');


%%
% Generating Spectra of wavelets
figure('Name', 'Spectra of Daughter Wavelets');

for i = 1:length(scale)
    Fwavelt = fft(wavelt(:, i))/length(wavelt(:, i));
    hz = linspace(0,fs/2,floor(length(wavelt(:, i))/2)+1);
    
    ax = subplot(5,4,i);
    plot(hz,2*abs(Fwavelt(1:length(hz))))
    %axis([0 5 0 0.2]);
    title(['Scale = ', num2str(scale(i))]), xlabel('Frequency (Hz)'), ylabel('Amplitude')
end