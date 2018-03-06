% %% False data
% V=[];
% Q=[];
% m_init = [0,100,0,200];
% Mc = [];
% for i= 1:2000
%     v = rand(1,3)*2-1;
%     v = v/norm(v);
%     V = [V; v];
%     theta = rand(1)*2*pi; 
%     q = [cos(theta/2),sin(theta/2)*v(1),sin(theta/2)*v(2),sin(theta/2)*v(3)];
%     Q = [Q;quatnormalize(q)];
% end
% 
% for j = 1:length(Q(:,1))
%      m = quatmultiply(Q(j,:),m_init);
%      m = quatmultiply(m,quatinv(Q(j,:)));
%      Mc = [Mc;m];
% end
%          
H_all = [];
% for i = 1:210
    [M_raw, Q] = importdata('MQ1.csv',4050,16800);  %30 75 185 1250
    %[M_raw,n] =smooth(M_raw);
%% q_diff
Qd = [];
for i = 1:length(Q(:,1))-9
    qdiff = quatmultiply(Q(i+9,:),quatinv(Q(i,:)));
    Qd = [Qd; qdiff];
end

% a = 265;
% b = 170;
% c = 200;
% xc = -200;
% yc = 150;
% zc = 300;
% avg = (a+b+c)/3;
% M_raw=[];
% 
% alpha =  0.20*pi;
% Sr = [cos(alpha) 0 sin(alpha);0 1 0; sin(alpha) 0 cos(alpha)];
% Ss = [avg/a 0 0; 0 avg/b 0 ; 0 0 avg/c]; 
% S = Ss*Sr ;
% H0 = [xc yc zc]; 
% for k = 1:length(Mc(:,1))
%     M0 = [Mc(k,2) Mc(k,3) Mc(k,4)];
%     m_raw =  S*M0' +H0'+rand(3,1);
%     M_raw = [M_raw m_raw];
% end
%M_raw = M_raw';
%plot3(M_raw(:,1),M_raw(:,2),M_raw(:,3),'.');
S_init = randn(1,9);
%S_init = [S(1,1) S(1,2) S(1,3) S(2,1) S(2,2) S(2,3) S(3,1) S(3,2) S(3,3)];
H_init = [20 20 20];
%H_init = [51.093 1.0368 -10.3847];

global M_input ;
global M_input1; 
global M_input2; 

global Qd_input; 
global Qd_input1;

M_input1 = [];
M_input2 = [];
M_input = [];
Qd_input= [];
k=1;  
for i=1:250
          m1 = M_raw(k,:);   % 1   11  21  31  41  51  61       %数据不能太集中，容易陷入局部极小值
          m2 = M_raw(k+9,:);% 100 110 120 130 140 150 160      
          M_input = [M_input;m1;m2];
          qd_input = Qd(k,:);
          Qd_input =[Qd_input; qd_input];
          k = k+5;     %0 10 20 30
end

%31.83760163	25.23436178		-36.71492539

