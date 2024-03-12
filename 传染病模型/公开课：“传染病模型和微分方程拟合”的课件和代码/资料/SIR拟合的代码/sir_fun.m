function dp = sir_fun(t,p,beta,gamma)
    N =  1000;
    dp = zeros(3,1);
    S = p(1); 
    I =  p(2);
    dp(1) = -beta * S * I / N;
    dp(2) = beta * S * I / N - gamma * I;
    dp(3) = gamma * I;
end