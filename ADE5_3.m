clc;
clear;
close all;
channel_length = 10;
snr_db = 20;
num_symbols = 1000;
mu = 0.01;

data_symbols = randi([0 1], 1, num_symbols);
modulated_symbols = 2 * data_symbols - 1;

channel = (randn(1, channel_length) + 1i * randn(1, channel_length)) / sqrt(2);
received_symbols = filter(channel, 1, modulated_symbols);

noise_power = 10^(-snr_db / 10);
noise = sqrt(noise_power) * (randn(1, length(received_symbols)) + 1i * randn(1, length(received_symbols)));
received_symbols_noisy = received_symbols + noise;

equalizer_length = channel_length;
equalizer = zeros(1, equalizer_length);
output_signal = zeros(1, length(received_symbols_noisy));

for i = equalizer_length:length(received_symbols_noisy)
    received_window = received_symbols_noisy(i:-1:i-equalizer_length+1);
    output_signal(i) = equalizer * received_window.';
    error = modulated_symbols(i) - output_signal(i);
    equalizer = equalizer + mu * conj(error) * received_window;
end

demodulated_symbols = real(output_signal) > 0;
ber = sum(data_symbols ~= demodulated_symbols) / num_symbols;
disp(['Bit Error Rate (BER): ' num2str(ber)]);
