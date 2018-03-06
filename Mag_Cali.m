fase_data = 1;
%% False data
% vector
% v = rand(1,3)*2-1;
% v = v/norm(v);
% theta
% theta = rand(1)*2*pi;
% quaternion
% q = [sin(theta/2)*v(1),sin(theta/2)*v(2),sin(theta/2)*v(3),cos(theta/2)];
V=[];
Q=[];
m_init = [0,200,0,200];
Mc = [];
for i= 1:1000
    v = rand(1,3)*2-1;
    v = v/norm(v);
    V = [V; v];
    theta = rand(1)*2*pi; 
    q = [cos(theta/2),sin(theta/2)*v(1),sin(theta/2)*v(2),sin(theta/2)*v(3)];
    Q = [Q;quatnormalize(q)];
end
%plot3(V(:,1),V(:,2),V(:,3),'.');hold;

for j = 1:length(Q(:,1))
     q = Q(j,:);
     q_1 = quatinv(Q(j,:));
     m = quatmultiply(Q(j,:),m_init);
     m = quatmultiply(m,quatinv(Q(j,:)));
     Mc = [Mc;m];
end
% plot3(M(:,2),M(:,3),M(:,4),'.');hold;
% a , b, c, xc , yc, zc
a = 265;
b = 170;
c = 245;
xc = -20;
yc = 150;
zc = 30;
avg = (a+b+c)/3;
M_raw=[];
% Rotation
% x [1 0 0; 0 cos sin; 0 sin cos]
% y [cos 0 sin;0 1 0; sin 0 cos]
% z [cos sin 0;sin cos 0;0 0 1 ]
alpha =  0.6*pi;
Sr = [cos(alpha) 0 sin(alpha);0 1 0; sin(alpha) 0 cos(alpha)];
Ss = [avg/a 0 0; 0 avg/b 0 ; 0 0 avg/c];
S = Ss * Sr;
H = [xc yc zc];
for k = 1:length(Mc(:,1))
    M0 = [Mc(k,2) Mc(k,3) Mc(k,4)];
%     mx = M(k,2)*avg/a+xc;
%     my = M(k,3)*avg/b+yc;
%     mz = M(k,4)*avg/c+zc;
%     m_raw=[mx my mz];
%     M_raw = [M_raw;m_raw];
    m_raw = S * M0' +H';
    M_raw = [M_raw m_raw];
end
M_raw = M_raw';
%plot3(M_raw(:,1),M_raw(:,2),M_raw(:,3),'.');

%% Real Data
% s = csvread('MQ1.csv');  
% global q_raw m_raw 
% %% Quaternion
% q_raw.w = s(:,3);
% q_raw.x = s(:,4);
% q_raw.y = s(:,5);
% q_raw.z = s(:,6);
% %% Mag
% m_raw.x = s(:,7);
% m_raw.y = s(:,8);
% m_raw.z = s(:,9);

%% Start Caculate the diff
%L = length(q_raw.w);
% qx = [];qy = [];qz = [];qw = [];
% mx = [];my = [];mz = []; M = [];
% Q = [];
Qd = [];
% 
% for i=5:L
%     if(m_raw.x(i) ~= m_raw.x(i-1) || m_raw.y(i) ~= m_raw.y(i-1) || m_raw.z(i) ~= m_raw.z(i-1) )
%         qx = [qx q_raw.x(i)];qy = [qy q_raw.y(i)];qz = [qz q_raw.z(i)];qw = [qw q_raw.w(i)];
%         Qc=[q_raw.x(i) q_raw.y(i) q_raw.z(i) q_raw.w(i)];
%         Q=[Q ; Qc];
%         mx = [mx m_raw.x(i)]; my = [my m_raw.y(i)]; mz = [mz m_raw.z(i)];
%         m = [ m_raw.x(i) m_raw.y(i) m_raw.z(i)];
%         M = [M;m];
%     end
% end


%% q_diff
for i = 1:length(Q(:,1))-99
%     qdiff=q1-1 * q2
%     qdiff * m1 * qdiff-1 = m2
%     window size 100
    qdiff = quatmultiply(quatinv(Q(i+99,:)),Q(i,:));% 1-100, 2-101,3-102,4-103,5-104,...,901-1000
    Qd = [Qd; qdiff];
end
%initial characteristic
% xmin = min(mx);
% xmax = max(mx);
% ymin = min(my);
% ymax = max(my);
% zmin = min(mz);
% zmax = max(mz);
% xc = 0.5*(xmax+xmin);
% yc = 0.5*(ymax+ymin);
% zc = 0.5*(zmax+zmin);
% a = 0.5*abs(xmax-xmin);
% b = 0.5*abs(ymax-ymin);
% c = 0.5*abs(zmax-zmin);
%%
%ym = S*ym_c + H
%ym_c = S-1*(ym-H) 
% err = [];
epsilon = 0.0003;
gamma= 0.0001;
SH_old =  randn(12,1);
i = 1;
M_input = [];
for k = 1:100 %length(Qd(:,1))-99
      for j=1:10
          m1 = M_raw(i+j-1,:); % 1  - 10     6  - 15 
          m2 = M_raw(i+j+98,:);% 100-109     105 -114
          M_input = [M_input;m1;m2];
      end
      [delt_f,Loss] = Jaco(Qd(i:i+9,:),M_input,SH_old); %10q 20m
      SH_new = SH_old - gamma * double(delt_f); 
      %[SH_new,ps] = mapminmax(double(SH_new));
      fprintf('The %dth iteration, minJ_w = %f,%f,%f\n',k,Loss(1),Loss(2),Loss(3));
      
      if norm(SH_new-SH_old) < epsilon
      SH_best = SH_new;
      fprintf('The best parameter:%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',SH_best(1),SH_best(2),SH_best(3),SH_best(4),SH_best(5),SH_best(6),SH_best(7),SH_best(8),SH_best(9),SH_best(10),SH_best(11),SH_best(12));
      break;
      end
      SH_old = SH_new;
      k=k+1;
      i=i+5; %1-10,5-15
end

function q = mult(q,r)
    q0 = (q(1)*r(1)- r(2)*q(2)-q(3)*r(3)-q(4)*r(4));
    q1 = (q(2)*r(1)+ r(2)*q(1)-q(4)*r(3)+q(3)*r(4));
    q2 = (q(3)*r(1)+ r(2)*q(4)+q(1)*r(3)-q(2)*r(4));
    q3 = (q(4)*r(1)- r(2)*q(3)+q(2)*r(3)+q(1)*r(4));
    q = [q0, q1, q2, q3];
end
function q_conj = q_inv(q)
    q_conj = [q(1), q(2),q(3),-q(4)];
end


