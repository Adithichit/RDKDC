function y= ROTY(scalar_roll)
y = [cos(scalar_roll), 0, sin(scalar_roll);
     0 1 0;
     -sin(scalar_roll), 0, cos(scalar_roll)];
end