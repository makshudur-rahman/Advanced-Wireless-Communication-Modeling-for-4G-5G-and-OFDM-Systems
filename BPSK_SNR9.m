clc; 
clear; 
close all;

a6 = 1000;
a = rand(a6,1);
b = round(a);
m = 2;

sx = pskmod(b,m);
snr = -15:2:0;

berSim = zeros(size(snr));

for i = 1:length(snr)
    rxsx = awgn(sx, snr(i), 'measured');
    demodSig = pskdemod(rxsx, m);
    [~, berSim(i)] = biterr(b, demodSig);
end

berTh = berawgn(snr, 'psk', m, 'nondiff');

figure;
semilogy(snr, berSim, 'o-', 'LineWidth', 1.5); hold on;
semilogy(snr, berTh, 'r--', 'LineWidth', 1.5);
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
legend('Simulated BER', 'Theoretical BER', 'Location', 'southwest');
title('BER vs SNR for BPSK (AWGN Channel)');