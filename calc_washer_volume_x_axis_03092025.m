
syms x

f(x) = 2*x;        % outer
g(x) = 1/4 * x^2;  % inner

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

fprintf('The volume of the washer (revolved around the x axis) is approximately %.4f cubic units.\n', volume);

