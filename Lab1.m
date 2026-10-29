%% Simulation Task 1
clear all ; close all
addpath('/home/adithi/Desktop/RDKDC Lab 1./RDKDC Lab 1/UR5ROS2code/UR5ROScode')
time_intervall = 10;
ur5e = ur5_interface();

%define angles used in rotation sequence. Define a matrix with four rows,
%each corresponding to a set of six thetas
theta_home = ur5e.home;
theta = repmat(theta_home', 4, 1);
delta = pi/6;

%determine theta at any given point in time
theta_current = ur5e.get_current_joints()

%repeat this process for each set of thetas
for i = 1:4
    % establish arm at home position
    ur5e.move_joints(ur5e.home, 10);
    pause(10);
    % Increment joint i by delta radians for the ith target configuration
    theta(i,i) = theta(i,i) + delta;
    %extract each column from modified theta matrix as one set of 6 angles
    theta_target = theta(i,:)';

    %joint angle differene between current and target angle
    theta_current = ur5e.get_current_joints()
    e = theta_current-theta_target

    %move to theta target
    ur5e.move_joints(theta_target, time_intervall);
    pause(time_intervall);

end

%% Task 2
%% Plotting and Defining Rotations
clear all; close all
addpath('/home/adithi/Desktop/RDKDC Lab 1./RDKDC Lab 1/Matlabcodes_Lab1/Matlabcodes_Lab1')
origin = [0 0 0]';

p= [0 1 0]';
p_h = [0 1 0 1]';
x_pi2 = ROTX(pi/2)
R_pi2 = [x_pi2, [0 2 0]'; [0 0 0], 1];
rotatedPoint_pi2 = x_pi2 * p;
rotatedPoint_pi2h = R_pi2 * p_h;

x_pi4 = ROTX(pi/4)
rotatedPoint_pi4 = x_pi4 * p;
R_pi4 = [x_pi4, [0 2 0]'; [0 0 0], 1];
rotatedPoint_pi4h = R_pi4 * p_h;

figure();
subplot(3,2,1);
view(3)

plotr(x_pi2)
hold on;
plotr(x_pi4)

axis equal
grid on
% 45 degree 
text(0, 0.71, 0.71, 'Y 45°')
text(0, -0.71, 0.71, 'Z 45°')

% 90 degree 
text(0, 0, 1, 'Y 90°')
text(0, -1, 0, 'Z 90°')

% X axis  unchanged
text(1, 0, 0, 'X (unchanged)')
view(3)
formatPlot3D('Rotation Matrices About X-Axis')

% viewing point displacement relative to starting point
subplot(3,2,2)
view(3)
plotp3(rotatedPoint_pi2)
hold on;
plotp3(rotatedPoint_pi4)
hold on;
plotp3(p)
hold on
hold on
h3 = plot3(rotatedPoint_pi2(1), rotatedPoint_pi2(2), rotatedPoint_pi2(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4(1), rotatedPoint_pi4(2), rotatedPoint_pi4(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(p(1), p(2), p(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

legend([h1, h2, h3], ...
    {'Original point p', '45° Rotation', '90° Rotation'}, ...
    'Location', 'best');
formatPlot3D('Point Rotation About X-Axis')

%viewing rotation about the origin
subplot(3,2,3);
view(3)
plotv3(origin,rotatedPoint_pi2)
hold on;
plotv3(origin, rotatedPoint_pi4)
hold on
h3 = plot3(rotatedPoint_pi2(1), rotatedPoint_pi2(2), rotatedPoint_pi2(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4(1), rotatedPoint_pi4(2), rotatedPoint_pi4(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(origin(1), origin(2), origin(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

formatPlot3D('Vector Rotation About X-Axis')
legend([h1, h2, h3], ...
    {'Original (0°)', '45° Rotation', '90° Rotation'}, ...
    'Location', 'best');


subplot(3,2,4);
plotp4(p_h)
hold on;
plotp4(rotatedPoint_pi2h)
hold on;
plotp4(rotatedPoint_pi4h)
hold on;
h3 = plot3(rotatedPoint_pi2h(1), rotatedPoint_pi2h(2), rotatedPoint_pi2h(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4h(1), rotatedPoint_pi4h(2), rotatedPoint_pi4h(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(p_h(1), p_h(2), p_h(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

formatPlot3D('Homogeneous Point Transformations: X-Axis Rotation and Y-Axis Translation')
ylim([-1 3.5])
legend([h1, h2, h3], ...
    {'Original Homogenous Point', '45° Rotation + translation', '90° Rotation + translation'}, ...
    'Location', 'best');

subplot(3,2,5);
plotv4(p_h, rotatedPoint_pi2h)
hold on;
plotv4(p_h, rotatedPoint_pi4h)
hold on;
h3 = plot3(rotatedPoint_pi2h(1), rotatedPoint_pi2h(2), rotatedPoint_pi2h(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4h(1), rotatedPoint_pi4h(2), rotatedPoint_pi4h(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(p_h(1), p_h(2), p_h(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

formatPlot3D('Homogeneous Point Transformations: X-Axis Rotation and Y-Axis Translation')
ylim([-1 3.5])
legend([h1, h2, h3], ...
    {'Original Homogenous Point', '45° Rotation + translation', '90° Rotation + translation'}, ...
    'Location', 'best');
clear all; close all
addpath('/home/adithi/Desktop/RDKDC Lab 1./RDKDC Lab 1/Matlabcodes_Lab1/Matlabcodes_Lab1')
origin = [0 0 0]';

p= [0 1 0]';
p_h = [0 1 0 1]';
x_pi2 = ROTX(pi/2)
R_pi2 = [x_pi2, [0 2 0]'; [0 0 0], 1];
rotatedPoint_pi2 = x_pi2 * p;
rotatedPoint_pi2h = R_pi2 * p_h;

x_pi4 = ROTX(pi/4)
rotatedPoint_pi4 = x_pi4 * p;
R_pi4 = [x_pi4, [0 2 0]'; [0 0 0], 1];
rotatedPoint_pi4h = R_pi4 * p_h;

figure();
subplot(3,2,1);
view(3)

plotr(x_pi2)
hold on;
plotr(x_pi4)

axis equal
grid on
% 45 degree 
text(0, 0.71, 0.71, 'Y 45°')
text(0, -0.71, 0.71, 'Z 45°')

% 90 degree 
text(0, 0, 1, 'Y 90°')
text(0, -1, 0, 'Z 90°')

% X axis  unchanged
text(1, 0, 0, 'X (unchanged)')
view(3)
formatPlot3D('Rotation Matrices About X-Axis')

% viewing point displacement relative to starting point
subplot(3,2,2)
view(3)
plotp3(rotatedPoint_pi2)
hold on;
plotp3(rotatedPoint_pi4)
hold on;
plotp3(p)
hold on
hold on
h3 = plot3(rotatedPoint_pi2(1), rotatedPoint_pi2(2), rotatedPoint_pi2(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4(1), rotatedPoint_pi4(2), rotatedPoint_pi4(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(p(1), p(2), p(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

legend([h1, h2, h3], ...
    {'Original point p', '45° Rotation', '90° Rotation'}, ...
    'Location', 'best');
formatPlot3D('Point Rotation About X-Axis')

%viewing rotation about the origin
subplot(3,2,3);
view(3)
plotv3(origin,rotatedPoint_pi2)
hold on;
plotv3(origin, rotatedPoint_pi4)
hold on
h3 = plot3(rotatedPoint_pi2(1), rotatedPoint_pi2(2), rotatedPoint_pi2(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4(1), rotatedPoint_pi4(2), rotatedPoint_pi4(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(origin(1), origin(2), origin(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

formatPlot3D('Vector Rotation About X-Axis')
legend([h1, h2, h3], ...
    {'Original (0°)', '45° Rotation', '90° Rotation'}, ...
    'Location', 'best');


subplot(3,2,4);
plotp4(p_h)
hold on;
plotp4(rotatedPoint_pi2h)
hold on;
plotp4(rotatedPoint_pi4h)
hold on;
h3 = plot3(rotatedPoint_pi2h(1), rotatedPoint_pi2h(2), rotatedPoint_pi2h(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4h(1), rotatedPoint_pi4h(2), rotatedPoint_pi4h(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(p_h(1), p_h(2), p_h(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

formatPlot3D('Homogeneous Point Transformations: X-Axis Rotation and Y-Axis Translation')
ylim([-1 3.5])
legend([h1, h2, h3], ...
    {'Original Homogenous Point', '45° Rotation + translation', '90° Rotation + translation'}, ...
    'Location', 'best');

subplot(3,2,5);
plotv4(p_h, rotatedPoint_pi2h)
hold on;
plotv4(p_h, rotatedPoint_pi4h)
hold on;
h3 = plot3(rotatedPoint_pi2h(1), rotatedPoint_pi2h(2), rotatedPoint_pi2h(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4h(1), rotatedPoint_pi4h(2), rotatedPoint_pi4h(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(p_h(1), p_h(2), p_h(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

formatPlot3D('Homogeneous Point Transformations: X-Axis Rotation and Y-Axis Translation')
ylim([-1 3.5])
legend([h1, h2, h3], ...
    {'Original Homogenous Point', '45° Rotation + translation', '90° Rotation + translation'}, ...
    'Location', 'best');

clear all; close all
addpath('/home/adithi/Desktop/RDKDC Lab 1./RDKDC Lab 1/Matlabcodes_Lab1/Matlabcodes_Lab1')
origin = [0 0 0]';

p= [0 1 0]';
p_h = [0 1 0 1]';
x_pi2 = ROTX(pi/2)
R_pi2 = [x_pi2, [0 2 0]'; [0 0 0], 1];
rotatedPoint_pi2 = x_pi2 * p;
rotatedPoint_pi2h = R_pi2 * p_h;

x_pi4 = ROTX(pi/4)
rotatedPoint_pi4 = x_pi4 * p;
R_pi4 = [x_pi4, [0 2 0]'; [0 0 0], 1];
rotatedPoint_pi4h = R_pi4 * p_h;

figure();
subplot(3,2,1);
view(3)

plotr(x_pi2)
hold on;
plotr(x_pi4)

axis equal
grid on
% 45 degree 
text(0, 0.71, 0.71, 'Y 45°')
text(0, -0.71, 0.71, 'Z 45°')

% 90 degree 
text(0, 0, 1, 'Y 90°')
text(0, -1, 0, 'Z 90°')

% X axis  unchanged
text(1, 0, 0, 'X (unchanged)')
view(3)
formatPlot3D('Rotation Matrices About X-Axis')

% viewing point displacement relative to starting point
subplot(3,2,2)
view(3)
plotp3(rotatedPoint_pi2)
hold on;
plotp3(rotatedPoint_pi4)
hold on;
plotp3(p)
hold on
hold on
h3 = plot3(rotatedPoint_pi2(1), rotatedPoint_pi2(2), rotatedPoint_pi2(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4(1), rotatedPoint_pi4(2), rotatedPoint_pi4(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(p(1), p(2), p(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

legend([h1, h2, h3], ...
    {'Original point p', '45° Rotation', '90° Rotation'}, ...
    'Location', 'best');
formatPlot3D('Point Rotation About X-Axis')

%viewing rotation about the origin
subplot(3,2,3);
view(3)
plotv3(origin,rotatedPoint_pi2)
hold on;
plotv3(origin, rotatedPoint_pi4)
hold on
plotv3(origin,p)
hold on;
h3 = plot3(rotatedPoint_pi2(1), rotatedPoint_pi2(2), rotatedPoint_pi2(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4(1), rotatedPoint_pi4(2), rotatedPoint_pi4(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(origin(1), origin(2), origin(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

formatPlot3D('Vector Rotation About X-Axis')
legend([h1, h2, h3], ...
    {'Original (0°)', '45° Rotation', '90° Rotation'}, ...
    'Location', 'best');


subplot(3,2,4);
plotp4(p_h)
hold on;
plotp4(rotatedPoint_pi2h)
hold on;
plotp4(rotatedPoint_pi4h)
hold on;
h3 = plot3(rotatedPoint_pi2h(1), rotatedPoint_pi2h(2), rotatedPoint_pi2h(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4h(1), rotatedPoint_pi4h(2), rotatedPoint_pi4h(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(p_h(1), p_h(2), p_h(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

formatPlot3D('Homogeneous Point Transformations: X-Axis Rotation and Y-Axis Translation')
ylim([-1 3.5])
legend([h1, h2, h3], ...
    {'Original Homogenous Point', '45° Rotation + translation', '90° Rotation + translation'}, ...
    'Location', 'best');

subplot(3,2,5);
plotv4(p_h, rotatedPoint_pi2h)
hold on;
plotv4(p_h, rotatedPoint_pi4h)
hold on;
h3 = plot3(rotatedPoint_pi2h(1), rotatedPoint_pi2h(2), rotatedPoint_pi2h(3), ...
    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
h2 = plot3(rotatedPoint_pi4h(1), rotatedPoint_pi4h(2), rotatedPoint_pi4h(3), ...
    'ro', 'MarkerFaceColor', 'b', 'MarkerSize', 8)
hold on
h1 = plot3(p_h(1), p_h(2), p_h(3), ...
    'ro', 'MarkerFaceColor', 'k', 'MarkerSize', 8);

formatPlot3D('Homogeneous Point Transformations: X-Axis Rotation and Y-Axis Translation')
ylim([-1 3.5])
legend([h1, h2, h3], ...
    {'Original Homogenous Point', '45° Rotation + translation', '90° Rotation + translation'}, ...
    'Location', 'best');

subplot(3,2,6);

% Define the original homogeneous coordinate frame
F_original = eye(4);

% Plot the original frame
plotf(F_original);
hold on;

% Plot the frame rotated 45 degrees about X and translated along Y
plotf(R_pi4);
hold on;

% Plot the frame rotated 90 degrees about X and translated along Y
plotf(R_pi2);
hold on;

% Apply 3D plotting settings
formatPlot3D('Homogeneous Frame Transformations');

% Adjust axis limits to include translated frames
ylim([-1.5 3.5]);


% Label the origins of each coordinate frame
text(0, 0, 0, 'Original Frame', 'FontSize', 9);
text(0, 2, 0, '45° and 90° Transformed Frames', 'FontSize', 9);

%% Checking against ROTY and ROTZ
y  = ROTY(pi/2)

%% Euler Rotation
angles = [pi/4, pi/6, pi/3];
Euler_rot = EULERXYZ(angles);

% orthogonality, expected result is I3
disp(Euler_rot' * Euler_rot)

% determinant, expected result is 1
disp(det(Euler_rot))

% plot multiple euler angle rotations
%start with original, then add a rotation about each axis
R_original = EULERXYZ([0 0 0]);
R_x = EULERXYZ([pi/4 0 0]);
R_xy = EULERXYZ([pi/4 pi/4 0]);
R_xyz = EULERXYZ([pi/4 pi/4 pi/4]);

%plot each rotation
figure;

subplot(2,2,1)
plotr(R_original)
title('Original Orientation')
axis equal
grid on
view(3)

subplot(2,2,2)
plotr(R_x)
title('45° Rotation About X')
axis equal
grid on
view(3)

subplot(2,2,3)
plotr(R_xy)
title('45° X and Y Rotations')
axis equal
grid on
view(3)

subplot(2,2,4)
plotr(R_xyz)
title('45° X, Y, and Z Rotations')
axis equal
grid on
view(3)

sgtitle('Task 2, Step 3: Euler XYZ Rotations')

%% Step 4 Evaluating Inverse

% define a second set of euler angles where [a+(2π) b c]
angle2 = angles;
angle2(1) = angle2(1)+2*pi 

%generate Euler rotation xyz using new set of angles
Euler_rot2 = EULERXYZ(angle2)

% use euler inverse to extract euler angles for each matrix
[P1, Y1, R1] = EULERXYZ_INV(Euler_rot);
[P2, Y2, R2] = EULERXYZ_INV(Euler_rot2);

%calculate the error between each set of extracted angles
error = norm([P1, Y1, R1] - [P2, Y2, R2]);

fprintf('Euler angle difference: %.12e\n', error);

%the error is typically not exactly zero so we must pick a small number as
%a threshold to determine whether the error is sufficiently small enough
if error < 1e-10
    fprintf('All extracted Euler angles are approximately equal.\n');
    fprintf('The Euler rotation matrices are equivalent.\n');
else
    fprintf('The extracted Euler angles are not equal.\n');
end

angle2 = angles;
angle2(2) = angle2(2) + 2*pi;

Euler_rot2 = EULERXYZ(angle2);

% Compare rotation matrices directly
error = norm(Euler_rot - Euler_rot2, 'fro');

fprintf('Rotation matrix error: %.12e\n', error);

if error < 1e-10
    fprintf('The Euler rotation matrices equivalent.\n');
else
    fprintf('The Euler rotation matrices not equivalent.\n');
end

%% Step 4(b)

% given euler angles [a b c] Gimbal lock occurs at pi/2 = yaw since sin(pi/2) = 1 and cos(pi/2) = 0
%, meaning that the function no longer depends on b
angles = [pi/4, pi/2, pi/3];

% Euler rotation matrix
Euler_rot = EULERXYZ(angles);

% Extract Euler angles
[P, Y, R] = EULERXYZ_INV(Euler_rot);

% Reconstruct rotation matrix
Euler_inv = EULERXYZ([R P Y]);

% Calculate reconstruction error
error_b = norm(Euler_rot - Euler_inv, 'fro');

fprintf('Reconstruction error: %.12e\n', error_b);

fprintf('Original angles [Pitch Yaw Roll]:\n');
disp(angles);

fprintf('Recovered angles [Pitch Yaw Roll]:\n');
disp([P, Y, R]);

figure;

subplot(1,2,1)
plotr(Euler_rot)
title('Original Rotation')
axis equal
grid on
view(3)

subplot(1,2,2)
plotr(Euler_inv)
title('Reconstructed Rotation')
axis equal
grid on
view(3)

sgtitle('Step 4(b): Gimbal Lock')

%% Step 4(c)
% verify that [a b c]̸ = EULERXYZINV(EULERXYZ([a b c])) for some a, b, c — e.g. try [4π 0 0]. 

angles = [4*pi 0 0]
[a b c] = EULERXYZ_INV(EULERXYZ(angles))

error = output-[a b c]

if error < 1e-8
    fprintf('The recovered angles match the original values.\n');
else
    fprintf('The recovered angles differ from the original values.\n');
end

%% Step 4(d)

% R = EULERXYZ(EULERXYZINV(R)) for all a,b,c where EULERXYZINV( ) is well-defined
% Verify reconstruction for nonsingular Euler angles
Euler_rot = EULERXYZ(angles);

[P, Y, R] = EULERXYZ_INV(Euler_rot);

disp('Extracted angles:')
disp([R P Y])

% Reconstruct rotation
reconstructedRotation = EULERXYZ([R P Y]);

% Calculate error
reconstructionError = norm(Euler_rot - reconstructedRotation, 'fro');

fprintf('Reconstruction error: %.12e\n', reconstructionError);

%% Step 5
%verify sk.T = -sk

x = [2 3 6];

sk = SKEW3(x)

if sk' == -sk
    fprintf('The skew matrix aligns with the transpose property.\n')
    fprintf ('Skew Transpose.\n')
    disp(sk')
    fprintf('Negative Skew.\n')
    disp(-sk)
else
    fprintf('The skew matrix does not align with the skew property')
end

%% Step 6
x = [0; 0; pi/2];

R = EXPCR(x);

disp(R)

x = [pi/4; pi/4; 0];

R = EXPCR(x);

% orthogonality
orthogonality = R'*R
% determinant
det_R = det(R);

%expected orthogonality error of I3 and det = 1
fprintf('Determinant: %.12f\n', det_R);

% Testing Zero Rotation
% expected value is I3 because the identity matrix represents an unchanged
% vector after transformation
x = [0; 0; 0];

R = EXPCR(x);

disp('Zero rotation:')
disp(R)