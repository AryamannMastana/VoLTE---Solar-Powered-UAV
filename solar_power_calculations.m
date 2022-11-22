% Solar Power Calculations - Total daily solar power available

n = 121; % For May 1st, 2022
phi = deg2rad(12.992); % Latitude of Chennai, India
I_sc = 1367; % Solar Constant (W/m^2)

% declination angle
delta = deg2rad(23.45 * sin(360*(284+n)/365));

% hour angle
omega_s = (acos(tan(phi)*tan(delta)));

% Daily Average Irradiance (kJ/m^2-day)
H_0 = 24/3.14 * I_sc * 36 * (1 + 0.033*cos(360*n/365)) * ((omega_s)*sin(phi)*sin(delta) + sin(omega_s)*cos(phi)*cos(delta));

% Maximum Sunshine Hours / Day length
S_max = rad2deg(2/15 * acos(-tan(phi)*tan(delta)));

% Monthly average daily global radiation 

E = 6.7; % Elevation above sea level for Chennai
S = 9.71; % Average sunshine hours per day in Chennai in May

a = -0.309 + 0.539*cos(phi) - 0.06393*E + 0.29*(S/S_max);
b = 1.527 - 1.027*cos(phi) + 0.0926*E - 0.359*(S/S_max);
H = H_0 * (a + b * (S/S_max)); % Monthly average daily global radiation

% Hourly global solar irradiance calculations

h = (1:24); % Number of hour of day
omega = deg2rad(15*h - 180); % instantaneous hour angle for a particular hour

c = 0.409 + 0.516*sin(omega_s-1.047);
d = 0.6609 - 0.4767*sin(omega_s-1.047); 

% Global radiation
I_g = H * 3.14/24 * (c + d*cos(omega)).*(cos(omega) - cos(omega_s))./(sin(omega_s) - 3.14*(omega_s)/180 * cos(omega_s));
% Estimated radiation
N_sky = 0.7;
I_g_est = I_g * N_sky;

I_g(1:5) = 0;
I_g(19:24) = 0;
I_g_est(1:5) = 0;
I_g_est(19:24) = 0;

% PLOTS

figure(1);

plot(h,I_g,'ro-','MarkerSize',5);
hold on 
plot(h,I_g_est,'bo-','MarkerSize',5);
hold on
yline(275,'m--', 'LineWidth',1.1);
xline(10,'k:');
xline(14,'k:');
yline(21.9304e+03,'k:');
hold off
ylim([0,4.5*10^4]);
xlabel('Hour number (h)');
ylabel('Solar irradiance (W/m^2)');
legend(['Global irradiance'],['Estimated irradiance'],['Average Power Required']);
grid();
