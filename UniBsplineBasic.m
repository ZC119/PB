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