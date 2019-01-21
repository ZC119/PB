function s = MyBsplineCurveshow(xc, yc, share, ctr_density)
% Function: Bspline curve show 
% Attention: Uniform knots B spline surface with its end points interpolate onto the
% control points
% Input:
% xc: A vector, x value of control points.
% yc: A vector, y value of control points.
% share: the share of uniform knot division.
% ctr_density: the density of the control points
%
% Output;
% this function should have no return.
% s: if success, return 1;
%

s = 0;
min_x = min(xc);
max_x = max(xc);
n = length(xc);

% sampling points on B-spline surface
tx = 0:1/(share-1):1;

ty = zeros(share,1);
for p = 1:share
    ty(p) = UniBsplineBasic(4,ctr_density,tx(p)) * yc ;
end

% draw surface
tx = (max_x-min_x)*tx + min_x;

plot(tx,ty,'-b');
hold on

%draw controlling skeleton
plot(xc,yc,'-g');
hold on;

s = 1;
end


