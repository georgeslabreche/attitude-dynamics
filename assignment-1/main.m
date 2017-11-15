clear all 
close all
clc

%%%%%%%%%%%%%%%%%%%%%%
%        INIT        %
%%%%%%%%%%%%%%%%%%%%%%
plot_visibility = 'on';

% If an image export directory doesn't exist, create it.
if ~exist('exports', 'dir')
    mkdir('exports');
end

%%%%%%%%%%%%%%%%%%%%%%
% I. Satellite model %
%%%%%%%%%%%%%%%%%%%%%%

% a) Plot the responses for t=0 to 100 s.

% b) Set up the transfer function of the system.

% Specify a transfer function model using a rational function in the
% Laplace variable, s.
s = tf('s');

% Define the transfer function.
H = 1/s^2;

% Define time sample for t=0 to 100s.
timesample = (1:1:100);

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

