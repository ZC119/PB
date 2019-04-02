%% An example of Persistence B-Spline of 3d dynamic system. 
% params:
% res: density of control grid
% sig: epsilon in eminence function
% iteration: number of iteration
%% Compute PB of PD H1

close all
clear all

mkdir('./PB_dynamic3d')

tic()

files = dir('./PD_dynamic3d/1_*.txt');

res=20;
sig=1e-1;
iteration=100;

for i = 1:length(files)
    file_path = ['./PD_dynamic3d/' files(i).name];

    ToyData_PD = load(file_path);
    
    xr = ToyData_PD(:, 1);

    yr = ToyData_PD(:, 2);
    
    persistence = yr;

    [zr num_dis_eps]= eminencef(xr/max(xr), yr/max(yr), persistence, sig);

    [xc,yc,zc,error] = BSplineApproximation(xr,yr,zr,res,iteration);
  
    zc = reshape(zc, [res * res, 1]);
    save(['./PB_dynamic3d/' files(i).name], 'zc', '-ascii')
end
toc()
