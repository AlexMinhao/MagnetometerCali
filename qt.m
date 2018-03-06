% q1 = [0.3360    0.2887   -0.5749   -0.6879]; %m1 = minit q1  %m10 = minit q10
% q10 = [-0.3948   -0.1554   -0.6333    0.6473];
% gamma = acos(2*dot(q1,q10)^2-1)/pi*180;
% %fprintf('gamma =  %f\n',gamma);
% 
% m1 = [0   -0.6075   -0.7942   -0.0110];
% m10 =[0   -0.6400   -0.3142   -0.7012];
% 
% beta = acos(dot(m1,m10)/(norm(m1)*norm(m10)))/pi*180;
% %fprintf(' beta = %f\n',beta);
% 
% qd = quatmultiply(quatinv(q1),q10);
% alpha = acos(qd(1)/norm(qd))/pi*180;
% %fprintf('alpha =  %f\n',alpha);
% 
% m10_ = quatmultiply(qd,m1);
% m10_ = quatmultiply(m10_,quatinv(qd));
% %fprintf(' m = %f,%f，%f，%f\n',m10_(1),m10_(2),m10_(3),m10_(4));
% 
% 
% 
% a = [1,0,0];
% a = [0,a];
% 
% b1 = quatmultiply(q1,a);
% b1 = quatmultiply(b1,quatinv(q1));
% b1 = b1(2:4);
% 
% b2 = quatmultiply(q10,a);
% b2 = quatmultiply(b2,quatinv(q10));
% b2 = b2(2:4);
% a = a(2:4);
% theta=acos(dot(b1,b2)/(norm(b1)*norm(b2)))/pi*180;
% %fprintf('theta =  %f\n',theta);
% 
% %H = [0 0 0];
% xc = -20;
% yc = 150;
% zc = 30;
% H = [xc yc zc];
% ms1 =  m1(2:4)+H;%M_raw(1,:);
% ms2 = m10(2:4)+H;%M_raw(10,:);
% %q1 = Q(1,:);
% %q10= Q(10,:);
% qd = quatmultiply(q10,quatinv(q1));
% mc1 = [0 ms1-H ];
% mc2 = quatmultiply(quatmultiply(qd,mc1),quatinv(qd));
% alpha1 = acos(dot(mc1,mc2)/(norm(mc1)*norm(mc2)))/pi*180;
% alpha2 = acos(dot(ms1-H, ms2-H)/(norm(ms1-H)*norm(ms2-H)))/pi*180;
% Theta = alpha1 - alpha2;
% %fprintf('Theta =  %f\n',Theta);
%  
% a1 = [0 0 0 1]; b1 = quatmultiply(quatmultiply(q1,a1),quatinv(q1));
%                 b2 = quatmultiply(quatmultiply(q10,a1),quatinv(q10));
% z1 =  b1(4) - b2(4);
% z2 =  m1(4) - m10(4);
% 
% a = 265;
% b = 170;
% c = 245;
% avg = (a+b+c)/3;
% %1.修改了些参数，调整了下，现在能够收敛到最小值，x,y,z三个偏移量都能找到了。w
% %2.我试着把算法放到椭球面上，如果直接把旋转，缩放和偏移三类放在一起同时优化的话效果不好。所以我就先只把偏移和scale放在一起算。
% %效果还是不好，但是我发现单独算偏移的三个量相对准确些。我就把他们分开，先算偏移量，然后用偏移量去优化scale。效果好一些，
% %能找到比较准确的scale的值。所以分开算，就可能算出相对准确的bias 和 scale。
% %3.我今天用真实的数据跑了下，找到的最有解基本上都是向中心点逼近的，但是就像昨晚说的那样，这个求除了有中心偏移误差外，
% %还有缩放和旋转误差，而且只用了这个椭圆的一部分点做优化，所以最优解都只是在中心点一侧附近。具体的结果图我发在企业微信群里。
% % 我今天试了下加些阈值进来，但是我发现阈值其实作用不明显。因为我把每组点分别plot出来后看他们的夹角，其实夹角挺大，基本每组点
% % 之间的夹角都有30-60度以上。我觉还是应该对这些点做更近一步的预处理，使它们能均匀的分布在一个平滑的曲面上，让这个曲面尽量近似
% % 为球面
% %下午讨论了一下，大概的功能和形式应该确定了，有些比较清晰的和必要的功能比如大小腿跑步的姿态，平衡性等这两天就可以做了，还有些想法也可以快速验证了
% 我今天把昨晚讨论的几个改进方法加了进去试了下，只考虑缩放矩阵，增加constraint，改变第二轮迭代取点的形式，同时改了下
% 优化的算法，效果确实所提升，找到的点比之前更近了些
% 今天测试了不同的选点，看出了些问题，比如选最近和最远的点到优化中心的距离相等。我们理想的情况是，最近点和最远点是分布在椭球中心的两侧，
% ，这样能更好的保证优化中心向着椭球心移动，但是有时候却不是，有些时候，最远点和最近点分布在椭球中心的同一侧，在一个半球上，这就效果很
% 不好了，所以要选点的时候能保证最远最近点分布在两个半球上才能保证结果
% alpha =  0.3*pi;
% Sr = [cos(alpha) 0 sin(alpha);0 1 0; sin(alpha) 0 cos(alpha)];
% Ss = [avg/a 0 0; 0 avg/b 0 ; 0 0 avg/c];
% S = Ss * Sr;
% S = [1 0 0 ; 0 1 0 ; 0 0 1];
% H = [-200; 150; 300];
% M1 = [-84.3515; 162.0603; 490.9973];
% M2 = [-52.5502; 204.3581; 204.3581];                                                                                                                      
% mc1 = [0; inv(S)*(M1-H )]'; %0  115.6485   12.0603  190.9973
% q = [-0.9283 -0.1270 -0.1447 -0.3182];
% mc2 = quatmultiply(quatmultiply(q,mc1),quatinv(q));%0  147.4498   54.3581  159.0715
% mc22 =[0;inv(S)*(M2-H )];
% alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
% alpha2 = acos(dot(inv(S)*(M1-H ), inv(S)*(M2-H ))/(norm(inv(S)*(M1-H ))*norm(inv(S)*(M2-H ))));

%% 
% [M_raw, Q] = importdata('MQ1.csv',600,16000);
% M0=zeros(length(M_raw(:,3)),4);
% for i = 1:length(M_raw(:,3))
%     mi = [0 M_raw(i,:)];
%     m0 = quatmultiply(quatmultiply(quatinv(Q(i,:)),mi),Q(i,:));
%     M0(i,:)=[m0(1) sqrt(m0(2)^2+m0(3)^2) 0 m0(4)];
% end
% plot3(M0(:,2),M0(:,3),M0(:,4),'.');
% hold on;
%plot3(M_raw(:,1),M_raw(:,2),M_raw(:,3),'.');
figure;
plot(M_raw(:,1),M_raw(:,2),'.') %x-y
title('X-Y')
figure;
plot(M_raw(:,2),M_raw(:,3),'.');%y-z
title('Y-Z')
figure;
plot(M_raw(:,1),M_raw(:,3),'.');%x-z
title('X-Z')
