function Q = toReal(q)
a = q(1); b = q(2); c = q(3); d = q(4);
Q = [a, -b, -c, -d;
     b, a, -d, c;
     c, d, a, -b;
     d, -c, b, a];
end
