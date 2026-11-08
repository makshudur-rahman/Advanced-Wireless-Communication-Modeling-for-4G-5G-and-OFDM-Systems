clc;
clear;
close;
data = [1 0 1 0 1 1 0 0];
spreadingCode = [1 1 0 1];
spreadingFactor = length(spreadingCode);
modulatedSignal = [];
for i = 1:length(data)
    chips = repmat(data(i), 1, spreadingFactor) .* spreadingCode;
    modulatedSignal = [modulatedSignal chips];
end
demodulatedSignal = [];
for i = 1:length(modulatedSignal)/spreadingFactor
    chips = modulatedSignal((i-1)*spreadingFactor+1:i*spreadingFactor);
    chipSum = sum(chips);
    if chipSum >= spreadingFactor/2
        demodulatedSignal = [demodulatedSignal 1];
    else
        demodulatedSignal = [demodulatedSignal 0];
    end
end
disp('Original Data:');
disp(data);
disp('Demodulated Data:');
disp(demodulatedSignal);
