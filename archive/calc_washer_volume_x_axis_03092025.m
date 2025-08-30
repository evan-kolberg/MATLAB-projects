
syms x

f(x) = sqrt(x) + 2;
g(x) = 1/32 * x^2 + 2;

intersections = solve(f(x) == g(x), x);
real_intersections = double(intersections);
real_intersections = real_intersections(imag(real_intersections) == 0);

fprintf('Intersection points: ');
fprintf('%.4f ', real_intersections);
fprintf('\n');

a = min(real_intersections);
b = max(real_intersections);

f_num = matlabFunction(f);
g_num = matlabFunction(g);

integrand = @(x) pi * (f_num(x).^2 - g_num(x).^2);
volume = integral(integrand, a, b);

fprintf('The volume of the washer (revolved around the x-axis) is approximately %.4f cubic units.\n', volume);

figure;
fplot(f, [a b], 'LineWidth', 1.5);
hold on;
fplot(g, [a b], 'LineWidth', 1.5);
title('Functions to be Revolved Around X-Axis');
xlabel('x'); ylabel('y');
legend('f(x)', 'g(x)');
grid on;
axis equal;

theta = linspace(0, 2*pi, 50);
x_vals_x_axis = linspace(a, b, 50);

[Theta_x, X_x] = meshgrid(theta, x_vals_x_axis);
Y_outer = f_num(X_x) .* cos(Theta_x);
Z_outer = f_num(X_x) .* sin(Theta_x);

Y_inner = g_num(X_x) .* cos(Theta_x);
Z_inner = g_num(X_x) .* sin(Theta_x);

figure;
surf(X_x, Y_outer, Z_outer, 'FaceAlpha', 0.8, 'EdgeColor', 'black');
hold on;
surf(X_x, Y_inner, Z_inner, 'FaceAlpha', 0.8, 'EdgeColor', 'black');

xlabel('x'); ylabel('y'); zlabel('z');
title('Solid of Revolution Around X-axis (Washer Method)');
axis equal;
view(3);
grid on;





