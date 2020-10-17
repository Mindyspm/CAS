function [model_star,inlier_star,count] = CMS(data,emx,sample_size,p,lamda)
        % initialization parameter
        number = size(data,1); % the number of points
        Kmax=100000;   % set the upper limit of iterations
        iter=Kmax;     % set the initial value of 'iter'
        count=0;       % counter of iteration
        best_cost=0;   % model support before local optimization
        cost_star=0;   % model support after local optimization
        % ellipsoid fitting
        while ((count<iter) && (count<Kmax))
            count=count+1;
            % random sample       
            idx = randperm(number,sample_size);
            sample_x=data(idx,1);
            sample_y=data(idx,2);
            sample_z=data(idx,3);
            % 1) LLS fitting
            if count==1
                model = ellipsoidfit_leastsquares(data(:,1),data(:,2),data(:,3));
            else
                model = ellipsoidfit_leastsquares(sample_x,sample_y,sample_z);
            end
            [Q_s0,radii,~] = family(model);       
            [kind,~]=find_kind(model);    % model validation
            if (~strcmp(kind,'ellipsoid'))
                continue;
            end
             % 2) calculate the model support - 'cost' 
            MPD = mapping(data,Q_s0,radii); 
            dst_samp=sampson(data,model);
            CPS=(lamda*MPD+dst_samp)/(1+lamda);
            index=CPS<emx;  % index of inlier, candidate classification
            model_inlier=data(index,:);   
            cost=Kernel(CPS,emx);
            if cost>best_cost
                best_cost=cost;
                best_model=model; % 'best_model' is the best model before local optimization step
                best_model_inlier=model_inlier;
                [lo_best_model,lo_best_inliers,lo_best_cost]=CMS_Agl2(data,best_model_inlier,best_model,emx,best_cost,lamda); 
                if lo_best_cost>cost_star  
                    model_star=lo_best_model; % 'model_star' is the global best model
                    cost_star=lo_best_cost;
                    inlier_star=lo_best_inliers;
                    % update the required number of the iterations
                    best_model_count=size(lo_best_inliers,1);
                    iter=log10(1-p)/log10(1-(best_model_count/number)^sample_size);
                end;
            end
            if(isinf(iter))    % note that iter = -inf when best_model_count = 0
                iter=Kmax;
            end;
        end;          
end