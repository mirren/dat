function y = one_pole_low_pass(x,y_1,a)
%      y = y_1 + a*(x-y_1);
    y = y_1 - a*x;
end