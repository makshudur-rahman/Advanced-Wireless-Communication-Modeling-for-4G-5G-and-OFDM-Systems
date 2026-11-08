clc; 
clear;
close:

freq = [900e6; 1800e6; 2700e6]; 
vel = 120;                      
c = 3e8;                        
r = 1;                           

for x = 1:3
    fm(x) = (vel*1000/3600) * freq(x) / c;  % Doppler frequency in Hz
    Nr(x) = sqrt(2*pi)*fm(x)*r*exp(-r^2);
    FD(x) = exp(-1)/(r*fm(x)*sqrt(2*pi));
end

disp('Doppler Frequencies (Hz):');
disp(fm);
disp('Nr values:');
disp(Nr);
disp('FD values:');
disp(FD);
