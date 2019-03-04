X = 0:1:720;

i = 0;
while i <= length(X)-1
    i = i+1;

    State = SVA(9.5492, 6, 2, X(i));

    S(i) = State(1);
    V(i) = State(2);
    A(i) = State(3);

end

plot (X, S, X, V, X, A)