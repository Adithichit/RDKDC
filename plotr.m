function plotr(m, varargin)
% Function accepts a single 3x3 matrix and plots the columns of the matrix
% as vectors, with an optional argument for labeling.

% m: a 3x3 rotation matrix
% varargin: (optional) a scalar index

% usage example:
% h = eye(3);
% plotr(h);
% plotr(h, 5);

% 18 Sept 97 RB+LLW
% 5 Mar 2022 modified Yanzhou Wang

washoldon = ishold;


[rows, cols] = size(m);
if ((rows ~= 3) || (cols ~= 3))
    error('PLOTR requires a 3x3 matrix argument. Check your dimensions.');
end

d = det(m);
if ((d <0.999) || (d >1.001))
    fprintf(1,'Error in PLOTR: the argument is not a rotation. Determinent is %f, should be 1.0\n',d);
    error('aborting');
end

zer=[0;0;0];
hold on
plotv3(zer,m(:,1),'r');
plotv3(zer,m(:,2),'y');
plotv3(zer,m(:,3),'c');
if nargin == 2
    text(m(1,1),m(2,1),m(3,1), ['x', num2str(varargin{1})]);
    text(m(1,2),m(2,2),m(3,2), ['y', num2str(varargin{1})]);
    text(m(1,3),m(2,3),m(3,3), ['z', num2str(varargin{1})]);
else
    text(m(1,1),m(2,1),m(3,1), 'X');
    text(m(1,2),m(2,2),m(3,2), 'Y');
    text(m(1,3),m(2,3),m(3,3), 'Z');
end

xlabel('X_0');
ylabel('Y_0');
zlabel('Z_0');

if ~washoldon
    hold off
end
axis equal
grid on