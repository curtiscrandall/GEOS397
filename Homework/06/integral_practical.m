clear all
close all
clc

% L17 practical

%% Up to now, we integrated continuous functions.

% How do we do integration when we have discretely sampled data?

x = linspace( 0, pi, 11 );
y = sin(x);

plot(x,y,'k*'); xlabel('x [rad]'); ylabel('sin(x)'); axis('tight');

% trapz  Trapezoidal numerical integration.
Q = trapz( x, y ); % trapz(x-vector, y-vector) integral for discrete x,y; like air temp vs time

f = @(x) sin(x);
Qi = integral( f, 0, pi, 'AbsTol', 1.e-8 ); % new method with error tolerance 1.e-8

%% 1
clc
clear

f = @(y) sqrt(y+1);
Qi = integral(f, 0, 3,'AbsTol', 1.e-8) % = 4.6667

%% 2
clc
clear

f = @(r) (5*r) ./ (4+r.^2).^2;
Qi = integral(f, -1, 1,'AbsTol', 1.e-8) % = -5.2042e-18

%% 3
clc
clear

f = @(r) ;
Qi = integral(f, -1, 1,'AbsTol', 1.e-8)
%% 4
clc
clear

f = @(r) ;
Qi = integral(f, -1, 1,'AbsTol', 1.e-8)
%% 5
clc
clear

f = @(r) ;
Qi = integral(f, -1, 1,'AbsTol', 1.e-8)
%% 6
clc
clear

f = @(y) 1 ./ (2*sqrt(y)) .* (1+sqrt(y)).^2;
Qi = integral(f, 1, 4,'AbsTol', 1.e-8)

%%
clc
clear

% plot function y(x)=xe^-x between x=0 and x=5 with 101 points
x = linspace(0,5,101);
y = x .* exp(-x);
plot(x,y)
xlabel('x'); ylabel('y = xe^(-x)');

function A = exactArea(a)
A = 1 - exp(-a) - a*exp(-a)
end

a = 5
A = exactArea(a)

%5 use trapz(x,y) when you dont know the formula to give an approximate area




