function [lo_best_model,lo_best_inliers,lo_best_cost]=CMS_Agl2(data,lo_best_inliers,lo_best_model,emx,lo_best_cost,lamda)
    % precondition of running local optimization
    if (size(lo_best_inliers,1)<7*9)
         return;
    end
    % LLS fitting with inliers, model validation
    model = ellipsoidfit_leastsquares(lo_best_inliers(:,1),lo_best_inliers(:,2),lo_best_inliers(:,3));
    [kind,~]=find_kind(model);
    if (~strcmp(kind,'ellipsoid'))
         return;
    end
    [Q_s0,radii,~] = family(model);  
    MPD = mapping(data,Q_s0,radii); 
    dst_samp=sampson(data,model);
    CPS=(lamda*MPD+dst_samp)/(1+lamda);
    index=CPS<emx;
    model_inlier=data(index,:);
    cost=Kernel(CPS,emx); % model support
    if (cost>lo_best_cost)
        lo_best_cost = cost;
        lo_best_inliers = model_inlier;
        lo_best_model = model;
    end
    % WLS fitting, model validation
    for i=1:7
        new_emx=1.5*emx-(i-1)*(0.5*emx)/3; % update distance threshold of local optimization
        [Q_s0,radii,~] = family(model);  
        MPD = mapping(data,Q_s0,radii); 
        dst_samp=sampson(data,model);
        CPS=(lamda*MPD+dst_samp)/(1+lamda);
        [~,W]=Kernel_w(CPS,new_emx); % the weight of candidate
        model = ellipsoidfit_LLS_W(data(:,1),data(:,2),data(:,3),W);
        [kind,~]=find_kind(model);
        if (~strcmp(kind,'ellipsoid'))
             continue;
        end
        [Q_s0,radii,~] = family(model);  
        MPD = mapping(data,Q_s0,radii); 
        dst_samp=sampson(data,model);
        CPS=(lamda*MPD+dst_samp)/(1+lamda);
        index=CPS<emx;
        model_inlier=data(index,:);   
        cost=Kernel(CPS,emx);   % model support
         if (cost>lo_best_cost)
            lo_best_cost = cost;
            lo_best_inliers = model_inlier;
            lo_best_model = model;
         end
    end
end