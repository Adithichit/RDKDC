function [pitch, yaw, roll] = EULERXYZ_INV(Euler_rot) %input is an Euler rotation mat

% Check for gimbal lock which is when two of the three rotation axes align
% in parallel, causing the system to lose a degree of freedom.
% when we detect a gimbal lock, we must set either yaw or roll equal to 0
% (as these two are coupled). We can then solve for one compatible roll
% angle rather than have infinitely many solutions

%set a tolerance which can be used to determine how close the euler angles
%are to a singularity
tolerance = 1e-8;

% Check for gimbal lock
if sqrt(Euler_rot(1,1)^2 + Euler_rot(1,2)^2) < tolerance

    warning('Gimbal lock detected');

    % set pitch
    if Euler_rot(1,3) > 0
        pitch = pi/2;

        % Compatible roll positive 
        roll = atan2(Euler_rot(3,2), Euler_rot(2,2));

    else
        pitch = -pi/2;

        % Compatible roll negative 
        roll = atan2(-Euler_rot(3,2), Euler_rot(2,2));
    end

    % Set yaw zero
    yaw = 0;

else

    % Normal case
    pitch = atan2(Euler_rot(1,3), ...
        sqrt(Euler_rot(1,1)^2 + Euler_rot(1,2)^2));

    yaw = atan2(-Euler_rot(1,2), Euler_rot(1,1));

    roll = atan2(-Euler_rot(2,3), Euler_rot(3,3));

end
end