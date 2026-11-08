clc;

numUsers = 4; 
timeSlotDuration = 1; % seconds 
totalTimeSlots = 10; 
channelGain = 0.8; 

userData = randi([0, 1], numUsers, totalTimeSlots); 

timeSlots = linspace(0, timeSlotDuration*totalTimeSlots, totalTimeSlots); 

userSlots = mod(0:totalTimeSlots-1, numUsers) + 1; 

receivedData = zeros(numUsers, totalTimeSlots); 
for slot = 1:totalTimeSlots 
    for user = 1:numUsers 
        if userSlots(slot) == user 
            transmittedData = userData(user, slot); 
            receivedData(user, slot) = transmittedData * channelGain; 
        end 
    end 
end 

bitErrorRate = sum(sum(xor(receivedData, userData))) / (numUsers * totalTimeSlots); 

figure; 
subplot(2, 1, 1); 
stem(timeSlots, userData'); 
title('User Traffic'); 
xlabel('Time (s)'); 
ylabel('Data'); 
legend('User 1', 'User 2', 'User 3', 'User 4'); 

subplot(2, 1, 2); 
stem(timeSlots, receivedData'); 
title('Received Data'); 
xlabel('Time (s)'); 
ylabel('Data'); 
legend('User 1', 'User 2', 'User 3', 'User 4'); 

disp(['Bit Error Rate: ', num2str(bitErrorRate)]);
