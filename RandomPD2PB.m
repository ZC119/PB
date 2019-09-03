close all
clear all
mkdir('./testPB/')
path = './testPB/test2';
mkdir(path);

% Test 1
% files = dir('./data/randomPD/*.txt');
% mkdir('./PB_ClassifyrandomPD')
% path = './PB_ClassifyrandomPD/PB_randomPD0-00';
% mkdir(path);

% Test 2
% files = dir('./data/randomPD4density/*.txt');
files = dir('./data/randomPD4distribution/*.txt');

dens=20;
eps=0.0;%0.01 0.05 0.1;
iteration=100;

for i = 1:length(files)
    file_path = ['./data/randomPD4distribution/' files(i).name];

    PD = load(file_path);
    
    xr = PD(:, 1);

    yr = PD(:, 2) - PD(:,1);
    
    persistence = yr;

    [zr, num_dis_eps]= eminencef(xr, yr, persistence, eps);

    [xc,yc,zc,error] = BSplineApproximation(xr,yr,zr,dens,iteration);
  
    zc = reshape(zc, [dens * dens, 1]);
    save([path '/' files(i).name], 'zc', '-ascii')
end
