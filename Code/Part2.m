clc;
clear all;
close all;

fs = 512;
%% Constructing X1 signal

n1 = 0:1:512;
n2 = 513:1:1023;

x1_1 = 2*sin(20*pi*n1/fs) + sin(80*pi*n1/fs);
x1_2 = 0.5*sin(40*pi*n2/fs) + sin(60*pi*n2/fs);

x1 = [x1_1 x1_2];

figure('Name', 'DWT - X1 signal');
plot([n1 n2], x1);
xlim([0 1024]);
title('X1 - Signal'), xlabel('Time(s)'), ylabel('Amplitude');

%%  Constructing X2 signal

x2 = zeros(1, 1024);

for j = 1:1024
    i = j -1;
    
    if i >= 960
        x2(j) = 0;
    elseif i >= 704
        x2(j) = 1;
    elseif i >= 512
        x2(j) = 3;
    elseif i >= 256
        x2(j) = -1;
    elseif i >= 192
        x2(j) = 2;
    elseif i >= 64
        x2(j) = 0;
    elseif i >= 0
        x2(j) = 1;
    end
end

figure('Name', 'DWT - X2 signal');
plot(x2);
axis([0 1024 -1.5 3.5]);
title('X2 - Signal'), xlabel('Time(s)'), ylabel('Amplitude');

%% Corrupt the signal using white gaussian noise

y1 = awgn(x1, 10,'measured');
y2 = awgn(x2, 10,'measured');

figure('Name', 'DWT & Noise signal - X1 signal');
plot([n1 n2], x1, [n1 n2], y1);
xlim([0 1024]);
legend('Original Signal - X1', 'Noisy Signal - Y1'),
title('Noisy X1 - Signal'), xlabel('Time(s)'), ylabel('Amplitude');

n2 = 0:1:1023;
figure('Name', 'DWT & Noise signal - X2 signal');
plot(n2, x2, n2, y2);
axis([0 1024 -3.5 4.5]);
legend('Original Signal - X2', 'Noisy Signal - Y2'),
title('Noisy X2 - Signal'), xlabel('Time(s)'), ylabel('Amplitude');

%% Observing morphology of Haar and Daubechies tap 9 using wavefun()

% Harr Wavelet Application
wavlt = 'haar';
[phi_haar, psi_haar, xval_haar] = wavefun(wavlt, 10); 
figure ('Name','Haar Wavelet')
subplot(1,2,1);
plot(xval_haar, psi_haar, 'blue');
title('Wavelet Function of Haar');
subplot(1,2,2);
plot(xval_haar, phi_haar, 'red');
title('Scaling Function of Haar');

% Daubechies tap 9 Wavelet application
wavlt = 'db9';
[phi_deb,psi_deb, xval_deb] = wavefun(wavlt, 10); 
figure  ('Name','Daubechies tap-9 Wavelet')
subplot(1,2,1);
plot(xval_deb, psi_deb,'blue');
title('Wavelet Function of Daubechies tap 9');
subplot(1,2,2);
plot(xval_deb, phi_deb, 'red');
title('Scaling Function of Daubechies tap 9');

%% 10 level Wavelet Decomposition

% Signal Y1

% Haar Wavelet
[c_haar1, l_haar1] = wavedec(y1, 10, 'haar');
approx_haar1 = appcoef(c_haar1, l_haar1, 'haar');
[hD1,hD2,hD3,hD4,hD5,hD6,hD7,hD8,hD9,hD10] = detcoef(c_haar1, l_haar1, [1 2 3 4 5 6 7 8 9 10]);

figure('Name', 'Decomposition of y1(n) - Haar wavelet');
for i= 1:10
    haarD = detcoef(c_haar1, l_haar1, i);
    subplot(11,1,i);
    stem(haarD,'Marker','.');
    title(['Level ' num2str(i) 'Decomposition of y1(n) - Haar wavelet']);
end
subplot(11,1,11);
stem(approx_haar1);
title(['Level' num2str(10) 'Approximation Coefficients']);


%% Daubechies tap 9 Wavelet

