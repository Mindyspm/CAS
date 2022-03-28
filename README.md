# ellipsoid-fitting-with-CAS

The synthetic dataset consists of a Gaussian-noise dataset and an outlier dataset. The name rule for files is as following:
1) The first character "G" represents "an instance of Gaussian-noise dataset" and the first character "R" represents "an instance of outlier dataset". 
2) The next two numbers (separated by the "num") represent noise level and idx of instance, respectively. 

Examples：
1) The file with the name of "G0.5num4.txt" represents the instance containing the Gaussian noise of σ=0.25. The instance idx is 4. 
2) The file with the name of "R20num6.txt" represents the instance containing the outliers of 20 percent. The instance idx is 6.
3) The file with the name of "PointCloud_Standard.txt" represents the groundtruth for the synthetic dataset.

----------------------------------------------------------------------------
The paper that proposes Ellipsoid fitting with CAS is under review. For prevention of copyright disputes, the MATLAB code and correpsonding test dataset will be normally available after this paper is published. Even so, the Matlab code is still attached and it is only for better peer-review. 

If you have any questions, please contact me.
