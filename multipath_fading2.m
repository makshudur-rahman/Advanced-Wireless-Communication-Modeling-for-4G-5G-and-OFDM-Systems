clc;
clear;
close all;
numSamples = 1000; 
numPaths = 3; 
fadePower = 0.5;
 
h = sqrt(fadePower/2)*(randn(numPaths, numSamples) + 1i*randn(numPaths, numSamples)); 
txSignal = randn(1, numSamples) + 1i*randn(1, numSamples); 
rxSignal = zeros(1, numSamples); 
for path = 1:numPaths 
    rxSignal = rxSignal + h(path, :) .* txSignal; 
end 
t = 1:numSamples; 

figure; 
subplot(2,1,1); 
plot(t, real(txSignal), 'b', t, imag(txSignal), 'r'); 
title('Transmitted Signal'); 
legend('In-phase', 'Quadrature'); 
xlabel('Time'); 
ylabel('Amplitude');  
subplot(2,1,2); 
plot(t, real(rxSignal), 'b', t, imag(rxSignal), 'r'); 
title('Received Signal'); 
legend('In-phase', 'Quadrature'); 
xlabel('Time'); 
ylabel('Amplitude');