[c_db1, l_db1] = wavedec(y1, 10, 'db9');
approx_db1 = appcoef(c_db1, l_db1, 'db9');
[dbD1,dbD2,dbD3,dbD4,dbD5,dbD6,dbD7,dbD8,dbD9,dbD10] = detcoef(c_db1, l_db1, [1 2 3 4 5 6 7 8 9 10]);

figure('Name', 'Decomposition of y1(n) - db9 wavelet');
for i= 1:10
    dbD = detcoef(c_db1, l_db1, i);
    subplot(11,1,i);
    stem(dbD,'Marker','.');
    title(['Level ' num2str(i) 'Decomposition of y1(n) - db9 wavelet']);
end
subplot(11,1,11);
stem(approx_db1);
title(['Level' num2str(10) 'Approximation Coefficients']);
%%

% Signal Y2
% Haar Wavelet 

[c_haar2, l_haar2] = wavedec(y2, 10, 'haar');
approx_haar2 = appcoef(c_haar2, l_haar2, 'haar');
[hD1_2,hD2_2,hD3_2,hD4_2,hD5_2,hD6_2,hD7_2,hD8_2,hD9_2,hD10_2] = detcoef(c_haar2, l_haar2, [1 2 3 4 5 6 7 8 9 10]);

figure('Name', 'Decomposition of y2(n) - Haar wavelet');
for i= 1:10
    haarD = detcoef(c_haar2, l_haar2, i);
    subplot(11,1,i);
    stem(haarD,'Marker','.');
    title(['Level ' num2str(i) 'Decomposition of y2(n) - Haar wavelet']);
end
subplot(11,1,11);
stem(approx_haar2);
title(['Level' num2str(10) 'Approximation Coefficients']);

%%  Daubechies tap 9 Wavelet

[c_db2, l_db2] = wavedec(y2, 10, 'db9');
approx_db2 = appcoef(c_db2, l_db2, 'db9');
[dbD1_2,dbD2_2,dbD3_2,dbD4_2,dbD5_2,dbD6_2,dbD7_2,dbD8_2,dbD9_2,dbD10_2] = detcoef(c_db2, l_db2, [1 2 3 4 5 6 7 8 9 10]);

figure('Name', 'Decomposition of y2(n) - db9 wavelet');
for i= 1:10
    dbD = detcoef(c_db2, l_db2, i);
    subplot(11,1,i);
    stem(dbD,'Marker','.');
    title(['Level ' num2str(i) 'Decomposition of y2(n) - db9 wavelet']);
end
subplot(11,1,11);
stem(approx_db1);
title(['Level' num2str(10) 'Approximation Coefficients']);

%% Discrete Wave Resconstruction
% X1 - haar
x1_haar_reconst = wave_reconst(approx_haar1,hD1,hD2,hD3,hD4,hD5,hD6,hD7,hD8,hD9,hD10,'haar');

figure('Name', 'Noisy x_1[n] reconstructed using Haar wavelet')
plot(n2, x1_haar_reconst);
title('Noisy x_1[n] reconstructed using Haar wavelet'), xlabel('Samples(n)'), ylabel('Amplitude');
xlim([0,1024]);

% X1 - db9
x1_db9_reconst = wave_reconst(approx_db1,dbD1,dbD2,dbD3,dbD4,dbD5,dbD6,dbD7,dbD8,dbD9,dbD10,'db9');

figure('Name', 'Noisy x_1[n] reconstructed using db9 wavelet')
plot(n2, x1_db9_reconst);
title('Noisy x_1[n] reconstructed using db9 wavelet'), xlabel('Samples(n)'), ylabel('Amplitude');
xlim([0,1024])

% X2 - haar
x2_haar_reconst = wave_reconst(approx_haar2,hD1_2,hD2_2,hD3_2,hD4_2,hD5_2,hD6_2,hD7_2,hD8_2,hD9_2,hD10_2,'haar');

figure('Name', 'Noisy x_2[n] reconstructed using Haar wavelet')
plot(n2, x2_haar_reconst);
title('Noisy x_2[n] reconstructed using Haar wavelet'), xlabel('Samples(n)'), ylabel('Amplitude');
xlim([0,1024])

% X2 - db9
x2_db9_reconst = wave_reconst(approx_db2,dbD1_2,dbD2_2,dbD3_2,dbD4_2,dbD5_2,dbD6_2,dbD7_2,dbD8_2,dbD9_2,dbD10_2,'db9');

