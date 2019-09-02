%------------------------------------------------------------------------
% The purpose of this program is to produce random PDs for evaluating the
% PB method
%------------------------------------------------------------------------
% random persistence diagram
% range from 0 to 1
% density: different number of points on PDs
% distribution: a PD from a certain category follows a distribution
%

num_b = 50;
class_num = 5;
ele_num = 20;
tau = 0.02;

% different distribution:
wrdir_path = fullfile(cd, 'data','randomPD4distribution');
if ~exist(wrdir_path)
    mkdir(wrdir_path);
end

long_per = [0 0; 0.1 0.8; 0.3 0.7; 0.7 0.9];

% without long-persistence point
for j = 1:ele_num
    num_pt = num_b;
    birth = zeros(1,num_pt);
    death = zeros(1,num_pt);
    for k = 1:num_pt
        a = rand;
        b = tau*abs(randn);
        while a-b/2 < 0 || a + b/2 > 1
            a = rand;
            b = tau*abs(randn);
        end
        birth(k) = a - b/2;
        death(k) = a + b/2;
    end
    filename = fullfile(wrdir_path, ['1_' num2str(j) '.txt']);
    fileid = fopen(filename,'w');
    for m = 1:num_pt
       fprintf(fileid, '%.20f %.20f\n',birth(m), death(m));
    end
    fclose(fileid);
end
        
% with one long-persistence point
for i = 2:class_num-1
    for j = 1:ele_num
        num_pt = num_b + 1;
        birth = zeros(1,num_pt);
        death = zeros(1,num_pt);
        birth(1) = long_per(i,1)+sign(rand-0.5)*tau*rand;
        death(1) = long_per(i,2)+sign(rand-0.5)*tau*rand;
        for k = 2:num_pt
            a = rand;
            b = tau*abs(randn);
            while a-b/2 < 0 || a + b/2 > 1
            	a = rand;
                b = tau*abs(randn);
            end
            birth(k) = a - b/2;
            death(k) = a + b/2;
        end
        filename = fullfile(wrdir_path, [num2str(i) '_' num2str((i-1)*ele_num + j) '.txt']);
        fileid = fopen(filename,'w');
        for m = 1:num_pt
            fprintf(fileid, '%.20f %.20f\n',birth(m), death(m));
        end
        fclose(fileid);
    end 
end

% with one long-persistence point
for j = 1:ele_num
    num_pt = num_b+2;
    birth = zeros(1,num_pt);
    death = zeros(1,num_pt);
    birth(1) = long_per(3,1)+sign(rand-0.5)*tau*rand;
    death(1) = long_per(3,2)+sign(rand-0.5)*tau*rand;
    birth(2) = long_per(4,1)+sign(rand-0.5)*tau*rand;
    death(2) = long_per(4,2)+sign(rand-0.5)*tau*rand;
    for k = 3:num_pt
        a = rand;
        b = tau*abs(randn);
        while a-b/2 < 0 || a + b/2 > 1
            a = rand;
            b = tau*abs(randn);
        end
        birth(k) = a - b/2;
        death(k) = a + b/2;
    end
    scatter(birth, death,'b','filled');
    hold on
    plot([0 1], [0 1], 'Color',[0 0 0]);
    filename = fullfile(wrdir_path, ['5_' num2str(j) '.txt']);
    fileid = fopen(filename,'w');
    for m = 1:num_pt
       fprintf(fileid, '%.20f %.20f\n',birth(m), death(m));
    end
    fclose(fileid);
end
 %plot([0 1], [0 1], 'Color',[0 0 0])
 
% different density:
num_b = 50;
class_num = 5;
ele_num = 20;
tau = 0.02;


wrdir_path = fullfile(cd,'data', 'randomPD4density');
if ~exist(wrdir_path)
    mkdir(wrdir_path);
end

for i = 1:class_num
    for j = 1:ele_num
        num_pt = num_b + i;
        birth = zeros(1,num_pt);
        death = zeros(1,num_pt);
        for ii = 1:i
            birth(ii) = long_per(2,1)+sign(rand-0.5)*tau*rand;
            death(ii) = long_per(2,2)+sign(rand-0.5)*tau*rand;
        end    
        for k = i+1:num_pt
            a = rand;
            b = tau*abs(randn);
            while a-b/2 < 0 || a + b/2 > 1
            	a = rand;
                b = tau*abs(randn);
            end
            birth(k) = a - b/2;
            death(k) = a + b/2;
        end
        filename = fullfile(wrdir_path, [num2str(i) '_' num2str((i-1)*ele_num + j) '.txt']);
        fileid = fopen(filename,'w');
        for m = 1:num_pt
            fprintf(fileid, '%.20f %.20f\n',birth(m), death(m));
        end
        fclose(fileid);
    end 
end
