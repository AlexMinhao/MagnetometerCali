function L = Optfun1(h)
% bias parameters
    global H_0   flag   Hp  Hp1
    sec = 0;
    if(length(h)==6 && flag ==1) 
        H = [h(1);h(2);h(3)];
        S = [h(4) 0 0;0 h(5) 0;0 0 h(6)];
        sec = 1;
    elseif(length(h)==12 && flag ==1 )
        sec = 1;
        H = [h(1);h(2);h(3)];
        S = [h(4) h(5) h(6);h(7) h(8) h(9);h(10) h(11) h(12)];
    elseif(length(h)==9)
        H = H_0;
        S = [h(1) h(2) h(3);h(4) h(5) h(6);h(7) h(8) h(9)];
    elseif(length(h)==10)
        H = [H_0(1); H_0(2); h(1)] ;
        S = [h(2) h(3) h(4); h(5) h(6) h(7); h(8) h(9) h(10) ];
    else
        H = [h(1);h(2);h(3)];
        S = [1 0 0 ; 0 1 0 ; 0 0 1];
    end
% raw input data
    global  M_input Qd_input M_input1 Qd_input1 M_input2  FirstSize SecondSize;
% input
    
    if(sec ==1)
    m_size = SecondSize*2; q_size = SecondSize;
    qd=double(Qd_input1); m= double(M_input1);
    md = double(M_input2);
    else
    m_size = FirstSize*2; q_size = FirstSize;
    qd=double(Qd_input); m= double(M_input);
    end
    mx = zeros(1,m_size);my = zeros(1,m_size);mz = zeros(1,m_size); M = zeros(3,m_size);
    qw = zeros(1,q_size);qx = zeros(1,q_size);qy = zeros(1,q_size);qz = zeros(1,q_size); Q =zeros(q_size,4);
    mdx = zeros(1,m_size);mdy = zeros(1,m_size);mdz = zeros(1,m_size); Md = zeros(3,m_size);
    for i = 1:m_size
        mx(i)=m(i,1); my(i)=m(i,2); mz(i) = m(i,3);
        M(:,i) = [mx(i);my(i);mz(i)]; 
        if(sec == 1)
            mdx(i)=md(i,1); mdy(i)=md(i,2); mdz(i) = md(i,3);
            Md(:,i) = [mdx(i);mdy(i);mdz(i)]; 
        end
    end
    for j = 1:q_size
        qw(j)=qd(j,1);qx(j)=qd(j,2); qy(j)=qd(j,3); qz(j) =qd(j,4);
        Q(j,:) =[qw(j) qx(j) qy(j) qz(j)];
    end
    
% loss
    l = zeros(1,q_size);
    
    for k = 1:q_size
        mc1 = [0; inv(S)*(M(:,2*k-1)-H )]'; %映射到球面上
        mc2 = quatmultiply(quatmultiply(Q(k,:),mc1),quatinv(Q(k,:))); %在球面上旋转
        alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4)))); %转后两个向量的夹角
        a = norm(M(:,2*k-1));b =M(:,2*k);
        alpha2 = acos(dot(inv(S)*(M(:,2*k-1)-H ), inv(S)*(M(:,2*k)-H ))/(norm(inv(S)*(M(:,2*k-1)-H))*norm(inv(S)*(M(:,2*k)-H))));%测量到两个向量映射到球面上的夹角
        %radius = norm(mc2(2:4))-norm((inv(S)*(M(:,2*k)-H ))');%旋转后的向量与采集的向量坐标相等

        if(sec==1)
             radius = norm(Md(:,2*k-1)-H)-norm(Md(:,2*k)-H);% 两个向量距离圆心的距离
             err1 = (alpha1 - alpha2)^2; %1.36875
             err2 = 0.1*norm(radius); %365.3420
             l(k) = 10*(alpha1 - alpha2)^2 + 0.1*norm(radius);
        else
             l(k) =1.5*(alpha1 - alpha2)^2+0.5*norm(mc2(2:4)-(inv(S)*(M(:,2*k)-H))');
        end
       
        
    end
    
    L = sum(l);
    if(sec==1)
        Hp1=[Hp1 H];
    else
        Hp=[Hp H];
    end
    
end
    
    %38.2746    9.3920   -2.4755
    %34.2629   20.1122  -12.8638
    %34.3204   20.4154  -13.1033
    %33.9142   20.4431  -13.1527