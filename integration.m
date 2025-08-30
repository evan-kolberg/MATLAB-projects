% Symbolic Integration in MATLAB
% Make sure you have the Symbolic Math Toolbox

% Define variables
syms x y

%% 1. Indefinite integral
f1 = sin(x)^2;
I1 = int(f1, x);
disp('Indefinite integral of sin(x)^2:')
disp(I1)

%% 2. Definite integral
f2 = exp(-x^2);
I2 = int(f2, x, -inf, inf);
disp('Definite integral of exp(-x^2) from -inf to inf:')
disp(I2)

%% 3. Multiple integral
f3 = x * y;
I3 = int(int(f3, x, 0, 1), y, 0, 1);
disp('Double integral of x*y over [0,1]x[0,1]:')
disp(I3)

%% 4. Numeric approximation (if needed)
I2_num = double(I2);
disp('Numeric value of integral of exp(-x^2):')
disp(I2_num)

%% 5. Plot an integral as a function
syms t x  % declare both variables

F = int(sin(t)^2, t, 0, x);  % symbolic expression in terms of x
fplot(F, [0 10])             % plot from 0 to 10
title('Integral of sin(t)^2 from 0 to x')
xlabel('x')
ylabel('Integral value')
grid on
