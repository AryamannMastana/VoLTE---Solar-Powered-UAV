% Wing Loading Calculations

AR = 13.3;
b = 3.8;
c = 0.286;
nu = 1.789 * 10^-5;
m_0 = 8;
g = 9.81;
V_cruise = 16;
CL_max = 1.35;
S = 1.086;
CD_0 = 0.0219;
rho = 1.225;

e = 1.78 * (1 - 0.045*AR^0.68) - 0.64;
K = 1/(3.14*e*AR);
q = 0.5 * rho * V_cruise^2;

% Stall Velocity

V_stall = sqrt(2*m_0*g/rho*S*CL_max);

% Drag Polar Approximations

Re = rho * V_cruise * c / nu;
C_fe = (2*log(Re)-0.65)^(-2.3);

S_ht = 0.28; 
S_vt = 0.28;
K_t = 1 + (S_ht/S) + (S_vt/S); 

S_wet = 0.04125 * m_0 + 4.46529; % relation b/w wetted area and MTOW

p_old = m_0*g/S; % old wing loading

F_1 = K_t * C_fe * S_wet / S;
F_2 = (CD_0 - F_1) / p_old;
F_3 = K / q^2;

p = linspace(0,200,500);

% W/S based on stall constraint
p_stall = 0.5 * rho * V_stall^2 * CL_max;

% W/S based on V_cruise constraint
p_cruise = q * sqrt(CD_0/K);

% T/W based on absolute ceiling
V_max = 16; % maximum ceiling velocity (at h = 50m)
q_max = 0.5 * rho * V_max^2; 
T_ceiling = 2*q_max*(F_1./p + F_2);

% W/S based on landing distance constraint
S_land = 30; % landing distance
V_app = sqrt(S_land/0.35); % approach velocity
V_stall_land = V_app / 1.3; % stall velocity during landing

p_land = 0.5 * rho * V_stall_land^2 * CL_max; 

% T/W based on rate of climb
V_roc = 1.4; % rate of climb velocity
T_roc = (V_roc/V_cruise) + q*(F_1 + F_2*p + F_3*p.^2)./p;

% PLOTS

figure(1);

orange = [0.8500 0.3250 0.0980];
purple = [0.4940 0.1840 0.5560];

hold on 
xline(p_stall,'g--','LineWidth',1.2);
xline(p_cruise,'r--','LineWidth',1.2);
plot(T_ceiling,'b-','LineWidth',1);
xline(p_land,'--','Color', purple, 'LineWidth',1.2);
plot(T_roc,'-','Color', orange,'LineWidth',1);
hold off

xlim([0,210]);
ylim([0,1.5]);
xlabel('Wing Loading (W/S)');
ylabel('Thrust Loading (T/W)');
legend(['Stall constraint'],['Cruise constraint'],['Ceiling constraint'],['Landing constraint'],['Rate of climb constraint']);
grid();
