function R = EXPCR(x) % Input:x - 3x1 vector
% converts a 3x1 axis-angle vector into a rotation matrix.
% Output:R - 3x3 rotation matrix

% theta = norm(x) is the rotation angle in radians.
% n = x/norm(x) is the unit rotation axis.
% Uses Rodrigues' rotation formula:
% R = I + sin(theta)*SKEW3(n) + (1-cos(theta))*SKEW3(n)^2

% Calculate rotation angle
theta = norm(x);

% Handle zero rotation
if theta == 0
    R = eye(3);
    return;
end

% Normalize rotation 
n = x/theta;

% Generate skew-symmetric matrix
n_hat = SKEW3(n);

% Apply Rodrigues' formula
R = eye(3) + sin(theta)*n_hat + ...
    (1-cos(theta))*(n_hat^2);

end