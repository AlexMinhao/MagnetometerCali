function L = Optfun(h)
% bias parameters
    global H_0   flag  Hp   
    if(length(h)==3 && flag ==1) 
        H = H_0;
        S = [h(1) 0 0;0 h(2) 0;0 0 h(3)];
    elseif(length(h)==12)
        H = [h(1);h(2);h(3)];
        S = [h(4) h(5) h(6);h(7) h(8) h(9);h(10) h(11) h(12)];
    else
        H = [h(1);h(2);h(3)];
        S = [1 0 0 ; 0 1 0 ; 0 0 1];
    end
% raw input data
    global  M_input Qd_input
% input
    qd=double(Qd_input); m= double(M_input);
    
    mx1 = m(1,1); mx2 = m(2,1); mx3 = m(3,1); mx4 = m(4,1); mx5 = m(5,1); mx6 = m(6,1); mx7= m(7,1); mx8= m(8,1); mx9= m(9,1); mx10= m(10,1); mx11= m(11,1); mx12= m(12,1); mx13= m(13,1); mx14= m(14,1); mx15= m(15,1); mx16= m(16,1); mx17= m(17,1); mx18= m(18,1); mx19= m(19,1); mx20= m(20,1);mx19=m(19,1);mx20=m(20,1);mx21=m(21,1);mx22=m(22,1);mx23=m(23,1);mx24=m(24,1);mx25=m(25,1);mx26=m(26,1);mx27=m(27,1);mx28=m(28,1);mx29=m(29,1);mx30=m(30,1);mx31=m(31,1);mx32=m(32,1);mx33=m(33,1);mx34=m(34,1);mx35=m(35,1);mx36=m(36,1);mx37=m(37,1);mx38=m(38,1);mx39=m(39,1);mx40=m(40,1);%mx41=m(41,1);
    my1 = m(1,2); my2 = m(2,2); my3 = m(3,2); my4 = m(4,2); my5 = m(5,2); my6 = m(6,2); my7= m(7,2); my8= m(8,2); my9= m(9,2); my10= m(10,2); my11= m(11,2); my12= m(12,2); my13= m(13,2); my14= m(14,2); my15= m(15,2); my16 = m(16,2);my17= m(17,2); my18 = m(18,2);my19= m(19,2); my20= m(20,2);my19=m(19,2);my20=m(20,2);my21=m(21,2);my22=m(22,2);my23=m(23,2);my24=m(24,2);my25=m(25,2);my26=m(26,2);my27=m(27,2);my28=m(28,2);my29=m(29,2);my30=m(30,2);my31=m(31,2);my32=m(32,2);my33=m(33,2);my34=m(34,2);my35=m(35,2);my36=m(36,2);my37=m(37,2);my38=m(38,2);my39=m(39,2);my40=m(40,2);%my41=m(41,2);
    mz1 = m(1,3); mz2 = m(2,3); mz3 = m(3,3); mz4 = m(4,3); mz5 = m(5,3); mz6 = m(6,3); mz7= m(7,3); mz8= m(8,3); mz9= m(9,3); mz10= m(10,3); mz11= m(11,3); mz12= m(12,3); mz13= m(13,3); mz14= m(14,3); mz15= m(15,3); mz16 = m(16,3);mz17= m(17,3); mz18 = m(18,3);mz19= m(19,3); mz20= m(20,3);mz19=m(19,3);mz20=m(20,3);mz21=m(21,3);mz22=m(22,3);mz23=m(23,3);mz24=m(24,3);mz25=m(25,3);mz26=m(26,3);mz27=m(27,3);mz28=m(28,3);mz29=m(29,3);mz30=m(30,3);mz31=m(31,3);mz32=m(32,3);mz33=m(33,3);mz34=m(34,3);mz35=m(35,3);mz36=m(36,3);mz37=m(37,3);mz38=m(38,3);mz39=m(39,3);mz40=m(40,3);%mz41=m(41,3);
   
    qw1 = qd(1,1);	qw2= qd(2,1);	 qw3= qd(3,1);	 qw4= qd(4,1);	 qw5= qd(5,1);	 qw6= qd(6,1);	 qw7= qd(7,1);	 qw8= qd(8,1);	 qw9= qd(9,1);	 qw10= qd(10,1);  qw11= qd(11,1);	 qw12= qd(12,1);  qw13= qd(13,1);	 qw14= qd(14,1);	 qw15= qd(15,1);	 qw16= qd(16,1);	 qw17= qd(17,1);	 qw18= qd(18,1);	 qw19= qd(19,1);	 qw20= qd(20,1);
    qx1 = qd(1,2);	qx2= qd(2,2);	 qx3= qd(3,2);	 qx4= qd(4,2);	 qx5= qd(5,2);	 qx6= qd(6,2);	 qx7= qd(7,2);	 qx8= qd(8,2);	 qx9= qd(9,2);	 qx10= qd(10,2);  qx11= qd(11,2);	 qx12= qd(12,2);  qx13= qd(13,2);	 qx14= qd(14,2);	 qx15= qd(15,2);	 qx16= qd(16,2);	 qx17= qd(17,2);	 qx18= qd(18,2);	 qx19= qd(19,2);	 qx20= qd(20,2);
    qy1 = qd(1,3);	qy2 = qd(2,3);	qy3 = qd(3,3);	 qy4= qd(4,3);	 qy5= qd(5,3);	 qy6= qd(6,3);	 qy7= qd(7,3);	 qy8= qd(8,3);	 qy9= qd(9,3);	 qy10= qd(10,3);  qy11= qd(11,3);	 qy12= qd(12,3);  qy13= qd(13,3);	 qy14= qd(14,3);	 qy15= qd(15,3);	 qy16= qd(16,3);	 qy17= qd(17,3);	 qy18= qd(18,3);	 qy19= qd(19,3);	 qy20= qd(20,3);
    qz1 = qd(1,4);	qz2= qd(2,4);	qz3 = qd(3,4);	 qz4= qd(4,4);	 qz5= qd(5,4);	 qz6= qd(6,4);	 qz7= qd(7,4);	 qz8= qd(8,4);	 qz9= qd(9,4);	 qz10= qd(10,4);  qz11 =qd(11,4);    qz12 = qd(12,4); qz13 = qd(13, 4); qz14 = qd(14, 4);    qz15 = qd(15, 4);    qz16 = qd(16, 4); qz17 = qd(17, 4); qz18 = qd(18, 4); qz19 = qd(19, 4); qz20 = qd(20, 4); 
     
    
    M1 = [mx1;my1;mz1];M2 = [mx2;my2;mz2];M3 = [mx3;my3;mz3];M4 = [mx4;my4;mz4];M5 = [mx5;my5;mz5];M6 = [mx6;my6;mz6];M7 = [mx7;my7;mz7];M8 = [mx8;my8;mz8];M9 = [mx9;my9;mz9];M10 = [mx10;my10;mz10];M11 = [mx11;my11;mz11];M12 = [mx12;my12;mz12];M13 = [mx13;my13;mz13];M14 = [mx14;my14;mz14];M15 = [mx15;my15;mz15];M16 = [mx16;my16;mz16];M17 = [mx17;my17;mz17];M18 = [mx18;my18;mz18];M19 = [mx19;my19;mz19];M20 = [mx20;my20;mz20]; M21=[mx21 ;my21 ;mz21]; M22=[mx22 ;my22 ;mz22];  M23=[mx23 ;my23 ;mz23]; M24=[mx24 ;my24 ;mz24]; M25=[mx25 ;my25 ;mz25]; M26=[mx26 ;my26 ;mz26]; M27=[mx27 ;my27 ;mz27];  M28=[mx28 ;my28 ;mz28];  M29=[mx29 ;my29 ;mz29];  M30=[mx30 ;my30 ;mz30];  M31=[mx31 ;my31 ;mz31];  M32=[mx32 ;my32 ;mz32];  M33=[mx33 ;my33 ;mz33];  M34=[mx34 ;my34 ;mz34];  M35=[mx35 ;my35 ;mz35];  M36=[mx36 ;my36 ;mz36];  M37=[mx37 ;my37 ;mz37];  M38=[mx38 ;my38 ;mz38];  M39=[mx39 ;my39 ;mz39];  M40=[mx40 ;my40 ;mz40];
    Q1 = [qw1 qx1 qy1 qz1];Q2 = [qw2 qx2 qy2 qz2];Q3 = [qw3 qx3 qy3 qz3];Q4 = [qw4 qx4 qy4 qz4];Q5 = [qw5 qx5 qy5 qz5];Q6 = [qw6 qx6 qy6 qz6];Q7 = [qw7 qx7 qy7 qz7];Q8 = [qw8 qx8 qy8 qz8];Q9 = [qw9 qx9 qy9 qz9];Q10 = [qw10 qx10 qy10 qz10]; Q11 = [qw11 qx11 qy11 qz11];Q12 = [qw12 qx12 qy12 qz12];Q13 = [qw13 qx13 qy13 qz13];Q14 = [qw14 qx14 qy14 qz14];Q15 = [qw15 qx15 qy15 qz15];Q16 = [qw16 qx16 qy16 qz16];Q17 = [qw17 qx17 qy17 qz17];Q18 = [qw18 qx18 qy18 qz18];Q19 = [qw19 qx19 qy19 qz19];Q20 = [qw20 qx20 qy20 qz20];
 
