clc;
clear;
close all;
h = [0.1 0.3 0.4 0.2];
N = 100;
symbols = randi([0 1], 1, N);

received_signal = conv(symbols, h);
snr_dB = 20;
received_signal = awgn(received_signal, snr_dB, 'measured');

L = length(h);
equalizer_taps = zeros(1, L);
equalized_symbols = zeros(1, N);

for n = 1:N
    if n+L-1 > length(received_signal)
        break
    end
    received_symbols = received_signal(n:n+L-1);
    equalized_symbols(n) = equalizer_taps * received_symbols';
    error = symbols(n) - equalized_symbols(n);
    equalizer_taps = equalizer_taps + error * received_symbols / (received_symbols * received_symbols');
end

disp('Original Symbols:');
disp(symbols);
disp('Equalized Symbols:');
disp(equalized_symbols);
