clc;
totalBandwidth = 10e6; 
numUsers = 5; 
carrierFrequency = 1e6; 
userBandwidth = totalBandwidth / numUsers; 

samplingFrequency = 100e6; 
timeDuration = 1e-3; 
time = 0:1/samplingFrequency:timeDuration; 

userSignals = zeros(numUsers, length(time)); 
for i = 1:numUsers 
    userFrequency = carrierFrequency + (i-1) * userBandwidth; 
    userSignals(i, :) = sin(2*pi*userFrequency*time); 
end 

fdmaSignal = sum(userSignals, 1); 

snr = 10; 
noisySignal = awgn(fdmaSignal, snr, 'measured'); 

demodulatedSignals = zeros(numUsers, length(time)); 
for i = 1:numUsers 
    userFrequency = carrierFrequency + (i-1) * userBandwidth; 
    demodulatedSignals(i, :) = noisySignal .* sin(2*pi*userFrequency*time); 
end 

figure; 
subplot(numUsers+1, 1, 1); 
plot(time, fdmaSignal); 
title('FDMA Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 

for i = 1:numUsers 
    subplot(numUsers+1, 1, i+1); 
    plot(time, demodulatedSignals(i, :)); 
    title(['Demodulated Signal - User ', num2str(i)]); 
    xlabel('Time (s)'); 
    ylabel('Amplitude'); 
end
