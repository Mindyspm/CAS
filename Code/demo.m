clc;clear;close;
% the name of instance
dataset_name=[];
for i=1:1:14
    niose_level={'G0.1','G0.15','G0.2','G0.25','G0.3','G0.35','G0.4', 'R10', 'R15', 'R20', 'R25', 'R30', 'R35', 'R40'};
    noise_name=char(niose_level(i));
    for j=1:1:10
        Instance_num={'num1','num2','num3','num4','num5','num6','num7','num8','num9','num10'};
        num_name=char(Instance_num(j));
        Instance_name=[noise_name,num_name];
        dataset_name{(i-1)*10+j}=Instance_name;
    end;
end
% initialization the parameter
emx=0.3;  % distance threshold¦Å
sample_size=9; %  sample size
p=0.95;   % probability
lamda=1;  % balance-item
% read data of a instance
index_instance=55;
instance=char(dataset_name(index_instance));
read_path=['..\Data\synthetic_dataset\',instance,'.txt'];
data=importdata(read_path);
read_path='..\Data\synthetic_dataset\PointCloud_Standard.txt';
ture_data=importdata(read_path);
ture_model = ellipsoidfit_leastsquares(ture_data(:,1),ture_data(:,2),ture_data(:,3));
% fitting with CMS
tic;
[model,inlier,count] = CMS(data,emx,sample_size,p,lamda);         
toc; time=toc; 
% save fitting result
model=model';
save_path=['..\Result\model_',instance,'.txt']; 
save(save_path,'model','-ascii','-append');               % save the 10-parameters ellipsoid
save_path=['..\Result\performance_',instance,'.txt']; 
Performance(ture_model,model',count,time,inlier,save_path);  %  save performance 
%plot the surface
scatter3(data(:,1),data(:,2),data(:,3),'.k'); 
hold on;
plot_ellipsoid_im(ture_model,'AxesColor','red','EdgeColor','red');
hold on;
scatter3(inlier(:,1),inlier(:,2),inlier(:,3),'ob');
hold on;
plot_ellipsoid(model,data);
legend('Candidate (input)','Ground truth','Inliers (classification)','Fitting result','location','northeast');