figure('Name', 'Noisy x_2[n] reconstructed using db9 wavelet')
plot(n2, x2_db9_reconst);
title('Noisy x_2[n] reconstructed using db9 wavelet'), xlabel('Samples(n)'), ylabel('Amplitude');
xlim([0,1024])

%% Energy betweeen original and reconstructed signals

E_x1 = sum(abs(y1).^2);
E_x1_haar = sum(abs(x1_haar_reconst).^2);
E_x1_db9 = sum(abs(x1_db9_reconst).^2);
E_x2 = sum(abs(y2).^2);
E_x2_haar = sum(abs(x2_haar_reconst).^2);
E_x2_db9 = sum(abs(x2_db9_reconst).^2);

disp(['Energy of original X1 = ', num2str(E_x1)]);
disp(['Energy of Reconstructed X1 with haar wavelet = ', num2str(E_x1_haar)]);
disp(['Energy of Reconstructed X1 with db9 wavelet = ', num2str(E_x1_db9)]);
disp('------------------------------------------------------------------');
disp(['Energy of original X2 = ', num2str(E_x2)]);
disp(['Energy of Reconstructed X2 with haar wavelet = ', num2str(E_x2_haar)]);
disp(['Energy of Reconstructed X2 with db9 wavelet = ', num2str(E_x2_db9)]);

%% Signal Denoising - Plot coeffcients
% X1 haar
signalDenoising(x1, y1, 10, 'haar' , 1, 'X1');      %Threshold 1
% X1 db9s
signalDenoising(x1, y1, 10, 'db9', 1, 'X1');        %Threshold 1
% X2 haar
signalDenoising(x2, y2, 10, 'haar' , 2, 'X2');      %Threshold 2
% X2 db9
signalDenoising(x2, y2, 10, 'db9', 2, 'X2');        %Threshold 2

%% Signal Compression

load('ECGsig.mat');                     % Load the ideal ECG signal 
sig_len = length(aVR);

fs_ecg = 257;                           % sampling freqency of ecg
n  = 0:1:(sig_len-1);                   % samples

figure('Name', 'aVR Lead of ECG signal | fs = 257 Hz');
plot(n, aVR);
title('aVR Lead of ECG signal | fs = 257 Hz'), xlabel('Samples(n)'), ylabel('Voltage (mV)');
xlim([0 length(aVR)]);

% Obtain wavelet coefficients of aVR
% Haar Wavelet 

[c_haar_avr, l_haar_avr] = wavedec(aVR, 10, 'haar');
approx_haar_avr = appcoef(c_haar_avr, l_haar_avr, 'haar');

figure('Name', 'Decomposition of aVR signal - Haar wavelet');
for i= 1:10
    haarD_avr = detcoef(c_haar_avr, l_haar_avr, i);
    subplot(11,1,i);
    stem(haarD_avr,'Marker','.');
    title(['Level ' num2str(i) 'Decomposition of aVR signal - Haar wavelet']);
end
subplot(11,1,11);
stem(approx_haar_avr);
title(['Level' num2str(10) 'Approximation Coefficients']);

%%  Daubechies tap 9 Wavelet

[c_db_avr, l_db_avr] = wavedec(aVR, 10, 'db9');
approx_db_avr = appcoef(c_db_avr, l_db_avr, 'db9');

figure('Name', 'Decomposition of aVR signal - db9 wavelet');
for i= 1:10
    dbD_avr = detcoef(c_db_avr, l_db_avr, i);
    subplot(11,1,i);
    stem(dbD_avr,'Marker','.');
    title(['Level ' num2str(i) 'Decomposition of aVR signal - db9 wavelet']);
end
subplot(11,1,11);
stem(approx_db_avr);
title(['Level' num2str(10) 'Approximation Coefficients']);

%% Signal Compression
level = ceil(log2(sig_len));
percentage = 99;
% aVR - db9
signalCompression(aVR, level, 'db9' , percentage, 'aVR signal'); %overload the Denoise function to plot the graphs
%% aVR - haar
signalCompression(aVR, level, 'haar', percentage, 'aVR signal'); %Threshold 0 -> compression
