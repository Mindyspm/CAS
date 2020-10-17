function Performance = Performance(ture_model,model,count,time,data,save_path)     

    [~,semiaxis,center] = family(model);%%%%%%%拟合的椭球
    [~,ture_semiaxis,ture_center] = family(ture_model);%%%%%%真实地椭球
    x=data(:,1);   y=data(:,2);   z=data(:,3);
    candidate_vec=[x.^2 y.^2 z.^2 2*x.*y 2*x.*z 2*y.*z 2*x 2*y 2*z ones(size(x,1),1)];
    r=candidate_vec*model;%%%%%%残差
    %精度分析 平均误差L1
    EP_L1=norm((model-ture_model),1);
    ES_L1=norm((semiaxis-ture_semiaxis),1);
    EC_L1=norm((center-ture_center),1);
    ER_L1=norm(r,1);
    
    %精度分析 L2
    EP_L2=norm((model-ture_model),2);
    ES_L2=norm((semiaxis-ture_semiaxis),2);
    EC_L2=norm((center-ture_center),2);
    ER_L2=norm(r,2);

    %%%%%%%%%%%%%%%%%成功率分析
    [lo_kind,~]=find_kind(model);
    %%形状分析
    if (strcmp(lo_kind,'ellipsoid'))
        success_model=1;
    else
        success_model=0;
    end;
    Performance=[EP_L1, ES_L1, EC_L1, EP_L2, ES_L2, EC_L2, count, time, success_model,ER_L1,ER_L2];  
    save(save_path,'Performance','-ascii','-append');
end