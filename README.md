# ellipsoid-fitting-with-CPS


For the synthetic dataset, the name rule for files is as following:
1) The first character "G" represents "Gaussian noise" and the first character "R" represents "Random noise". 
2) The next two numbers (separated by the "num") represent noise level and idx of instance, respectively. 
For example,  the file with the name of "G0.5num4.txt" represents that the instance contains the Gaussian noise of σ=0.25 and the instance idx is 4. 
The file with the name of "R20num6" represents that the instance contains the random noise of 20 percent and the instance idx is 6.
Note that the ellipsoid that is produced by fitting the data in the file with the name of "PointCloud_Standard.txt" is the groundtruth for the synthetic dataset.

----------------------------------------------------------------------------
The paper that proposes Ellipsoid fitting with CPS is under review. For prevention of copyright disputes, the MATLAB code and correpsonding test dataset will be normally available after this paper is published. Even so, the Matlab code is still attached and it is only for better peer-review. 

If you have any questions, please contact me.
