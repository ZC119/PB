%% generate data of 3d dynamic system
% We take M_0=3.000, 3.300, 3.3701, 3.4001, 3.480, 3.532, 3.540, 3.570, 3.571 and obtain 9 classes
% We repeat 50 times in each combination of parameters and eventually we get 450 results from the system
% Results are saved in dynamic3d folder

% params
M0_all = [3.000, 3.300, 3.3701, 3.4001, 3.480, 3.532, 3.540, 3.570, 3.571];
M1 = 1.0;
M2 = 4.0;
M3 = 4.0;

% number of iteration
iter_num = 2000;

for param = 1:length(M0_all)
    
M0 = M0_all(param);
   
X = zeros(iter_num, 1);
Y = zeros(iter_num, 1);
Z = zeros(iter_num, 1);

mkdir(['./dynamic3d/' num2str(M0)])

for k = 1:50

% initial value
X(1) = rand + 1;
Y(1) = rand;
Z(1) = rand;

for i = 2:iter_num
    X(i) = M0 * X(i-1) * exp(-Y(i-1)) / (1 + X(i-1) * max(exp(-Y(i-1)), K(Z(i-1))*K(Y(i-1))));
    Y(i) = M1 * X(i-1) * Y(i-1) * exp(-Z(i-1)) * K(Y(i-1)) * K(M3*Y(i-1)*Z(i-1));
    Z(i) = M2 * Y(i-1) * Z(i-1);
end

result = [X, Y, Z];
save(['./dynamic3d/' num2str(M0) '/' num2str(k) '.txt'],'result','-ascii');
end

end

function [result] = K(gamma)
    if gamma == 0
        result = 1; 
    else
        result = (1 - exp(-gamma)) / gamma;
    end
end
