
syms x

f(x) = sqrt(x) + 2;

a = 0;
b = 8;

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
[R_cap_a, Theta_cap_a] = meshgrid(linspace(0, f_num(a), 10), theta);
X_cap_a = a * ones(size(R_cap_a));
Y_cap_a = R_cap_a .* cos(Theta_cap_a);
Z_cap_a = R_cap_a .* sin(Theta_cap_a);
surf(X_cap_a, Y_cap_a, Z_cap_a);

[R_cap_b, Theta_cap_b] = meshgrid(linspace(0, f_num(b), 10), theta);
X_cap_b = b * ones(size(R_cap_b));
Y_cap_b = R_cap_b .* cos(Theta_cap_b);
Z_cap_b = R_cap_b .* sin(Theta_cap_b);
surf(X_cap_b, Y_cap_b, Z_cap_b);
xlabel('x'); ylabel('y'); zlabel('z');
title('Solid of Revolution Around X-axis');
axis equal;



