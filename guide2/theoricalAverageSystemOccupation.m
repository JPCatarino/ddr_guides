function o = theoricalAverageSystemOccupation(ro, N)
    a = N;
    numerator = a;
    for i = N-1:-1:1
        a = a*i/ro;
        numerator = numerator + a;
    end
    a = 1;
    denominator = a;
    for i = N:-1:1
        a = a*i/ro;
        denominator = denominator + a; 
    end
    o = numerator/denominator;
end