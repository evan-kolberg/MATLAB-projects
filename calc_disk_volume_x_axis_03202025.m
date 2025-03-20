
syms x

f(x) = sqrt(x);

a = 0;
b = 4;

f_num = matlabFunction(f);

integrand1 = @(x) pi * (f_num(x).^2);
volume_x_axis = integral(integrand1, a, b);

disp(['Volume when revolved around x-axis: ', num2str(volume_x_axis)]);

figure;
fplot(f, [a b]);
hold on;
title('Function to be Revolved Around X-Axis');
xlabel('x'); ylabel('y');
grid on;
axis equal;

theta = linspace(0, 2*pi, 50);

x_vals_x_axis = linspace(a, b, 50);
[Theta_x, X_x] = meshgrid(theta, x_vals_x_axis);
Y_x = f_num(X_x) .* cos(Theta_x);
Z_x = f_num(X_x) .* sin(Theta_x);

figure;
surf(X_x, Y_x, Z_x);
hold on;
[R_cap, Theta_cap] = meshgrid(linspace(0, f_num(b), 10), theta);
X_cap = b * ones(size(R_cap));
Y_cap = R_cap .* cos(Theta_cap);
Z_cap = R_cap .* sin(Theta_cap);
surf(X_cap, Y_cap, Z_cap);
xlabel('x'); ylabel('y'); zlabel('z');
title('Solid of Revolution Around X-axis');
axis equal;



