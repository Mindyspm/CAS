function d = sampson(p,v)
%          -  the 10 parameters describing the ellipsoid / conic algebraically: 
%                Ax^2 + By^2 + Cz^2 + 2Dxy + 2Exz + 2Fyz + 2Gx + 2Hy + 2Iz + J = 0
%                  f2-f1=d*gradient
    x=p(:,1);
    y=p(:,2);
    z=p(:,3);
    f=v(1)*x.^2 + v(2)*y.^2 + v(3)*z.^2 + 2*v(4).*x.*y + 2*v(5).*x.*z + 2*v(6).*y.*z + 2*v(7).*x + 2*v(8).*y + 2*v(9).*z + v(10);
    Fx=2*v(1)*x+2*v(4)*y+2*v(5)*z+2*v(7);
    Fy=2*v(2)*y+2*v(4)*x+2*v(6)*z+2*v(8);
    Fz=2*v(3)*z+2*v(5)*x+2*v(6)*y+2*v(9);
    gradient=sqrt(Fx.*Fx+Fy.*Fy+Fz.*Fz);
    d=abs(f./gradient);
end
