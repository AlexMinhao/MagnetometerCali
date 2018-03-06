% vector
% v = rand(1,3)*2-1;
% v = v/norm(v);
% theta
% theta = rand(1)*2*pi;
% quaternion
% q = [sin(theta/2)*v(1),sin(theta/2)*v(2),sin(theta/2)*v(3),cos(theta/2)];
V=[];
Q=[];
m_init = [0,100,0,100];
M = [];
for i= 1:5000
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
     M = [M;m];
end
plot3(M(:,2),M(:,3),M(:,4),'.');hold;
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
for k = 1:length(M(:,1))
    M0 = [M(k,2) M(k,3) M(k,4)];
%     mx = M(k,2)*avg/a+xc;
%     my = M(k,3)*avg/b+yc;
%     mz = M(k,4)*avg/c+zc;
%     m_raw=[mx my mz];
%     M_raw = [M_raw;m_raw];
    m_raw = S * M0' +H';
    M_raw = [M_raw m_raw];
end
M_raw = M_raw';
plot3(M_raw(:,1),M_raw(:,2),M_raw(:,3),'.');


