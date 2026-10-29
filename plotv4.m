function plotv4(X0_vec, X1_vec, varargin)
% Function accepts two 4x1 vectors (i.e. two position vectors in
% homogeneous representation) and plots their difference as a line segment
% from X0_vec to X1_vec, with an optional argument for coloring.

% X0_vec: a 4x1 vector
% X1_vec: a 4x1 vector
% varargin: (optional) a color specification, either a MATLAB built-in
% character (e.g. 'r') or a RBG triplet of values between 0 and 1

% usage example: 	
% plotv4([1; 0; 0; 1], [0; 1; 0; 1]);
% plotv4([1; 0; 0; 1], [0; 1; 0; 1], 'r');
% plotv4([1; 0; 0; 1], [0; 1; 0; 1], rand(1, 3));

% 1997  Louis Whitcomb Created and Written
% 5 Mar 2022 modified Yanzhou Wang

% check argument dimension
[rows, cols] = size(X0_vec);
if ((rows ~= 4) || (cols ~= 1))
  error('PLOTV4 requires a 4x1 vector argument. Check your dimensions.');
end

% check argument dimension
[rows, cols] = size(X1_vec);
if ((rows ~= 4) || (cols ~= 1))
  error('PLOTV4 requires a 4x1 vector argument. Check your dimensions.');
end

% assemble a matrix with the two position vectors
m = [X0_vec(1:3,1)'; X1_vec(1:3,1)'];

% check if the given value for the linestyle exists
if nargin == 3
    colorspec = varargin{1};
else
    % if user does not specify a colorspec, set it to black.
    colorspec = [0, 0, 0];
end

plot3(m(:,1), m(:,2), m(:,3), "Color", colorspec, "Marker", 'o');



