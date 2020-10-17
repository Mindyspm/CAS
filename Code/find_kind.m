function [kind,invariant]=find_kind(coff)
    %  ellipsoid£º I1*I3>0,I4<0,I2>0
    a11=coff(1);a22=coff(2);a33=coff(3);a12=coff(4);a13=coff(5);a23=coff(6);a14=coff(7);a24=coff(8);a34=coff(9);a44=coff(10);
    I1=a11+a22+a33;
    I2=det([a11 a12;a12 a22])+det([a11 a13;a13 a33])+det([a22 a23;a23 a33]);
    I3=det([a11 a12 a13;a12 a22 a23;a13 a23 a33]);
    I4=det([a11 a12 a13 a14;a12 a22 a23 a24;a13 a23 a33 a34;a14 a24 a34 a44]);
     invariant=[I1 I2 I3 I4]';
    if ((I2>0) && (I1*I3>0) && (I4<0))
        kind='ellipsoid';
    else
        kind='unknown';
    end
end
         

