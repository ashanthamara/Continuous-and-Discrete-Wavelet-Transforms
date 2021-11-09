function signalCompression(x, levels, wavelet, thresh_percentage, sig_name)

[C, L] = wavedec(x, levels, wavelet);
% sorting the coefficients in decending order
C_sorted = sort(abs(C(:)),'descend');

% Plotting the sorted coefficients
figure('Name',['Sorted ' wavelet ' Wavelet Coefficients of ' sig_name ' - in descending order'])
stem(C_sorted);
xlim([0, length(C_sorted)])
title(['Sorted ' wavelet ' Wavelet Coefficients of ' sig_name ' - in descending order']);

cum_energy = 0;
no_of_selected_coef = 0;
total_energy = sum((C_sorted).^2);

for i=1:length(C_sorted)
    cum_energy = cum_energy + (C_sorted(i)).^2;
    if (round(cum_energy/total_energy, 2) == thresh_percentage/100)
        no_of_selected_coef = i;
        break;
    end
end

disp(['Number coefficients wrequired to represent 99% of the energy of the signal = ' num2str(no_of_selected_coef)]);

comp_ratio = length(C)/no_of_selected_coef;
disp(['Compression Ratio = ' num2str(comp_ratio)]);

Threshold = C_sorted(no_of_selected_coef);


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
lenY = length(x);
N = 1:1:lenY;

figure ('Name', [sig_name ' reconstructed with ' wavelet]);
plot(N, x_reconst);
xlim([0 lenY]);
title([sig_name ' reconstructed with ' wavelet]), xlabel('Samples(n)'), ylabel('Amplitude');

% Calculating the Root mean square error between the original and the reconstructed signal
rmse = immse(x, x_reconst);
disp(['RMSE of ' sig_name ' reconstructed with ' wavelet ' wavelet = ' num2str(rmse)]);

% Comparing the original and the reconstructed signal
figure('Name',['Comparing original and reconstructed ' sig_name ' with ' wavelet ])

plot(N, x, 'r', N, x_reconst, 'b')
xlim([0 lenY]);
title(['Comparing original and reconstructed ' sig_name ' with ' wavelet ]), xlabel('Samples(n)'), ylabel('Amplitude');
legend(sig_name, ['Reconstructed ' sig_name])
end