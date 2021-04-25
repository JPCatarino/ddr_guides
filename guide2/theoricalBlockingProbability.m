function p = theoricalBlockingProbability(ro, N)
    a= 1;
    p= 1;
    for n= N:-1:1
        a= a*n/ro;
        p= p+a;
    end
    p = 1/p;
end