%% QuadraticSolver
%   Solves quadratic equations with real and nonreal roots
%   Author: Matt

%% Input coefficients
a=input('What is "a"? ');
b=input('What is "b"? ');
c=input('What is "c"? ');

%% Calculate roots (z1, z2)
z1=(-b+sqrt(b^2-4*a*c))/(2*a);
z2=(-b-sqrt(b^2-4*a*c))/(2*a);

%% Display answers
disp([' ']);
disp(['The roots are:']);
disp(['    z1 = ',num2str(z1)]);
disp(['    z2 = ',num2str(z2)]);
disp(['=====================']);