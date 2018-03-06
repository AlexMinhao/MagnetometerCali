% %% False data
% V=[];
% Q=[];
% m_init = [0,200,0,200];
% Mc = [];
% for i= 1:1000
%     v = rand(1,3)*2-1;
%     v = v/norm(v);
%     V = [V; v];
%     theta = rand(1)*2*pi; 
%     q = [cos(theta/2),sin(theta/2)*v(1),sin(theta/2)*v(2),sin(theta/2)*v(3)];
%     Q = [Q;quatnormalize(q)];
% end
% %plot3(V(:,1),V(:,2),V(:,3),'.');hold;
% 
% 
% 
% for j = 1:length(Q(:,1))
%      %q = Q(j,:);
%      %q_1 = quatinv(Q(j,:));
%      m = quatmultiply(Q(j,:),m_init);
%      m = quatmultiply(m,quatinv(Q(j,:)));
%      Mc = [Mc;m];
% end
%% Real data
[Mc, Q] = importdata('MQ.csv',2294,6863);

%% q_diff
Qd = [];
for i = 1:length(Q(:,1))-99
%     qdiff=q1-1 * q2
%     qdiff * m1 * qdiff-1 = m2
%     window size 100
    qdiff = quatmultiply(Q(i+99,:),quatinv(Q(i,:)));
    Qd = [Qd; qdiff];
end
% err=0;
% o = 1;
% for i = 1:20
%     
%     m50_ = quatmultiply(Qd(o,:),Mc(o,:));
%     m50_ = quatmultiply(m50_,quatinv(Qd(o,:)));
%     m50_0 = Mc(o+99,:);
%     err = err+ m50_- m50_0 ;
%     o=o+10;
% end
%plot3(Mc(:,2),Mc(:,3),Mc(:,4),'.');hold;
% a , b, c, xc , yc, zc
a = 265;
b = 170;
c = 245;
xc = -200;
yc = 150;
zc = 30;
avg = (a+b+c)/3;
M_raw=[];

alpha =  0.3*pi;
Sr = [cos(alpha) 0 sin(alpha);0 1 0; sin(alpha) 0 cos(alpha)];
Ss = [avg/a 0 0; 0 avg/b 0 ; 0 0 avg/c];
S = Ss * Sr;
H0 = [xc yc zc];
for k = 1:length(Mc(:,1))
    M0 = [Mc(k,2) Mc(k,3) Mc(k,4)];
    m_raw =  M0 +H0; %+ 5*rand(1,3);
    M_raw = [M_raw; m_raw];
end
%M_raw = M_raw';
%plot3(M_raw(:,1),M_raw(:,2),M_raw(:,3),'.');

