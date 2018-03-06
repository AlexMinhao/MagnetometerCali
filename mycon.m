function [c, ceq] = mycon(h)
     global M_input1;
     X = M_input1;
     
     H = [h(1);h(2);h(3)];
     S = [h(4) h(5) h(6);h(7) h(8) h(9);h(10) h(11) h(12)];
     
     m= double(M_input1);
     m_size = length(m);
     mx = zeros(1,m_size);my = zeros(1,m_size);mz = zeros(1,m_size); M = zeros(3,m_size);
     for i = 1:m_size
        mx(i)=m(i,1); my(i)=m(i,2); mz(i) = m(i,3);
        M(:,i) = [mx(i);my(i);mz(i)]; 
     end
     x = diag(inv(S)*(M-H))'*(inv(S)*(M-H));
     ceq = x' -ones(length(M(3,:)),1);
     c = 0;
end