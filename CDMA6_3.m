clc; 
clear; 
close all;

numBits = 1000; 
chipRate = 1e6; 
snr = 10; 

user1Bits = randi([0, 1], 1, numBits); 
user2Bits = randi([0, 1], 1, numBits); 

user1Symbols = 2 * user1Bits - 1; 
user2Symbols = 2 * user2Bits - 1; 

chipSequence = [1, -1, 1, 1, -1, 1, -1, -1]; 
user1SpreadSymbols = kron(user1Symbols, chipSequence); 
user2SpreadSymbols = kron(user2Symbols, chipSequence); 

noiseVar = 10^(-snr/10); 
user1NoisySymbols = user1SpreadSymbols + sqrt(noiseVar/2) * randn(1,length(user1SpreadSymbols)); 
user2NoisySymbols = user2SpreadSymbols + sqrt(noiseVar/2) * randn(1,length(user2SpreadSymbols)); 

user1FilteredSymbols = filter(fliplr(chipSequence), 1, user1NoisySymbols); 
user2FilteredSymbols = filter(fliplr(chipSequence), 1, user2NoisySymbols); 

user1DetectedBits = user1FilteredSymbols(1:length(user1Symbols)) > 0; 
user2DetectedBits = user2FilteredSymbols(1:length(user2Symbols)) > 0; 

berUser1 = sum(user1DetectedBits ~= user1Bits) / numBits; 
berUser2 = sum(user2DetectedBits ~= user2Bits) / numBits; 

disp(['User 1 BER: ', num2str(berUser1)]); 
disp(['User 2 BER: ', num2str(berUser2)]);
