% Fuselage Length Estimation
% Silent Falcon, Atlantik Solar, Sky-Sailor, Sun-Sailor, MARAAL-2, 
% Solong UAV, EAV-1, Hybrid Tiger

W = [12.3, 8.16, 2.5, 3.6, 12, 12.6, 7, 16]; 
L = [2.41, 3.16, 1.80, 2.37, 3.02, 2.68, 1.53, 3.21];

figure(1);
x1 = linspace(0,20,100);
a = 1.463; b = 0.2575;
y1 = a * x1 .^ b;

plot(W,L,'ro');
hold on 
plot(x1,y1,'b-');
hold off

caption = sprintf('L = %0.4g W^{%0.4g}', a, b);
text(6, 2.2, caption,'Color', 'b');

xlim([0,18]);
ylim([1,3.5]);
xlabel('Maximum Take-off Weight W_0 (kg)');
ylabel('Fuselage Length L (m)');
legend(['L values'],['Power Function Fit']);
grid();





