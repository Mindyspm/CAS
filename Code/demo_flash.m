clc;clear;close;
% initialization the parameter
emx=0.3;  % distance threshold¶≈
sample_size=9; %  sample size
p=0.95;   % probability
lamda=1;  % balance-item
firstplot=true; flag_ture_plot=true;
mesh_number=30;
color=zeros(mesh_number+1);
color(:,:,1)=0;
color(:,:,2)=1;
color(:,:,3)=0;%red
noise_level= [0.1, 0.15, 0.2, 0.25, 0.3, 0.35 0.4 10, 15, 20, 25, 30, 35, 40];
a=1; b=2; c=3; shiftx = 4; shifty = 5; shiftz = 6; ang = pi/3; % radii and center of ellipsoid
for i=1:1:14 %%%%
    for j=1:1:10  %%%% produce 10  Guassian-noise instances, 10 Random-noise instances
        [ s, t ] = meshgrid( -pi : 0.20 : pi, 0 : 0.20 : pi );
        %%Õ÷«Ú√Ê
        x = a * sin(s) .* cos( t );
        y = b * sin(s) .* sin( t );
        z = c * cos(s);
        % rotation
        xt = x * cos( ang ) - y * sin( ang );
        yt = x * sin( ang ) + y * cos( ang );
        % translation
        x = xt + shiftx;
        y = yt + shifty;
        z = z  + shiftz;
        % produce Guassian-noise instance
        if i<8
            noiseIntensity = noise_level(i); 
            Gx = x + randn( size( s ) ) * noiseIntensity;
            Gy = y + randn( size( s ) ) * noiseIntensity;
            Gz = z + randn( size( s ) ) * noiseIntensity;
            data=[Gx(:) Gy(:) Gz(:)];
            data=data(randperm(size(data,1),500),:);
        else
           % produce random-noise instance
            noiseIntensity = 0.25;  % add ¶“=0.25 Gaussian noise
            Gx = x + randn( size( s ) ) * noiseIntensity;
            Gy = y + randn( size( s ) ) * noiseIntensity;
            Gz = z + randn( size( s ) ) * noiseIntensity;
            data1=[Gx(:) Gy(:) Gz(:)];
            data1=data1(randperm(size(data1,1),500),:);
            propotion=noise_level(i)/100; % RANDOM noise level=10:5:40
            random_x= 0 + (8-0).*rand(500*propotion,1);
            random_y= 1 + (9-1).*rand(500*propotion,1);
            random_z= 2 + (10-2).*rand(500*propotion,1);
            data2=[random_x,random_y,random_z];
            data=[data1;data2];
        end
        % fitting with CMS
        [model,inlier,count] = CMS(data,emx,sample_size,p,lamda);
         % plot the surface
        [center,radii,~,R] = ellipsoid_im2ex(model);
        [x,y,z] = ellipsoid(0,0,0,radii(1),radii(2),radii(3),mesh_number);
        X = [x(:),y(:),z(:)]*R;
        n = realsqrt(numel(x));
        x = reshape(X(:,1),n,n) + center(1);  % add center offset
        y = reshape(X(:,2),n,n) + center(2);
        z = reshape(X(:,3),n,n) + center(3);
        if firstplot
            h_p = scatter3(data(:,1),data(:,2),data(:,3),'.k'); 
            hold on;
            h_m = surf(x,y,z, color,'EdgeColor', 'none','FaceAlpha', 0.8);
            str_title=['Input: Guassian-noise data; Noise level:¶“=', num2str(noise_level(i)),'Instance_index:',num2str(j)];
            h_t = title(str_title);
            axis vis3d equal;         
            axis([shiftx-a-1 shiftx+a+1 shifty-b-1 shifty+b+1 shiftz-c-1 shiftz+c+1]);
            axis off;
            camlight;
            lighting phong;
            legend('Input data','Fitting result','location','northeast');
            firstplot = false;
        else
            set(h_p, {'XData', 'YData', 'ZData'}, {data(:,1), data(:,2), data(:,3)});
            set(h_m, {'XData', 'YData', 'ZData'},{x, y, z});
            if i<8
                str_title=['Input: Guassian-noise data; Noise level:¶“=', num2str(noise_level(i)),'; Instance index:',num2str(j)];
            else
                str_title=['Input: Ruassian-noise data; Noise level:', num2str(noise_level(i)),'%; Instance index:',num2str(j)];
            end
            set(h_t, 'String',str_title);
        end
        drawnow;
    end
end;
