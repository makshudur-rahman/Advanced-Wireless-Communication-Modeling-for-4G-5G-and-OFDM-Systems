clc;  
clear; 

d = 5; 
ht = 100; 
hr = 1; 
f = 900:100:1800; 

Ahr = (1.1*log(f) - 0.7)*hr - (1.56*log(f) - 0.8); 
PL = 69.55 + 26.16*log(f) - 13.83*log(ht) - Ahr + (44.9 - 6.55*log(ht))*log(d); 
disp(PL); 

subplot(2,1,1); 
plot(f, PL); 
title('Path-loss versus frequency'); 
xlabel('Frequency in MHz'); 
ylabel('Path Loss in dB'); 

d = 1:5:20; 
f = 900; 
Ahr = (1.1*log(f) - 0.7)*hr - (1.56*log(f) - 0.8); 
PL = 69.55 + 26.16*log(f) - 13.83*log(ht) - Ahr + (44.9 - 6.55*log(ht))*log(d); 
disp(PL); 

subplot(2,1,2); 
plot(d, PL); 
title('Pathloss versus distance'); 
xlabel('Distance in Km'); 
ylabel('Path Loss in dB'); 
