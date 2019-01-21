function[xc,yc,zc,error] = BSplineApproximation_2(xr,yr,zr,h,iteration)
%%
% This function implements LSPIA. Given a collection of points named
% (xr,yr,zr), and the grid's density, which we call 'share', the iteration
% can be manipulated until it satisfies pause conditions. The controlling
% points are able to be obtained and stored in xc, yc, zc, and the normal
% difference error, that is 'error', can also be shown.
%
% Input: 
% xr: A vector, the x coordinate value of points approximated by B-spline surface
% yr: A vector, the y coordinate value of points approximated by B-spline surface
% zr: A vector, the z coordinate value of points approximated by B-spline surface
% h: an integer, the number how many shares the controlling grid is
% divided into.
% iteration: An integer, the number how many times the iteration processes.
% pauses.
%
% Output:
% xc: A vector, the x coordinate value of controlling grid
% yc: A vector, the y coordinate value of controlling grid
% zc: A square matrix storing z value on each controlling grid.
% error: a measure of iteration's error 
%
%--------------------------------------------------------------------------
% Example:
% [xc,yc,zc,error] = BSplineApproximation(xr,yr,zr,15,100);
%

% the domain is [0,1] \times [0,1]
xk = xr;
yk = yr;
zk = zr;
zc = zeros(h);
%eps = 10^(-15);

n = length(xr);
Bx = zeros(n,h);
By = zeros(n,h);

for p = 1:n
    Bx(p,:) = UniBsplineBasic(4,h,xk(p));
    By(p,:) = UniBsplineBasic(4,h,yk(p));
end

Lambda = zeros(1,h*h);

ind = 1;
for i = 1:h
    for j = 1:h
        temp = 0;
        for r = 1:n           
            temp = Bx(r,i)*By(r,j)+temp;
        end
        Lambda(ind) = temp;
        ind = ind + 1;
    end
end

c = max(Lambda);
mu = 2/c;
% Bx_bar = Bx;
% By_bar = By;
% 
% for i = 1:n
%     for j = 1:h
%         if  Bx_bar(i,j) < eps
%         	Bx_bar(i,j) = eps;
%         end
%         if  By_bar(i,j) < eps
%             By_bar(i,j) = eps;
%         end
%     end
% end

% initial delta_l
delta_l = zk;
delta_lplus1 = zk;

%initial Delta
Delta = zeros(h);

for rec = 1:iteration
    for i = 1:h
        for j = 1:h
            delta_l = delta_lplus1;
%             temp = 0;
%             for r = 1:n           
%                 temp = Bx_bar(r,i)*By_bar(r,j)+temp;
%             end
            temp_up = 0;
            for r = 1:n
                temp_up = temp_up + Bx(r,i)*By(r,j)*delta_l(r);
            end
            Delta(i,j) = temp_up * mu;  
        end
    end
    zc = zc + Delta;
    for p = 1:length(delta_l)
        delta_lplus1(p) = zk(p) - Bx(p,:)*zc*(By(p,:)'); 
    end
end

error = abs((norm(delta_lplus1)^2 - norm(delta_l)^2)/norm(delta_lplus1)^2);

% uniform grid
xc = 0:1/(h - 1):1;
yc = xc;

fprintf('the iterative error: %f\n',error);
end



function N = UniBsplineBasic(k,n,t)
%%
% function UniBsplineBasic calculates the basis of k-order B-spline whose
% curve has uniform knots and passes the first and final controlling point
% %NOTE: the knots are no longer uniform, modified on 4 Semp, 2018.
%
% input:
% k: the order
% n: the number of controlling points
% t: knot value we want to calculate
%
% output:
% N: the value of t on each basis function
%

% form the uniform knot vector

% knots generating 
knots = zeros(1,n+k);
knots(1,k:n+1) = 0:1/(n-k+1):1; % uniform knots
%knots are intense while approaching axis.
% divide2 = 1;
% for index = n:-1:k+1
%     divide2 = divide2 /2;
%     knots(1,index) = divide2;
% end
    
knots(1,n+1:n+k) = ones(1,k);

Np = zeros(1,n+k-1);
if t == 0
    Np(1,1) = 1;
elseif t == 1
    Np(1,n) = 1;
else
    % initial knots value
    for p = 1:n+k-1
        if t>= knots(p) && t<knots(p+1)
            Np(p) = 1;
        end
    end
    % deBoor-Cox algorithm
    % Avert the case that 0 is divided by 0
    for q = 2:k
       for p = 1:n+k-q
          if Np(p) == 0
              preN = 0;
          else
              preN = (t-knots(p))/(knots(p+q-1)-knots(p))*Np(p);
          end
          if Np(p+1) == 0
              postN = 0;
          else
              postN = (knots(p+q)-t)/(knots(p+q)-knots(p+1))*Np(p+1);
          end
          Np(p) = preN + postN;
       end
    end
end
N = Np(1,1:n);        

end