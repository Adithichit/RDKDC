function Euler_rot = EULERXYZ(angle_vec) % input is 3 angle vector in radians
%generate rotation matrices using angles found in the input angle vector
x = ROTX(angle_vec(1));
y = ROTY(angle_vec(2));
z = ROTZ(angle_vec(3));

Euler_rot = x*y*z; %return euler rotation matrix using xyz sequence

end