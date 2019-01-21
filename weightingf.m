function [weight, num_dis_eps] = weightingf(x,y,persistence,epsilon)
%%  weighting function 
% This function reflects the importance of persistence as well as the
% density of points on PD. 
% The weighting function is constructed by two parts: the persistence part
% and the density part.
% W(persistence, epsilon) = f(persistence)*density(epsilon)
len = length(x);
num_dis_eps = ones(len,1);
for p = 1:len
    for q = p+1:len
        d_i = (x(p)-x(q))^2 + (y(p)-y(q))^2;
        if d_i<= epsilon^2
            num_dis_eps(p) = num_dis_eps(p) + 1;
            num_dis_eps(q) = num_dis_eps(q) + 1;
        end
    end
end
weight = persistence .* num_dis_eps;
end
