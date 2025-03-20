
syms x

f(x) = 2*x;        % outer
g(x) = 1/4 * x^2;  % inner

intersections = solve(f(x) == g(x), x);

real_intersections = double(intersections(imag(intersections) == 0));

fprintf('Intersection points: ');
fprintf('%.4f ', real_intersections);
fprintf('\n');

a = min(real_intersections);
b = max(real_intersections);

integrand = @(x) pi * ((2*x).^2 - (1/4 * x.^2).^2);

volume = integral(integrand, a, b);

fprintf('The volume of the solid of revolution is approximately %.4f cubic units.\n', volume);

