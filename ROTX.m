function x = ROTX(scalar_roll) %input is scalar roll value in radians
x = [1 0 0;
    0, cos(scalar_roll), -sin(scalar_roll);
    0, sin(scalar_roll), cos(scalar_roll)];
end