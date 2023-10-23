
%==========================
%% Part A: Plot Root Locus
%==========================
clear all;
clc;

R = 1e4;        % 10k ohms
C = 1.592e-9;   % 1.592 nF

poles_top = [];
poles_bot = [];
for Am = 1.586:0.0001:6 % This is the range of gain values, and step size
    H_den = [ 1, (3-Am)/(R*C), 1/(R*C)^2 ];
    P = roots(H_den);

    top_row = [ real(P(1)), imag(P(1)) ];
    bot_row = [ real(P(2)), imag(P(2)) ];

    poles_top = [ poles_top; top_row ];
    poles_bot = [ poles_bot; bot_row ];
end

% Always plot our final pole location for the bottom pole. If we don't do
% this, we end up with our root locus line not touching the origin
poles_bot = [ poles_bot; [0,0] ];

figure(1);
clf;

% Plot the X=0 and Y=0 axes
xline(0, 'Color', [0.6, 0.6, 0.6], 'LineStyle', '- -');
hold on;
yline(0, 'Color', [0.6, 0.6, 0.6], 'LineStyle', '- -');
hold on;

% Plot initial poles
plot(poles_top(1,1), poles_top(1,2), 'xk', 'MarkerSize', 10, 'LineWidth', 2);
hold on;
plot(poles_bot(1,1), poles_bot(1,2), 'x', 'MarkerSize', 10, 'LineWidth', 2, 'Color', [0.6, 0.6, 0.6]);
hold on;

% Plot zero at zero
plot(0, 0, 'ok', 'MarkerSize', 10, 'LineWidth', 2);
hold on;

% Plot root locus
plot(poles_top(:, 1), poles_top(:, 2), 'k', 'linewidth', 3);
hold on;
plot(poles_bot(:, 1), poles_bot(:, 2), 'Color', [0.6, 0.6, 0.6], 'linewidth', 3);
hold on;

% Format the figure
axis equal;
title("Root Locus of 2nd Order Sallen-Key Filter");
xlabel("Real (seconds^{-1})");
ylabel("Imaginary (seconds^{-1})");

xlim([ -10e4, 10e4 ]);