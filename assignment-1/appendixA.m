% A transfer function can be set up using a rational function in s
s = tf('s');

% Transfer function 1:
H1 = 2/(1+s)

% Transfer function 2:
H2 = 2/(1+s)

% Connect both transfer functions:
Htot = H2*H1
