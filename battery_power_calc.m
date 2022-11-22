% Power Requirements for each segment

CD0 = 0.0219;
S = 1.086;
rho = 1.225;
m = 8.34;
g = 9.81;
AR = 13.3;
e = 1.78 * (1 - 0.045*AR^0.68) - 0.64;
K = 1/(3.14*e*AR);

% Taxi
T_taxi = 11; % Thrust (in N)
V_taxi = 12;
CD = CD0;

P_taxi = 0.5*T_taxi*V_taxi;


% Climb 
V_climb = 12;
gamma = deg2rad(5); % climb angle
CL = (2*m*g*cos(gamma))/(rho*S*V_climb^2);
CD = CD0 + K*CL^2;

P_climb = 0.5*rho*S*CD*V_climb^3 + m*g*V_climb*sin(gamma);


% Cruise
V_cruise = 12;
CL = (2*m*g)/(rho*S*V_cruise^2);
CD = CD0 + K*CL^2;

P_cruise = 0.5*rho*S*CD*V_cruise^3;

% Descent
P_descent = 0.1*P_climb; % glide flight

% Taxi 2
P_taxi_2 = 0;


% Total power consumption
P_total = P_taxi + P_climb + P_cruise + P_descent + P_taxi_2;

t = [17,36,12474,56,17];

% Total energy consumption (in W-h)
E_total = (P_taxi*t(1) + P_climb*t(2) + P_cruise*t(3) + P_descent*t(4) + P_taxi_2*t(5)) / 3600;

% Accounting for losses during conversion

n_prop = 0.8; % Propeller efficiency
n_motor = 0.8; % Motor efficiency
n_ESC = 0.7; % Electronic Speed Control efficiency
n_batt_discharge = 0.8; % Battery discharge efficiency

n_total = n_prop * n_motor * n_ESC * n_batt_discharge;

P_total_1 = P_total/n_total;
E_total_1 = E_total/n_total;

% 2nd circuit calculations - Battery to solar cells

n_solar_encapsulation = 0.9; % Solar Encapsulation
n_solar_cells = 0.22; % Solar Cells Efficiency
n_camber = 0.9; % camber efficiency
n_MPPT = 0.9; % Maximum Power Point Tracking Efficiency
n_battery_charging = 0.9; % Battery Charging Efficiency

n_total_2 = n_solar_encapsulation * n_solar_cells * n_camber * n_MPPT * n_battery_charging; 

P_total_new = P_total_1/n_total_2; % 6637.7 W - We need this much total power, after factoring in losses & solar efficiencies.

batt_density = 275; % W-h/kg
W_batt = E_total_1 / batt_density; % (2.91 kg)

% No. of solar panels calculation:
I_av = 2.193e04; % average irradiance 
P_av = P_total_new;
A_1s = 0.0155; % area of 1 solar panel

n_panels = P_av/(I_av * A_1s); % 19.53, close to 20 panels!
