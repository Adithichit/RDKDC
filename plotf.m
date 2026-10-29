function plotf(m, varargin)
% Function accepts a single 4x4 matrix and plots the frame, with optional
% arguments for labeling and coloring

% m: a 4x4 matrix
% varargin{1}: (optional) a color specification, either a MATLAB built-in
% character (e.g. 'r') or a RGB triplet of values between 0 and 1
% varargin{2}: (optional) a scalar index 
% usage example:
% h = eye(4);
% plotf(h);
% plotf(h, 'r');
% plotf(h, rand(1, 3));
% plotf(h, 'r', 4);
% plotf(h, rand(1, 3), 4);

% 18 Sept 97 RB+LLW
% Copyright Louis L. Whitcomb, 2013
% 5 Mar 2022 modified Yanzhou Wang

washoldon = ishold;

[rows, cols] = size(m);
if ((rows ~= 4) || (cols ~= 4))
  error('PLOTF requires a 4x4 matrix argument. Check your dimensions.');
end

d = det(m);
if ((d <0.999) || (d >1.001))
  fprintf(1,'Error in PLOTF: the argument is not a rotation. Determinent is %f, should be 1.0\n',d);
  error('aborting');
end

zer=m(1:3,4);
hold on 
if nargin == 1
    plotv3(zer,zer+m(1:3,1),'r');
    plotv3(zer,zer+m(1:3,2),'y');
    plotv3(zer,zer+m(1:3,3),'c');
    text(m(1,4)+m(1,1),m(2,4)+m(2,1),m(3,4)+m(3,1),'X');
    text(m(1,4)+m(1,2),m(2,4)+m(2,2),m(3,4)+m(3,2),'Y');
    text(m(1,4)+m(1,3),m(2,4)+m(2,3),m(3,4)+m(3,3),'Z');
elseif nargin == 2
    plotv3(zer,zer+m(1:3,1), varargin{1});
    plotv3(zer,zer+m(1:3,2), varargin{1});
    plotv3(zer,zer+m(1:3,3), varargin{1});
    text(m(1,4)+m(1,1),m(2,4)+m(2,1),m(3,4)+m(3,1),'X');
    text(m(1,4)+m(1,2),m(2,4)+m(2,2),m(3,4)+m(3,2),'Y');
    text(m(1,4)+m(1,3),m(2,4)+m(2,3),m(3,4)+m(3,3),'Z');
else
    plotv3(zer,zer+m(1:3,1), varargin{1});
    plotv3(zer,zer+m(1:3,2), varargin{1});
    plotv3(zer,zer+m(1:3,3), varargin{1});
    text(m(1,4)+m(1,1),m(2,4)+m(2,1),m(3,4)+m(3,1), ['x', num2str(varargin{2})]);
    text(m(1,4)+m(1,2),m(2,4)+m(2,2),m(3,4)+m(3,2), ['y', num2str(varargin{2})]);
    text(m(1,4)+m(1,3),m(2,4)+m(2,3),m(3,4)+m(3,3), ['z', num2str(varargin{2})]);
end


xlabel('X_0');
ylabel('Y_0');
zlabel('Z_0');
if ~washoldon
    hold off
end
axis equal;
grid on;