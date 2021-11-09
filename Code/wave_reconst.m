function reconst_sig = wave_reconst(A10,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,wavelet)
    
    A9 = idwt(A10,D10,wavelet);
    A8 = idwt(A9,D9,wavelet);
    A7 = idwt(A8,D8,wavelet);
    A6 = idwt(A7,D7,wavelet);
    A5 = idwt(A6,D6,wavelet);
    A4 = idwt(A5,D5,wavelet);
    if wavelet == "haar"
       A3 = idwt(A4,D4,wavelet); 
    else
       A3 = idwt(A4(1:79),D4,wavelet); 
    end
    A2 = idwt(A3,D3,wavelet);
    A1 = idwt(A2,D2,wavelet);
    
    reconst_sig = idwt(A1,D1,wavelet);
end