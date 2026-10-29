function z = ROTZ(scalar_roll) %input scalar_roll iin ra
z = [cos(scalar_roll), -sin(scalar_roll), 0
    sin(scalar_roll), cos(scalar_roll), 0
    0, 0, 1];

end