%%
    syms h1 h2 h3 %s11 s12 s13 s21 s22 s23 s31 s32 s33 
    syms mx1 mx2 mx3 mx4 mx5 mx6 mx7 mx8 mx9 mx10 mx11 mx12 mx13 mx14 mx15 mx16 mx17 mx18 mx19 mx20 mx21 mx22 mx23 mx24 mx25 mx26 mx27 mx28 mx29 mx30 mx31 mx32 mx33 mx34 mx35 mx36 mx37 mx38 mx39 mx40 %mx41 mx42 mx43 mx44 mx45 mx46 mx47 mx48 mx49 mx50 
    syms my1 my2 my3 my4 my5 my6 my7 my8 my9 my10 my11 my12 my13 my14 my15 my16 my17 my18 my19 my20 my21 my22 my23 my24 my25 my26 my27 my28 my29 my30 my31 my32 my33 my34 my35 my36 my37 my38 my39 my40 %my41 my42 my43 my44 my45 my46 my47 my48 my49 my50
    syms mz1 mz2 mz3 mz4 mz5 mz6 mz7 mz8 mz9 mz10 mz11 mz12 mz13 mz14 mz15 mz16 mz17 mz18 mz19 mz20 mz21 mz22 mz23 mz24 mz25 mz26 mz27 mz28 mz29 mz30 mz31 mz32 mz33 mz34 mz35 mz36 mz37 mz38 mz39 mz40 %mz41 mz42 mz43 mz44 mz45 mz46 mz47 mz48 mz49 mz50  
    syms qx1 qx2 qx3 qx4 qx5 qx6 qx7 qx8 qx9 qx10 qx11 qx12 qx13 qx14 qx15 qx16 qx17 qx18 qx19 qx20 %qx21 qx22 qx23 qx24 qx25 qx26 qx27 qx28 qx29 qx30 qx31 qx32 qx33 qx34 qx35 qx36 qx37 qx38 qx39 qx40 qx41 qx42 qx43 qx44 qx45 qx46 qx47 qx48 qx49 qx50   
    syms qy1 qy2 qy3 qy4 qy5 qy6 qy7 qy8 qy9 qy10 qy11 qy12 qy13 qy14 qy15 qy16 qy17 qy18 qy19 qy20 %qy21 qy22 qy23 qy24 qy25 qy26 qy27 qy28 qy29 qy30 qy31 qy32 qy33 qy34 qy35 qy36 qy37 qy38 qy39 qy40 qy41 qy42 qy43 qy44 qy45 qy46 qy47 qy48 qy49 qy50  
    syms qz1 qz2 qz3 qz4 qz5 qz6 qz7 qz8 qz9 qz10 qz11 qz12 qz13 qz14 qz15 qz16 qz17 qz18 qz19 qz20 %qz21 qz22 qz23 qz24 qz25 qz26 qz27 qz28 qz29 qz30 qz31 qz32 qz33 qz34 qz35 qz36 qz37 qz38 qz39 qz40 qz41 qz42 qz43 qz44 qz45 qz46 qz47 qz48 qz49 qz50  
    syms qw1 qw2 qw3 qw4 qw5 qw6 qw7 qw8 qw9 qw10 qw11 qw12 qw13 qw14 qw15 qw16 qw17 qw18 qw19 qw20 %qw21 qw22 qw23 qw24 qw25 qw26 qw27 qw28 qw29 qw30 qw31 qw32 qw33 qw34 qw35 qw36 qw37 qw38 qw39 qw40 qw41 qw42 qw43 qw44 qw45 qw46 qw47 qw48 qw49 qw50  
    %S = [s11 s12 s13;s21 s22 s23;s31 s32 s33];
    H = [h1;h2;h3];
    
    M1 = [mx1;my1;mz1];M2 = [mx2;my2;mz2];M3 = [mx3;my3;mz3];M4 = [mx4;my4;mz4];M5 = [mx5;my5;mz5];M6 = [mx6;my6;mz6];M7 = [mx7;my7;mz7];M8 = [mx8;my8;mz8];M9 = [mx9;my9;mz9];M10 = [mx10;my10;mz10];M11 = [mx11;my11;mz11];M12 = [mx12;my12;mz12];M13 = [mx13;my13;mz13];M14 = [mx14;my14;mz14];M15 = [mx15;my15;mz15];M16 = [mx16;my16;mz16];M17 = [mx17;my17;mz17];M18 = [mx18;my18;mz18];M19 = [mx19;my19;mz19];M20 = [mx20;my20;mz20];M21=[mx21 ;my21 ;mz21]; M22=[mx22 ;my22 ;mz22];  M23=[mx23 ;my23 ;mz23]; M24=[mx24 ;my24 ;mz24]; M25=[mx25 ;my25 ;mz25]; M26=[mx26 ;my26 ;mz26]; M27=[mx27 ;my27 ;mz27];  M28=[mx28 ;my28 ;mz28];  M29=[mx29 ;my29 ;mz29];  M30=[mx30 ;my30 ;mz30];  M31=[mx31 ;my31 ;mz31];  M32=[mx32 ;my32 ;mz32];  M33=[mx33 ;my33 ;mz33];  M34=[mx34 ;my34 ;mz34];  M35=[mx35 ;my35 ;mz35];  M36=[mx36 ;my36 ;mz36];  M37=[mx37 ;my37 ;mz37];  M38=[mx38 ;my38 ;mz38];  M39=[mx39 ;my39 ;mz39];  M40=[mx40 ;my40 ;mz40];
    Q1 = [qw1 qx1 qy1 qz1];Q2 = [qw2 qx2 qy2 qz2];Q3 = [qw3 qx3 qy3 qz3];Q4 = [qw4 qx4 qy4 qz4];Q5 = [qw5 qx5 qy5 qz5];Q6 = [qw6 qx6 qy6 qz6];Q7 = [qw7 qx7 qy7 qz7];Q8 = [qw8 qx8 qy8 qz8];Q9 = [qw9 qx9 qy9 qz9];Q10 = [qw10 qx10 qy10 qz10];Q11 = [qw11 qx11 qy11 qz11];Q12 = [qw12 qx12 qy12 qz12];Q13 = [qw13 qx13 qy13 qz13];Q14 = [qw14 qx14 qy14 qz14];Q15 = [qw15 qx15 qy15 qz15];Q16 = [qw16 qx16 qy16 qz16];Q17 = [qw17 qx17 qy17 qz17];Q18 = [qw18 qx18 qy18 qz18];Q19 = [qw19 qx19 qy19 qz19];Q20 = [qw20 qx20 qy20 qz20];
    
    mc1 = [0; M1-H ];
    mc2 = mult(mult(Q1,mc1),q_inv(Q1));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M1-H, M2-H)/(norm(M1-H)*norm(M2-H)));
    l1 = 0.8*(alpha1 - alpha2)^2+1.3*norm(mc2(2:4)-(M2-H)');
    
    mc1 = [0; M3-H ];
    mc2 = mult(mult(Q2,mc1),q_inv(Q2));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M3-H, M4-H)/(norm(M3-H)*norm(M4-H)));
    l2 = 0.8*(alpha1 - alpha2)^2+1.3*norm(mc2(2:4)-(M4-H)');
    
    mc1 = [0; M5-H ];
    mc2 = mult(mult(Q3,mc1),q_inv(Q3));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M5-H, M6-H)/(norm(M5-H)*norm(M6-H)));
    l3 = 0.8*(alpha1 - alpha2)^2+1.3*norm(mc2(2:4)-(M6-H)');
    
    mc1 = [0; M7-H ];
    mc2 = mult(mult(Q4,mc1),q_inv(Q4));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M7-H, M8-H)/(norm(M7-H)*norm(M8-H)));
    l4 = 0.8*(alpha1 - alpha2)^2+1.3*norm(mc2(2:4)-(M8-H)');
    
    mc1 = [0; M9-H ];
    mc2 = mult(mult(Q5,mc1),q_inv(Q5));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M9-H, M10-H)/(norm(M9-H)*norm(M10-H)));
    l5 = 0.8*(alpha1 - alpha2)^2+1.3*norm(mc2(2:4)-(M10-H)');
    
    mc1 = [0; M11-H ];
    mc2 = mult(mult(Q6,mc1),q_inv(Q6));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M11-H, M12-H)/(norm(M11-H)*norm(M12-H)));
    l6 = 0.8*(alpha1 - alpha2)^2+1.3*norm(mc2(2:4)-(M12-H)');
    
    mc1 = [0; M13-H ];
    mc2 = mult(mult(Q7,mc1),q_inv(Q7));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M13-H, M14-H)/(norm(M13-H)*norm(M14-H)));
    l7 = 0.8*(alpha1 - alpha2)^2+1.3*norm(mc2(2:4)-(M14-H)');
    
    mc1 = [0; M15-H ];
    mc2 = mult(mult(Q8,mc1),q_inv(Q8));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M15-H, M16-H)/(norm(M15-H)*norm(M16-H)));
    l8 = 0.8*(alpha1 - alpha2)^2+1.3*norm(mc2(2:4)-(M16-H)');
    
    mc1 = [0; M17-H ];
    mc2 = mult(mult(Q9,mc1),q_inv(Q9));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M17-H, M18-H)/(norm(M17-H)*norm(M18-H)));
    l9 = 0.8*(alpha1 - alpha2)^2+1.3*norm(mc2(2:4)-(M18-H)');
    
    mc1 = [0; M19-H ];
    mc2 = mult(mult(Q10,mc1),q_inv(Q10));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M19-H, M20-H)/(norm(M19-H)*norm(M20-H)));
    l10 = 0.8*(alpha1 - alpha2)^2+1.3*norm(mc2(2:4)-(M20-H)');
    
    mc1 = [0; M21-H ];
    mc2 = mult(mult(Q11,mc1),q_inv(Q11));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M21-H, M22-H)/(norm(M21-H)*norm(M22-H)));
    l11 = (alpha1 - alpha2)^2;
    
    mc1 = [0; M23-H ];
    mc2 = mult(mult(Q12,mc1),q_inv(Q12));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M23-H, M24-H)/(norm(M23-H)*norm(M24-H)));
    l12 = (alpha1 - alpha2)^2;
    
    mc1 = [0; M25-H ];
    mc2 = mult(mult(Q13,mc1),q_inv(Q13));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M25-H, M26-H)/(norm(M25-H)*norm(M26-H)));
    l13 = (alpha1 - alpha2)^2;
    
    mc1 = [0; M27-H ];
    mc2 = mult(mult(Q14,mc1),q_inv(Q14));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M27-H, M28-H)/(norm(M27-H)*norm(M28-H)));
    l14 = (alpha1 - alpha2)^2;
    
    mc1 = [0; M29-H ];
    mc2 = mult(mult(Q15,mc1),q_inv(Q15));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M29-H, M30-H)/(norm(M29-H)*norm(M30-H)));
    l15 = (alpha1 - alpha2)^2;
    
    mc1 = [0; M31-H ];
    mc2 = mult(mult(Q16,mc1),q_inv(Q16));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M31-H, M32-H)/(norm(M31-H)*norm(M32-H)));
    l16 = (alpha1 - alpha2)^2;
    
    mc1 = [0; M33-H ];
    mc2 = mult(mult(Q17,mc1),q_inv(Q17));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M33-H, M34-H)/(norm(M33-H)*norm(M34-H)));
    l17 = (alpha1 - alpha2)^2;
    
    mc1 = [0; M35-H ];
    mc2 = mult(mult(Q18,mc1),q_inv(Q18));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M35-H, M36-H)/(norm(M35-H)*norm(M36-H)));
    l18 = (alpha1 - alpha2)^2;
    
    mc1 = [0; M37-H ];
    mc2 = mult(mult(Q19,mc1),q_inv(Q19));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M37-H, M38-H)/(norm(M37-H)*norm(M38-H)));
    l19 = (alpha1 - alpha2)^2;
    
    mc1 = [0; M39-H ];
    mc2 = mult(mult(Q20,mc1),q_inv(Q20));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(M39-H, M40-H)/(norm(M39-H)*norm(M40-H)));
    l20 = (alpha1 - alpha2)^2;
    
    L = l1+l2+l3+l4+l5+l6+l7+l8+l9+l10 ;%+ 0.000015*(h1^2+h2^2+h3^2);%+l11+l12+l13+l14+l15+l16+l17+l18+l19+l20; % 3 x 1
    %J1=jacobian(L,[h1 h2 h3]); % 3 x 12
    % Gradient 
    J = [diff(L,h1);diff(L,h2);diff(L,h3)];
    %Newton
    %J_newton = [diff(L,h1)/diff(diff(L,h1),h1);diff(L,h2)/diff(diff(L,h2),h2);diff(L,h3)/diff(diff(L,h3),h3)];
    
    delt_f = J;
