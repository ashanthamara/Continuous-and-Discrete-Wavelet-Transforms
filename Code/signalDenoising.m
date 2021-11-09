function signalDenoising(x, y, levels, wavelet, Threshold, sig_name)

[C, L] = wavedec(y, levels, wavelet);
% sorting the coefficients in decending order
C_sorted = sort(abs(C(:)),'descend');

% Plotting the sorted coefficients
figure('Name',['Sorted ' wavelet ' Wavelet Coefficients of ' sig_name ' - in descending order'])
stem(C_sorted);
xlim([0, length(C_sorted)])
title(['Sorted ' wavelet ' Wavelet Coefficients of ' sig_name ' - in descending order']);


C_selected = C;
% neglecting the noisy coefficents
for k = 1:length(C_selected)
    if (abs(C_selected(k)) < Threshold)
        C_selected(k) = 0;
    end
end

% reconstruct the signal with the remaining coefficients
x_reconst = waverec(C_selected, L, wavelet);

% plotting the reconstructed signal 
lenY = length(y);
N = 1:1:lenY;

figure ('Name', [sig_name ' reconstructed with ' wavelet]);
plot(N, x_reconst);
xlim([0 lenY]);
title([sig_name ' reconstructed with ' wavelet]), xlabel('Samples(n)'), ylabel('Amplitude');

% Calculating the Root mean square error between the original and the reconstructed signal
%rmse = immse(x, x_reconst);
error = x - x_reconst;   
rmse = sqrt(sum(abs(error).^2)/length(error));
%disp(RMSE);
disp(['RMSE of ' sig_name ' reconstructed with ' wavelet ' wavelet = ' num2str(rmse)]);

% Comparing the original and the reconstructed signal
figure('Name',['Comparing original and reconstructed ' sig_name ' with ' wavelet ])

plot(N, x, 'r', N, x_reconst, 'b')
xlim([0 lenY]);
title(['Comparing original and reconstructed ' sig_name ' with ' wavelet ]), xlabel('Samples(n)'), ylabel('Amplitude');
legend(sig_name, ['Reconstructed ' sig_name])
end