% f=@(p,M_input)(M_input(:,1)-p(1)).^2+(M_input(:,2)-p(2)).^2+(M_input(:,3)-p(3)).^2-p(4)^2;
% p=nlinfit(M_input,zeros(size(M_input,1),1),f,[0 0 0 1]');%拟合的参数
% hold on
%plot3(M_input(:,1),M_input(:,2),M_input(:,3),'*');hold on;
% [X,Y,Z]=meshgrid(linspace(-100,100));
% V=(X-p(1)).^2+(Y-p(2)).^2+(Z-p(3)).^2-p(4)^2;
% isosurface(X,Y,Z,V,0);
% 
% alpha .5;camlight;axis equal;grid on;view(3);
% 
% title(sprintf('(x-%f)^2+(y-%f)^2+(z-%f)^2=%f',p(1),p(2),p(3),p(4)^2))

% for j=1:20
%     p1 =[ M_input(2*j-1,1),M_input(2*j-1,2),M_input(2*j-1,3)];
%     p2 =[M_input(2*j,1),M_input(2*j,2),M_input(2*j,3)];
%     plot3(p1(1),p1(2),p1(3),'*','Color','b');hold on;
%     plot3(p2(1),p2(2),p2(3),'*','Color','r');hold on;
%     plot3([p1(1),p2(1)],[p1(2),p2(2)],[p1(3),p2(3)],'-');
% end
% 
% plot3(M_raw(:,1),M_raw(:,2),M_raw(:,3),'.','Color','g');
% 
% [xi,yi]=meshgrid(linspace(min(M_input(:,1)),max(M_input(:,1)),100),linspace(min(M_input(:,2)),max(M_input(:,2)),100));
% zi=griddata(M_input(:,1),M_input(:,2),M_input(:,3),xi,yi,'v4');
% surf(xi,yi,zi);
 
% tri = delaunay(M_input(:,1),M_input(:,2));
% trisurf(tri,M_input(:,1),M_input(:,2),M_input(:,3));
%% First iteration
global H_0 flag Hp Hp1;
flag = 0;
Hp = [];
%'PlotFcns',@optimplotfval,
%H_init = [-200 150 300];
% 单纯形法
options = optimset('Display','iter','TolX',0.0000001,'MaxFunEvals',1000,'MaxIter',1000,'TolFun',0.000001);
[H,fval_H,exitflag,output] = fminsearch('Optfun1',H_init,options);
% 牛顿法
% options = optimoptions(@fminunc,'Algorithm','quasi-newton','MaxFunEvals',5000,'MaxIter',11000,'TolX',0.0001,'TolFun',0.00001);
% [H,fval_H]=fminunc('Optfun1',H_init,options);
% 
H_0 = [H(1); H(2); H(3)];

%% Second iteration

Qd = [];
for i = 1:length(Q(:,1))-19
    qdiff = quatmultiply(Q(i+19,:),quatinv(Q(i,:)));
    Qd = [Qd; qdiff];
end

for step = 1:10
    for i=((step-1)*100+1):step
          m1 = M_raw(k,:);   % 1   11  21  31  41  51  61       %数据不能太集中，容易陷入局部极小值
          m2 = M_raw(k+19,:);% 100 110 120 130 140 150 160      
          M_input1 = [M_input1;m1;m2];
          qd_input = Qd(k,:);
          Qd_input1 =[Qd_input1; qd_input];
          k = k+5;     %0 10 20 30
    end
    
    % Select point
    num= length(M_raw);
    idx = knnsearch(M_raw,H_0','k',num); % 这里要改改了 点不够

    for i =  1:num
    m1 =M_raw(idx(i),:);
    m2 = M_raw(idx(num+1-i),:);
    M_input2 = [M_input2;m1;m2];
    end
    
    flag = 1;
    SH_init = [H_0' S_init];

    options = optimoptions(@fminunc,'Display','iter','PlotFcns',@optimplotfval,'Algorithm','quasi-newton','MaxFunEvals',5000,'MaxIter',2000,'TolX',0.00000001,'TolFun',0.00000001);
    [H,fval_SH]=fminunc('Optfun1',SH_init,options);
    
    H_0 = [H(1); H(2); H(3)];
end







%M_input1 = M_raw;
% options = optimset('Display','iter','TolX',0.000000001,'MaxFunEvals',5000,'MaxIter',3000,'TolFun',0.000000001);
% [H,fval_SH,exitflag,output] = fminsearch('Optfun1',SH_init,options);
% 
% options = optimoptions('lsqnonlin','Display','iter','MaxFunctionEvaluations',40000,'MaxIterations',3000,'Algorithm','levenberg-marquardt');
% H = lsqnonlin('Optfun1',SH_init,[],[],options);

% 有约束
% A = [];
% b = [];
% Aeq = [];
% beq = [];
% lb = [];
% ub = [];
% nonlcon = @mycon;
% options = optimoptions('fmincon','Display','iter','Algorithm','active-set','MaxFunctionEvaluations',6000 );
% [H,fval_SH,exitflag,output] = fmincon('Optfun1',SH_init,A,b,Aeq,beq,lb,ub,nonlcon,options);


% 
Hf = [H(1) H(2) H(3)];
plot3(M_raw(:,1),M_raw(:,2),M_raw(:,3),'.');hold on;
plot3(H_0(1),H_0(2),H_0(3),'*');
plot3(Hf(1),Hf(2),Hf(3),'*');
plot3(8,28,-36,'*');
figure;
%plot3(M_raw(:,1),M_raw(:,2),M_raw(:,3),'.');
plot3(M_input2(:,1),M_input2(:,2),M_input2(:,3),'o');hold on;
plot3(M_input1(:,1),M_input1(:,2),M_input1(:,3),'.');
plot3(M_raw(idx(1),1),M_raw(idx(1),2),M_raw(idx(1),3),'*');
plot3(H_0(1),H_0(2),H_0(3),'*');
 plot3(M_raw(idx(num),1),M_raw(idx(num),2),M_raw(idx(num),3),'*');

