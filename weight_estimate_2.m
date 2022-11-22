clc; clear all; close;

a = 0.5635;
b = -0.0624;
c = 1.0417;
d = 0.3403;

w = 7;
w_new = [];

%E = 4;
%W_batt_ratio = 0.0009237*E + 0.3607;

W_P = 0.6;

% for i = 1:10
%     w_new(i) = 1.05 ./ (1 - W_batt_ratio - (a*(w.^c)));
%     w = w_new(i);
% end

for i = 1:10
    w_new(i) = (c + W_P + a*w.^(b+1))/(1 - d);
    w = w_new(i);
end

w_final = [7,w_new];
w_new

figure(1);

plot(w_final,'b-')
xlabel('Number of iterations');
ylabel('W_0 (kg)');
grid();