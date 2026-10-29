function sk = SKEW3(x) %input 3x1 vector
 sk = [0 -x(3) x(2);
       x(3) 0 -x(1);
       -x(2) x(1) 0];

end