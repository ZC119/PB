function[xc,yc,error] = BSplineApproximationCurve(xr,yr,share,times,epsilon)
%%
% This function implements LSPIA for 2D curves. 
% Given a collection of points named
% (xr,yr), and the grid's density, which we call 'share', the iteration
% can be manipulated until it satisfies pause conditions. The controll
% points are able to be obtained and stored in xc, yc, and the normal
% difference error, that is 'error', can also be shown.
%
% Input: 
% xr: A vector, the x coordinate value of points approximated by the B-spline
% curve
% yr: A vector, the y coordinate value of points approximated by the
% B-spline curve
% share: an integer, the number how many shares the controll grid is
% divided.
% times: An integer, the number how many times the iteration processes.
% epsilon: A float number, if error is beyond it, the process of iteration
% pauses.
%
% Output:
% xc: A vector, the x coordinate value of controlling grid
% yc: A vector, the y coordinate value of controlling grid
% error: a measure of iteration's error 
%
%--------------------------------------------------------------------------
min_x = 0;
max_x = 1;

xk = 1/(max_x - min_x)*(xr - min_x);
yk = yr;

yc = zeros(share,1); 

n = length(xr);
Bx = zeros(n,share);

for p = 1:n
    Bx(p,:) = UniBsplineBasic(4,share,xk(p));
end
% initial delta_l
delta_l = yk;

%initial Delta
Delta = zeros(share,1);
for i = 1:share
    temp = 0;
    for r = 1:n
        temp = Bx(r,i)+temp;
    end
    if temp == 0
        Delta(i) = 0;
    else
        temp_up = 0;
        for r = 1:n
            temp_up = temp_up + Bx(r,i)*delta_l(r);
        end
        Delta(i) = temp_up / temp;
    end
end

yc = yc + Delta;

delta_lplus1 = delta_l;

for p = 1:length(delta_l)
    delta_lplus1(p) = yk(p) - Bx(p,:)*yc;    
end

error = abs((norm(delta_lplus1)^2 - norm(delta_l)^2)/norm(delta_lplus1)^2);
rec = 1;
%while error>=epsilon && rec<=times
while rec<=times
    for i = 1:share
        delta_l = delta_lplus1;
        temp = 0;
        for r = 1:n
            temp = Bx(r,i)+temp;
        end
        if temp == 0
            Delta(i) = 0;
        else
            temp_up = 0;
            for r = 1:n
                temp_up = temp_up + Bx(r,i)*delta_l(r);
            end
            Delta(i) = temp_up / temp;
        end
    end
    yc = yc + Delta;
    for p = 1:length(delta_l)
        delta_lplus1(p) = yk(p) - Bx(p,:)*yc; 
    end
    error = abs((norm(delta_lplus1)^2 - norm(delta_l)^2)/norm(delta_lplus1)^2);
    rec = rec + 1;
end
% uniform grid


% non-uniform grid
% modified on 4 Semp, 2018
% tx = zeros(1,share);
% divide2 = 1;
% for index = share:-1:2
%     tx(1,index) = divide2;
%     divide2 = divide2 /2;
% end
% ty = tx;
%

tx = 0:1/(share - 1):1;
xc = (max_x - min_x)*tx + min_x;

%fprintf('circulation times�� %d\n', rec-1);
fprintf('the iterative error: %f\n',error);
end
