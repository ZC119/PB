close all
clear all

%mkdir('./PB_theoremCoeCheck')
%mkdir('./iteration_100')
files = dir('./data/PD4theorem/*.txt');

res=20;
sig=0;

for iteration = 100:100:1000
    dirname = ['iteration_' num2str(iteration)];
    dirpath = fullfile(cd,'data','PB_theoremCoeCheck',dirname);
    mkdir(dirpath);
for i = 1:length(files)
    file_path = fullfile(cd,'data','PD4theorem', files(i).name);

    PD = load(file_path);
    
    xr = PD(:, 1);

    yr = PD(:, 2) - PD(:,1);
    
    persistence = yr;

    [zr, num_dis_eps]= eminencef(xr, yr, persistence, sig);

    [xc,yc,zc,error] = BSplineApproximation(xr,yr,zr,res,iteration);
  
    zc = reshape(zc, [res * res, 1]);
    save([dirpath '/' files(i).name], 'zc', '-ascii')
end

end
