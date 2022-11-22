% Time and Range Calculations for each segment
S = 1.086;
CD_0 = 0.0219;
rho = 1.225;

AR = 13.3;
e = 1.78 * (1 - 0.045*AR^0.68) - 0.64;
K = 1/(3.14*e*AR);

m = 8.34;
g = 9.81;

mu = 0.02; % coeff of rolling friction
V_max = 16;

% Taxi 

v = V_max;
CD = CD_0;
T_min = 0.5*rho*S*CD*v^2 + mu*m*g;

T = [6:0.5:14];
a = T/m - mu*g;
b = rho*S*CD/(2*m);
m = sqrt(a/b);

t_taxi = 1./(2*m*b).*log((m+v)./(m-v))/log(exp(1));
s_taxi = 1/(2*b)*log((m.^2)./(m.^2-V^2))/log(exp(1));

% PLOTS

figure(1);

plot(T,t_taxi,'ro-');
hold on
xline(T_min,'k--');
hold off
%xlim([5,13]);
xlabel('Thrust T (N)');
ylabel('Taxi time (s)');
%legend([''],['']);
grid();

figure(2);

plot(T,s_taxi,'bo-');
hold on
xline(T_min,'k--');
hold off
%xlim([5,13]);
xlabel('Thrust T (N)');
ylabel('Taxi distance (m)');
%legend([''],['']);
grid();

