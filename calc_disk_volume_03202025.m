syms x y

f(x) = sqrt(x);
g(y) = y^2;

a = 0;
b = 4;

c = 0;
d = 4;

f_num = matlabFunction(f);
g_num = matlabFunction(g);

integrand1 = @(x) pi * (f_num(x).^2);
volume_x_axis = integral(integrand1, a, b);

integrand2 = @(y) pi * (g_num(y).^2);
volume_y_axis = integral(integrand2, c, d);

disp(['Volume when revolved around x-axis: ', num2str(volume_x_axis)]);
disp(['Volume when revolved around y-axis: ', num2str(volume_y_axis)]);

figure;
fplot(f, [a b]);
hold on;
title('Function to be Revolved Around Both Axes');
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
xlabel('x'); ylabel('y'); zlabel('z');
title('Solid of Revolution Around X-axis');
axis equal;

y_vals_y_axis = linspace(c, d, 50);
[Theta_y, Y_y] = meshgrid(theta, y_vals_y_axis);
X_y = g_num(Y_y) .* cos(Theta_y);
Z_y = g_num(Y_y) .* sin(Theta_y);

figure;
surf(X_y, Y_y, Z_y);
xlabel('x'); ylabel('y'); zlabel('z');
title('Solid of Revolution Around Y-axis');
axis equal;






