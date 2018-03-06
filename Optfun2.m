function L = Optfun2(h)
% parameters
    H = [h(1);h(2);h(3)];
    A = [h(4) h(5) h(6);h(7) h(8) h(9);h(10) h(11) h(12)];
% input
    global  M_input1 Hp
   
    m= double(M_input1);
    m_size = length(m);
    mx = zeros(1,m_size);my = zeros(1,m_size);mz = zeros(1,m_size); M = zeros(3,m_size);
    for i = 1:m_size
        mx(i)=m(i,1); my(i)=m(i,2); mz(i) = m(i,3);
        M(:,i) = [mx(i);my(i);mz(i)]; 
    end
    
     l = zeros(1,m_size);
    
    for k = 1:m_size
        mmm =M(:,k)-H;
        l(k)=((M(:,k)-H)'*A*(M(:,k)-H)-1)^2; 
        
    end
  
    L = sum(l);
    Hp=[Hp H];
end