function s = MyBsplineshow(xc, yc, zc, share, ctr_density)
% Function: Bspline surface show 
% Attention: Uniform knots B spline surface with its end points interpolate onto the
% controlling point
% Input:
% xc: A vector, x value of controlling point.
% yc: A vector, y value of controlling point.
% zc: A square matrix storing z value of each grid point.
% share: the share of uniform knot division.
% ctr_density: the density of controlling points
%
% Output;
% this function should have no return.
% s: if success, return 1;
%

s = 0;
min_x = min(xc);
min_y = min(yc);
max_x = max(xc);
max_y = max(yc);
n = length(xc);

% sampling points on B-spline surface
tx = 0:1/(share-1):1;
ty = tx;

tz = zeros(share);
for p = 1:share
    for q = 1:share
        tz(p,q) = UniBsplineBasic(4,ctr_density,tx(p)) * zc * (UniBsplineBasic(4,ctr_density,ty(q))');
    end
end
tz = tz';
% draw surface
tx = (max_x-min_x)*tx + min_x;
ty = (max_y-min_y)*ty + min_y;

h = figure;
ax = axes('Parent',h);
ax.YAxis.Visible = 'off';


s = surf(tx,ty,tz);

s.EdgeColor = 'none';
hold on

%draw controlling skeleton
for p = 1:n
    for q = 1:n-1
        plot3([xc(p) xc(p)],[yc(q) yc(q+1)],[zc(p,q) zc(p,q+1)],'-r');

        hold on
        plot3([xc(q) xc(q+1)],[yc(p) yc(p)], [zc(q,p) zc(q+1,p)],'-r');

        hold on
        
    end
end
%axis off
xlabel('Birth')
ylabel('Persistence')
s = 1;
end


