function [Q_s0,semiaxis,center] = family(v)
%     Q = [ v(1) v(4) v(5) v(7); ...
%           v(4) v(2) v(6) v(8); ...
%           v(5) v(6) v(3) v(9); ...
%           v(7) v(8) v(9) v(10) ];

Q33=[ v(1) v(4) v(5); ...
          v(4) v(2) v(6); ...
          v(5) v(6) v(3)];
    q79=[v(7),v(8),v(9)]';
    [U, D] = eig(Q33);
    R=U';
    T=D\U'*q79;
    t=T'*D*T-v(10);
    diag_r=D/t;
    Q_s0=[R'*diag_r*R, R'*diag_r*T;
          T'*diag_r*R, T'*diag_r*T];
    semiaxis=sqrt(1./[diag_r(1,1),diag_r(2,2),diag_r(3,3)]);
    semiaxis=sort(semiaxis);
    center=-R'*T;
end