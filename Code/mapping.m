function [d] = mapping(p,Q_s0,semiaxis)
%     p(4)=1;
%     s=sqrt(p'*Q_s0*p)-1;
%     d1=abs(s*semiaxis(1));
%     d2=abs(s*semiaxis(2));
%     d3=abs(s*semiaxis(3));
%     d=[d1 d2 d3]';
%%%%将Q_s0转化为向量形式
%     Q_s0 = [ v(1) v(4) v(5) v(7); ...
%           v(4) v(2) v(6) v(8); ...
%           v(5) v(6) v(3) v(9); ...
%           v(7) v(8) v(9) v(10) ];
    v=zeros(10,1);
    v(1)=Q_s0(1,1);v(2)=Q_s0(2,2);v(3)=Q_s0(3,3);v(4)=Q_s0(1,2);v(5)=Q_s0(1,3);
    v(6)=Q_s0(2,3);v(7)=Q_s0(1,4);v(8)=Q_s0(2,4);v(9)=Q_s0(3,4);v(10)=Q_s0(4,4);
    x=p(:,1);y=p(:,2);z=p(:,3);
    f=v(1)*x.^2 + v(2)*y.^2 + v(3)*z.^2 + 2*v(4).*x.*y + 2*v(5).*x.*z + 2*v(6).*y.*z + 2*v(7).*x + 2*v(8).*y + 2*v(9).*z + v(10);
    s=sqrt(f)-1;
    d1=abs(s*semiaxis(1));
    d2=abs(s*semiaxis(2));
    d3=abs(s*semiaxis(3));
%     d=(d1+d2+d3)/3;
    d=sqrt((d1.*d1+d2.*d2+d3.*d3))/3;

end