clear
clc

% variables
x = 0:20:200;
dt = 1;
time = 0:dt:1000;
A1 = 2;
f1 = 1/50;
A2 = 1;
f2 = 1/15;
A3 = 0.5;
f3 = 1/5;

% make sine waves
x1 = A1*sin(2*pi*f1*time);
x2 = A2*sin(2*pi*f2*time);
x3 = A3*sin(2*pi*f3*time);
Xp = x1+x2+x3;

figure;
plot(time, Xp,'k'); axis([0,200,-4,4])
xlabel('Time [s]');
ylabel('x(s)');

Xtr = 0.005