%%

epsilon = 0.00003;
% xc = -200;
% yc = 150;
% zc = 30;

H_init = [-100; 230 ;60] ;%randn(3,1)*200;
H_old =  H_init;
M_input = [];
Qd_input=[];
k=1;                
for i=1:20
          m1 = M_raw(k,:); % 1  - 10      %数据不能太集中，容易陷入局部极小值
          m2 = M_raw(k+99,:);% 100 - 69     
          M_input = [M_input;m1;m2];
          qd_input = Qd(k,:);
          Qd_input =[Qd_input; qd_input];
          k = k+10;     %0 10 20 30
end

loss=[];
Loss = 1.0;
qd=Qd_input; m= M_input; 

mx1 = m(1,1); mx2 = m(2,1); mx3 = m(3,1); mx4 = m(4,1); mx5 = m(5,1); mx6 = m(6,1); mx7= m(7,1); mx8= m(8,1); mx9= m(9,1); mx10= m(10,1); mx11= m(11,1); mx12= m(12,1); mx13= m(13,1); mx14= m(14,1); mx15= m(15,1); mx16= m(16,1); mx17= m(17,1); mx18= m(18,1); mx19= m(19,1); mx20= m(20,1);mx19=m(19,1);mx20=m(20,1);%mx21=m(21,1);mx22=m(22,1);mx23=m(23,1);mx24=m(24,1);mx25=m(25,1);mx26=m(26,1);mx27=m(27,1);mx28=m(28,1);mx29=m(29,1);mx30=m(30,1);mx31=m(31,1);mx32=m(32,1);mx33=m(33,1);mx34=m(34,1);mx35=m(35,1);mx36=m(36,1);mx37=m(37,1);mx38=m(38,1);mx39=m(39,1);mx40=m(40,1);%mx41=m(41,1);
my1 = m(1,2); my2 = m(2,2); my3 = m(3,2); my4 = m(4,2); my5 = m(5,2); my6 = m(6,2); my7= m(7,2); my8= m(8,2); my9= m(9,2); my10= m(10,2); my11= m(11,2); my12= m(12,2); my13= m(13,2); my14= m(14,2); my15= m(15,2); my16 = m(16,2);my17= m(17,2); my18 = m(18,2);my19= m(19,2); my20= m(20,2);my19=m(19,2);my20=m(20,2);%my21=m(21,2);my22=m(22,2);my23=m(23,2);my24=m(24,2);my25=m(25,2);my26=m(26,2);my27=m(27,2);my28=m(28,2);my29=m(29,2);my30=m(30,2);my31=m(31,2);my32=m(32,2);my33=m(33,2);my34=m(34,2);my35=m(35,2);my36=m(36,2);my37=m(37,2);my38=m(38,2);my39=m(39,2);my40=m(40,2);%my41=m(41,2);
mz1 = m(1,3); mz2 = m(2,3); mz3 = m(3,3); mz4 = m(4,3); mz5 = m(5,3); mz6 = m(6,3); mz7= m(7,3); mz8= m(8,3); mz9= m(9,3); mz10= m(10,3); mz11= m(11,3); mz12= m(12,2); mz13= m(13,3); mz14= m(14,3); mz15= m(15,3); mz16 = m(16,3);mz17= m(17,3); mz18 = m(18,3);mz19= m(19,3); mz20= m(20,3);mz19=m(19,3);mz20=m(20,3);%mz21=m(21,3);mz22=m(22,3);mz23=m(23,3);mz24=m(24,3);mz25=m(25,3);mz26=m(26,3);mz27=m(27,3);mz28=m(28,3);mz29=m(29,3);mz30=m(30,3);mz31=m(31,3);mz32=m(32,3);mz33=m(33,3);mz34=m(34,3);mz35=m(35,3);mz36=m(36,3);mz37=m(37,3);mz38=m(38,3);mz39=m(39,3);mz40=m(40,3);%mz41=m(41,3);
    
    
qw1 = qd(1,1);	qw2= qd(2,1);	 qw3= qd(3,1);	 qw4= qd(4,1);	 qw5= qd(5,1);	 qw6= qd(6,1);	 qw7= qd(7,1);	 qw8= qd(8,1);	 qw9= qd(9,1);	 qw10= qd(10,1); % qw11= qd(11,1);	 qw12= qd(12,1);  qw13= qd(13,1);	 qw14= qd(14,1);	 qw15= qd(15,1);	 qw16= qd(16,1);	 qw17= qd(17,1);	 qw18= qd(18,1);	 qw19= qd(19,1);	 qw20= qd(20,1);
qx1 = qd(1,2);	qx2= qd(2,2);	 qx3= qd(3,2);	 qx4= qd(4,2);	 qx5= qd(5,2);	 qx6= qd(6,2);	 qx7= qd(7,2);	 qx8= qd(8,2);	 qx9= qd(9,2);	 qx10= qd(10,2); % qx11= qd(11,2);	 qx12= qd(12,2);  qx13= qd(13,2);	 qx14= qd(14,2);	 qx15= qd(15,2);	 qx16= qd(16,2);	 qx17= qd(17,2);	 qx18= qd(18,2);	 qx19= qd(19,2);	 qx20= qd(20,2);
qy1 = qd(1,3);	qy2 = qd(2,3);	qy3 = qd(3,3);	 qy4= qd(4,3);	 qy5= qd(5,3);	 qy6= qd(6,3);	 qy7= qd(7,3);	 qy8= qd(8,3);	 qy9= qd(9,3);	 qy10= qd(10,3); % qy11= qd(11,3);	 qy12= qd(12,3);  qy13= qd(13,3);	 qy14= qd(14,3);	 qy15= qd(15,3);	 qy16= qd(16,3);	 qy17= qd(17,3);	 qy18= qd(18,3);	 qy19= qd(19,3);	 qy20= qd(20,3);
qz1 = qd(1,4);	qz2= qd(2,4);	qz3 = qd(3,4);	 qz4= qd(4,4);	 qz5= qd(5,4);	 qz6= qd(6,4);	 qz7= qd(7,4);	 qz8= qd(8,4);	 qz9= qd(9,4);	 qz10= qd(10,4); % qz11 = qd(11, 4); qz12 = qd(12, 4); qz13 = qd(13, 4); qz14 = qd(14, 4);    qz15 = qd(15, 4);    qz16 = qd(16, 4); qz17 = qd(17, 4); qz18 = qd(18, 4); qz19 = qd(19, 4); qz20 = qd(20, 4); 
      
