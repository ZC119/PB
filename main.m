%% An example of Persistence B-Spline of toydata. 
% a simple synthetic toy data set that contained a circle with its
% radius 0.4, two concentric circles with their radii 0.2 and 0.4,
% respectively, two disjoint circles with both their radii 0.2, a
% cluster of points sampled at random in the normal square,
% and two clusters of points sampled at random separately in
% two squares with edge length 0.5. All data were sampled in
% the range of [−0.5, 0.5]^2 on the 2D plane.

% params:
% res: density of control grid
% sig: epsilon in eminence function
% iteration: number of iteration
%% Compute PB of PD H1

close all
clear all

mkdir('./PB')

tic()

files = dir('./PD_toydata/1_*.txt');

res=20;
sig=1e-10;
iteration=100;

for i = 1:length(files)
    file_path = ['./PD_toydata/' files(i).name];

    ToyData_PD = load(file_path);
    
    xr = ToyData_PD(:, 1);

    yr = ToyData_PD(:, 2);
    
    persistence = yr;

    [zr num_dis_eps]= weightingf(xr/max(xr), yr/max(yr), persistence, sig);

    [xc,yc,zc,error] = BSplineApproximation(xr,yr,zr,res,iteration);
  
    zc = reshape(zc, [res * res, 1]);
    save(['./PB/' files(i).name], 'zc', '-ascii')
end
toc()

%% Compute PB of PD H0

tic()

files = dir('./PD_toydata/0_*.txt');

res=20;
sig=1e-3;
iteration=100;

for i = 1:length(files)
    file_path = ['./PD_toydata/' files(i).name];

    ToyData_PD = load(file_path);
    
    xr = ToyData_PD(:, 2);
    yr = xr;
 
    [yr num_dis_eps]= weightingf(xr/max(xr), yr/max(yr), yr, sig);

    [xc,yc,error] = BSplineApproximationCurve(xr,yr,res,iteration,10^(-3));

    save(['./PB/' files(i).name], 'yc', '-ascii')
end

toc()