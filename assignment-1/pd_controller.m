%
% Assignment 1 - Attitude control with PID-controller
%
% Problem II: PD Controller
%
% Goal: On successful completion of the assignment the student shall
%   - be able to use Control system toolbox in MATLAB/Simulink for analysis
%     of simple control systems.
%   - be able to set up simple transfer functions using Laplace-transforms.
%   - be familiar with attitude control with an ideal actuator, ideal
%     sensors and a simple controller.
%   - know some common control system performance metrics
%     (transient analysis).
%   - know the role of the three parts of a PID-controller .
%
% Version: 1.0
%
% Authors:
%   - Georges L. J. Labreche <geolab-7@student.ltu.se>
%   - Natalie Lawton <natlaw-7@student.ltu.se>
%
clear all 
close all
clc

% Init
plot_visibility = 'on';

% If an image export directory doesn't exist, create it.
if ~exist('exports', 'dir')
    mkdir('exports');
end

% Specify a transfer function model using a rational function in the
% Laplace variable, s.
s = tf('s');

%%%%
% b) Set up the transfer function of the system in Fig.2 in MATLAB 
% using a polynomial in s or the tfcommand. Normalize I to unity (I=1). 
%%%%

% Variables for the transfer function.
I = 1; % Normalize I to unity.
K = 1 / I; % The Gain as defined in Figure 1.

% Define time sample for our plots from t=0 to 20s.
timesample = (0:0.25:20);

% Build the plot testing different values for parameter Kd.
% Define the figure.
fig_test_kd = figure;
set(fig_test_kd, 'NumberTitle', 'on', ...
    'Name', 'Different Values for Parameter Kd', ...
    'Visible', plot_visibility);

% Test different settings of the parameter Kd for K=1.
for Kd = 0.5:0.5:3 
    % Define the transfer function.
    H = (K/I) / (s^2 + (Kd*s)/I + K / 1);
    
    % Plot
    hold on
    stepplot(H, timesample);
    hold off
end

% Export the plot as a png file.
print('exports/fig-test-kd', '-dpng');

% Build the plot testing different values for parameter K.
% Define the figure.
fig_test_k = figure;
set(fig_test_k, 'NumberTitle', 'on', ...
    'Name', 'Different Values for Parameter K', ...
    'Visible', plot_visibility);

% Test different settings of the parameter K for Kd=1. 
Kd = 1;
for K = 0.5:0.5:3
    % Define the transfer function.
    H = (K/I) / (s^2 + (Kd*s)/I + K / 1);
    
    % Plot
    hold on
    stepplot(H, timesample);
    hold off
end

% Export the plot as a png file.
print('exports/fig-test-k', '-dpng');

%%%%
% c) Use damping of 0.2, 0.5, 0.7, 1, 2 and 5.
%%%%

% Define the figure.
fig_predef_vals_kd = figure;
set(fig_predef_vals_kd, 'NumberTitle', 'on', ...
    'Name', 'Predefined Values for Parameter Kd', ...
    'Visible', plot_visibility);

% Plot different values of the parameter Kd for K=1. 
K = 1;

% Normalize I to unity.
I = 1;

% Natural frequence
omega_n = 1;

% For predefined damping values zeta.
for zeta = [0.2, 0.5, 0.7, 1, 2, 5]
    
    % Calculate Kd.
    % I=1 and omega_n=1, euivalent to Kd = 2 * zeta.
    Kd = I * 2 * zeta * omega_n;
    
    % Define the transfer function.
    H = (K/I) / (s^2 + (Kd*s)/I + K / 1);
    
    % Plot
    hold on
    stepplot(H, timesample);
    hold off
end

% Export the plot as a png file.
print('exports/fig-predef-kd', '-dpng');

% For K, this means a constant value of 1.

% Define the figure.
fig_predef_vals_k = figure;
set(fig_predef_vals_k, 'NumberTitle', 'on', ...
    'Name', 'Predefined Values for Parameter K', ...
    'Visible', plot_visibility);

% K will always be 1 and we set Kd to 1.
K=1;
Kd=1;

% Define the transfer function.
H = (K/I) / (s^2 + (Kd*s)/I + K / 1);
stepplot(H, timesample);

% Export the plot as a png file.
print('exports/fig-predef-k', '-dpng');


%%%%
% e) Transient Analysis
%%%%

K=1;
for zeta = [0.2, 0.5, 0.7, 1, 2, 5]
    % Kd = I * 2 * zeta * omega_n with I=1 & omega_n=1 thus Kd = 2 * zeta.
    Kd = 2 * zeta;  
    
    % Delay Time: Time needed for the response to reach 50% of its final value
    % the first time.
    Td = (1 + 0.7 * zeta) / omega_n;

    % Rise Time: Time needed for the response to rise from (10% to 90%) or 
    % (0% to 100%) or (5% to 95%) of its final value.
    omega_d = omega_n * sqrt(1-zeta^2); % Damped natural frequency:
    beta = acos(zeta);

    % Rise Time
    Tr = (pi - beta) / omega_d;

    % Peak Time: Time needed for the response to reach the first peak of the
    % overshoot.
    Tp = pi / (omega_n * sqrt(1-zeta^2));

    % Maximum Overshoot: Occurs at the peak of Tp.
    Mp = exp((-pi*zeta) / sqrt(1-zeta^2));

    % Settling Time: Time needed for the response curve to reach and stay 
    % within 2% of the final value.
    Ts = 4 / (zeta * omega_n);
    
    % Display results.
    results = [zeta, Kd, Td, Tr, Tp, Mp, Ts]
end





