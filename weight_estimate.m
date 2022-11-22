w_0 = [12.3 8.16 2.5 3.6 12 12.6 7 16];

w_batt_ratio = [0.41 0.43 0.28 0.31 0.41 0.44 0.402 0.37];

w_empty_ratio = [0.48 0.47 0.62 0.583 0.48 0.51 0.466 0.46];

endurance = [12 40 28 11 11 48 4.5 26];

figure(1);
x1 = linspace(0,20,100);
a = 0.6969; b = -0.1546;
y1 = a * x1 .^ b;

plot(w_0,w_empty_ratio,'ro');
hold on 
plot(x1,y1,'b-');
hold off

caption = sprintf('W_e/W_0 = %0.5gW_0^{%0.5g}', a, b);
text(6, 0.55, caption,'Color', 'b');

ylim([0.35,0.75]);
xlabel('Maximum Take-off Weight W_0 (kg)');
ylabel('W_e/W_0');
legend(['W_e/W_0 values'],['Power Function Fit']);
grid();

%%%%%%

figure(2);

x = linspace(0,60,100);
p1 = 0.0009237; p2 = 0.3607;
y = p1 * x + p2;

plot(endurance,w_batt_ratio,'ro');
hold on 
plot(x,y,'b-');
hold off

caption = sprintf('W_b/W_0 = %0.5gE + %0.5g', p1, p2);
text(31, 0.36, caption,'Color', 'b');


xlim([0,60]);
ylim([0.15,0.55]);
xlabel('Endurance (hrs)');
ylabel('Battery Weight Fraction W_b/W_0');
legend(['W_b/W_0 values'],['Linear Fit']);
grid();
