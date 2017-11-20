%
% Assignment 1 - Attitude control with PID-controller
%
% Problem I: Satellite model
%
% Goal: On successful completion of the assignment the student shall
%   - be able to use Control system toolbox in MATLAB/Simulink for analysis
%     of simple control systems.
%   - be able to set up simple transfer functions using Laplace-transforms.
%   - be familiar with attitude control with an ideal actuator, ideal
%     sensors and a simple controller.
%   - know some common control system performance metrics
%     (transient analysis).
%   - know the role of the three parts of a PID-controller
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

% Define time sample for our plots from t=0 to 100s.
timesample = (0:1:100);

% a) Plot the responses for t=0 to 100 s.

% b) Set up the transfer function of the system.

% Define the transfer function.
H = 1/s^2;

% Build the Step and Impulse subplot figure.
fig_si = figure;
set(fig_si, 'NumberTitle', 'on', ...
    'Name', 'Step and Impulse Plots', ...
    'Visible', plot_visibility);

% Step plot.
subplot(2,1,1);
stepplot(H, timesample)
title ('Step');

% Impulse plot.
subplot(2,1,2);
impulseplot(H, timesample)
title ('Impulse');

% Export the plot as a png file.
print('exports/fig-step-and-impulse', '-dpng');