% local loss   
    mc1 = [0; inv(S)*(M1-H)]';
    mc2 = quatmultiply(quatmultiply(Q1,mc1),quatinv(Q1));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M1-H), inv(S)*(M2-H))/(norm(inv(S)*(M1-H))*norm(inv(S)*(M2-H))));
    %alpha2 = acos(dot(inv(S)*(M1-H), inv(S)*(M2-H))/(norm(inv(S)*(M1-H))*norm(inv(S)*(M2-H))));
    ccc = inv(S)*(M2-H);
    l1 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M2-H))');
    
    mc1 = [0; inv(S)*(M3-H )]';
    mc2 = quatmultiply(quatmultiply(Q2,mc1),quatinv(Q2));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M3-H ), inv(S)*(M4-H ))/(norm(inv(S)*(M3-H ))*norm(inv(S)*(M4-H ))));
    l2 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M4-H ))');
    
    mc1 = [0; inv(S)*(M5-H )]';
    mc2 = quatmultiply(quatmultiply(Q3,mc1),quatinv(Q3));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M5-H ), inv(S)*(M6-H ))/(norm(inv(S)*(M5-H ))*norm(inv(S)*(M6-H ))));
    l3 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M6-H ))');
    
    mc1 = [0; inv(S)*(M7-H )]';
    mc2 = quatmultiply(quatmultiply(Q4,mc1),quatinv(Q4));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M7-H ), inv(S)*(M8-H ))/(norm(inv(S)*(M7-H ))*norm(inv(S)*(M8-H ))));
    l4 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M8-H ))');
    
    mc1 = [0; inv(S)*(M9-H )]';
    mc2 = quatmultiply(quatmultiply(Q5,mc1),quatinv(Q5));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M9-H ), inv(S)*(M10-H ))/(norm(inv(S)*(M9-H ))*norm(inv(S)*(M10-H ))));
    c3 = inv(S)*(M9-H );
    c4 = inv(S)*(M10-H);
    l5 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M10-H ))');
    
    mc1 = [0; inv(S)*(M11-H )]';
    mc2 = quatmultiply(quatmultiply(Q6,mc1),quatinv(Q6));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M11-H ), inv(S)*(M12-H ))/(norm(inv(S)*(M11-H ))*norm(inv(S)*(M12-H ))));
    c1 = inv(S)*(M11-H );
    c2 = inv(S)*(M12-H);
    l6 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M12-H ))');
    
    mc1 = [0; inv(S)*(M13-H )]';
    mc2 = quatmultiply(quatmultiply(Q7,mc1),quatinv(Q7));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    %alpha2 = acos(dot(M13-H, M14-H)/(norm(M13-H)*norm(M14-H)));
    alpha2 = acos(dot(inv(S)*(M13-H ), inv(S)*(M14-H ))/(norm(inv(S)*(M13-H ))*norm(inv(S)*(M14-H ))));
    c5 = inv(S)*(M13-H );
    c6 = inv(S)*(M14-H);
    l7 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M14-H ))');
    
    mc1 = [0; inv(S)*(M15-H )]';
    mc2 = quatmultiply(quatmultiply(Q8,mc1),quatinv(Q8));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    %alpha2 = acos(dot(M15-H, M16-H)/(norm(M15-H)*norm(M16-H)));
    alpha2 = acos(dot(inv(S)*(M15-H ), inv(S)*(M16-H ))/(norm(inv(S)*(M15-H ))*norm(inv(S)*(M16-H ))));
    l8 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M16-H ))');
    
    mc1 = [0; inv(S)*(M17-H )]';
    mc2 = quatmultiply(quatmultiply(Q9,mc1),quatinv(Q9));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    %alpha2 = acos(dot(M17-H, M18-H)/(norm(M17-H)*norm(M18-H)));
    alpha2 = acos(dot(inv(S)*(M17-H ), inv(S)*(M18-H ))/(norm(inv(S)*(M17-H ))*norm(inv(S)*(M18-H ))));
    l9 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M18-H ))');
    
    mc1 = [0; inv(S)*(M19-H )]';
    mc2 = quatmultiply(quatmultiply(Q10,mc1),quatinv(Q10));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    %alpha2 = acos(dot(M19-H, M20-H)/(norm(M19-H)*norm(M20-H)));
    alpha2 = acos(dot(inv(S)*(M19-H), inv(S)*(M20-H))/(norm(inv(S)*(M19-H))*norm(inv(S)*(M20-H))));
    l10 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M20-H))');
    
    mc1 = [0; inv(S)*(M21-H)]';
    mc2 = quatmultiply(quatmultiply(Q11,mc1),quatinv(Q11));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M21-H), inv(S)*(M22-H))/(norm(inv(S)*(M21-H))*norm(inv(S)*(M22-H))));
    ccc = inv(S)*(M2-H);
    l11 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M22-H))');
    
    mc1 = [0; inv(S)*(M23-H )]';
    mc2 = quatmultiply(quatmultiply(Q12,mc1),quatinv(Q12));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M23-H ), inv(S)*(M24-H ))/(norm(inv(S)*(M23-H ))*norm(inv(S)*(M24-H ))));
    l12 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M24-H ))');
    
    mc1 = [0; inv(S)*(M25-H )]';
    mc2 = quatmultiply(quatmultiply(Q13,mc1),quatinv(Q13));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M25-H ), inv(S)*(M26-H ))/(norm(inv(S)*(M25-H ))*norm(inv(S)*(M26-H ))));
    l13 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M26-H ))');
    
    mc1 = [0; inv(S)*(M27-H )]';
    mc2 = quatmultiply(quatmultiply(Q14,mc1),quatinv(Q14));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M27-H ), inv(S)*(M28-H ))/(norm(inv(S)*(M27-H ))*norm(inv(S)*(M28-H ))));
    l14 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M28-H ))');
    
    mc1 = [0; inv(S)*(M29-H )]';
    mc2 = quatmultiply(quatmultiply(Q15,mc1),quatinv(Q15));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M29-H ), inv(S)*(M30-H ))/(norm(inv(S)*(M29-H ))*norm(inv(S)*(M30-H ))));
    l15 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M10-H ))');
    
    mc1 = [0; inv(S)*(M31-H )]';
    mc2 = quatmultiply(quatmultiply(Q16,mc1),quatinv(Q16));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    alpha2 = acos(dot(inv(S)*(M31-H ), inv(S)*(M32-H ))/(norm(inv(S)*(M31-H ))*norm(inv(S)*(M32-H ))));
    l16 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M32-H ))');
    
    mc1 = [0; inv(S)*(M33-H )]';
    mc2 = quatmultiply(quatmultiply(Q17,mc1),quatinv(Q17));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    %alpha2 = acos(dot(M13-H, M14-H)/(norm(M13-H)*norm(M14-H)));
    alpha2 = acos(dot(inv(S)*(M33-H ), inv(S)*(M34-H ))/(norm(inv(S)*(M33-H ))*norm(inv(S)*(M34-H ))));
    l17 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M34-H ))');
    
    mc1 = [0; inv(S)*(M35-H )]';
    mc2 = quatmultiply(quatmultiply(Q18,mc1),quatinv(Q18));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    %alpha2 = acos(dot(M15-H, M16-H)/(norm(M15-H)*norm(M16-H)));
    alpha2 = acos(dot(inv(S)*(M35-H ), inv(S)*(M36-H ))/(norm(inv(S)*(M35-H ))*norm(inv(S)*(M36-H ))));
    l18 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M36-H ))');
    
    mc1 = [0; inv(S)*(M37-H )]';
    mc2 = quatmultiply(quatmultiply(Q19,mc1),quatinv(Q19));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    %alpha2 = acos(dot(M17-H, M18-H)/(norm(M17-H)*norm(M18-H)));
    alpha2 = acos(dot(inv(S)*(M37-H ), inv(S)*(M38-H ))/(norm(inv(S)*(M37-H ))*norm(inv(S)*(M38-H ))));
    l19 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M38-H ))');
    
    mc1 = [0; inv(S)*(M39-H )]';
    mc2 = quatmultiply(quatmultiply(Q20,mc1),quatinv(Q20));
    alpha1 = acos(dot(mc1(2:4),mc2(2:4))/(norm(mc1(2:4))*norm(mc2(2:4))));
    %alpha2 = acos(dot(M19-H, M20-H)/(norm(M19-H)*norm(M20-H)));
    alpha2 = acos(dot(inv(S)*(M39-H), inv(S)*(M40-H))/(norm(inv(S)*(M39-H))*norm(inv(S)*(M40-H))));
    l20 = 0.6*(alpha1 - alpha2)^2+0.4*norm(mc2(2:4)-(inv(S)*(M40-H))');
      
% Loss function
    if(length(h)>3)
        L = l1+l2+l3+l4+l5+l6+l7+l8+l9+l10+l11+l12+l13+l14+l15+l16+l17+l18+l19+l20;%+0.000015*(h(1)^2+h(2)^2+h(3)^2)+h(4)^2+h(5)^2+h(6)^2+h(7)^2+h(8)^2+h(9)^2+h(10)^2+h(11)^2+h(12)^2;
    else
        L = l1+l2+l3+l4+l5+l6+l7+l8+l9+l10+l11+l12+l13+l14+l15+l16+l17+l18+l19+l20;%+0.000015*(h(1)^2+h(2)^2+h(3)^2);
    end
    
    
    
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