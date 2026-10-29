function plotp4(p0, varargin)
% Function accepts a single 4x1 vector (i.e. a position vector in
% homogeneous representation) and plots the vector as a point, with an
% optional argument for coloring.

% p0: a 4x1 vector
% varargin: (optional) a color specification, either a MATLAB built-in
% character (e.g. 'r') or a RBG triplet of values between 0 and 1

% usage example:
% plotp4([1; 0; 0; 1]);
% plotp4([1; 0; 0; 1], 'r');
% plotp4([1; 0; 0; 1], rand(1, 3));

% Aug 15 1997  Louis Whitcomb Created and Written
% Sept 18 modified  Ralf Bachmayer
% Mar 5 2022 modified by Yanzhou Wang

[rows, cols] = size(p0);
if ((rows ~= 4) || (cols ~= 1))
  error('plotp4 requires a 4x1 vector argument. Check your dimensions.');
end

if nargin == 2
    colorspec = varargin{1};
else
    % if user does not specify a colorspec, set it to black.
    colorspec = [0, 0, 0];
end
plot3(p0(1), p0(2), p0(3), "Color", colorspec, "Marker", 'o');