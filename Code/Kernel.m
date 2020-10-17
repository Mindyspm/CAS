function [Energy]= Kernel(dis,sigma)
    % Gaussian kernel function 
    dimension=size(sigma);
    if (dimension(2)==1)
        Energy_p=exp(-dis(:).^2/(2*sigma(1)^2));
    elseif (dimension(2)==2)
        Energy_p=exp(-dis(:,1).^2/(2*sigma(1)^2)-dis(:,2).^2/(2*sigma(2)^2));
    elseif (dimension(2)==3)
        Energy_p=exp(-dis(:,1).^2/(2*sigma(1)^2)-dis(:,2).^2/(2*sigma(2)^2)-dis(:,3).^2/(2*sigma(3)^2));
    elseif (dimension(2)==4)
        Energy_p=exp(-dis(:,1).^2/(2*sigma(1)^2)-dis(:,2).^2/(2*sigma(2)^2)-dis(:,3).^2/(2*sigma(3)^2)-dis(:,4).^2/(2*sigma(4)^2));
    end
    Energy=sum(Energy_p(:));
end