H_plot = zeros(3000,3);
figure;hold on;
%Init position
plot3(H_init(1),H_init(2),H_init(3),'*','Color',[0 0 0]);
%Target position
plot3(H0(1),H0(2),H0(3),'*','Color',[1 0 0]);
quiver3(0, 0, 0,H0(1),H0(2),H0(3));
pause(0.1);
for k = 1:1000
      %[delt_f,Loss] = Jacobian_Angle(Qd(1:10,:),M_input,H_old); %10q 20m
      tic;
      k1 = 0.0000010*k^2+0.50;
      k2 = 0.0000015*k^2+0.05;
      k3 = -0.0000025*k^2+2.5;
      gamma=[1.0*k1 0 0;0 1.0*k2 0;0 0 1.0*k3];%*double(Loss)*(-0.00000228*k+0.00050328);
       sh = H_old;
      h1 = sh(1);h2 = sh(2);h3=sh(3);
      delt_F = double(subs(delt_f));
      Loss = subs(L);
        
      %Gradient
      H_new = H_old - gamma * delt_F; 
      %Newton
      %H_new = H_old - delt_F;
      
      %[SH_new,ps] = mapminmax(double(SH_new));
      H_plot(k,:) = H_new;
      
      fprintf('The %dth iteration, min J_w = %f\n',k,Loss);
      fprintf('The delt_F =%f,%f,%f\n',delt_F(1),delt_F(2),delt_F(3));
      fprintf('The Gamma %f,%f,%f\n',gamma(1,1),gamma(2,2),gamma(3,3));
      fprintf('H_new = [%f, %f, %f]\n',H_new(1),H_new(2),H_new(3));
      loss = [loss double(Loss)];
      
      if norm(H_new-H_old) < epsilon
      H_best = H_new;
      fprintf('The best parameter:%f,%f,%f\n',H_best(1),H_best(2),H_best(3));
      break;
      end
      H_old = H_new;
      
      k=k+1;
      
      plot3(H_new(1),H_new(2),H_new(3),'.','Color',[1 0 0]);hold on
      pause(0.1);      
      toc;
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



