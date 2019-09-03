clc
clear

row_num = 11;
col_num = 1000;
v_normp = zeros(row_num,col_num);
p = 1; % p = 1,2, Inf

dirpath = fullfile(cd,'PB4theorem_iteration');
files = dir(dirpath);
index_r = 1;
index_c = 1;

for i = 3:length(files)
    idirpath = fullfile(dirpath,files(i).name);
    file_vec = dir([idirpath '/*.txt']);
    for j = 1:length(file_vec)
        file_vec_path = fullfile(idirpath,file_vec(j).name);
        v = load(file_vec_path);
        v_normp(index_r,index_c) = norm(v,p);
        index_c=index_c + 1;
    end
    index_r = index_r + 1;
    index_c = 1;
end
 
for i = 1:row_num
    v_normp(i,:) = v_normp(i,:)./v_normp(row_num,:);
end

v_mean = mean(v_normp,2);
v_stdvar = std(v_normp,0,2);

upper_p = v_mean + v_stdvar;
lower_p = v_mean - v_stdvar;

t = [10,100,200,300,400,500,600,700,800,900,1000]';
plot(t,v_mean,'-b');
hold on 
%plot(t,upper_p,'-.b');
%hold on
%plot(t,lower_p,'--b');






